#!/usr/bin/env python3
"""
EdgeOS Pull-Based Sync: Local Postgres → Neon Cloud

Replaces the need for a tunnel (ngrok/Tailscale) for bidirectional replication.
Instead of Neon subscribing to local_pub (which requires Neon to reach us),
this script polls local changes and pushes them to Neon.

Direction:
  Neon → Local:  PostgreSQL logical replication (sub_from_neon) — already working
  Local → Neon:  This script (poll + push) — no tunnel needed

Conflict resolution: Last-write-wins (compares updated_at timestamps).

Usage:
  # One-shot sync
  python scripts/sync-to-neon.py --once

  # Continuous sync (runs in Docker sidecar)
  python scripts/sync-to-neon.py --loop --interval 5

  # Verbose mode (shows per-table details)
  python scripts/sync-to-neon.py --once --verbose

Requires LOCAL_DB_URL and DB_URL in .env.
"""

import argparse
import json
import logging
import os
import sys
import time
from typing import Any, Dict, List, Optional, Tuple

# Ensure project root is on the path
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from dotenv import load_dotenv

load_dotenv()

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    datefmt="%H:%M:%S",
)
logger = logging.getLogger("sync-to-neon")

# ── Configuration ────────────────────────────────────────────────────────────

# Agno tables to sync (table_name, primary_key_columns, has_updated_at)
# All tables use the `ai` schema and have `updated_at` (BigInteger epoch seconds)
SYNC_TABLES: List[Dict[str, Any]] = [
    {"table": "agno_sessions", "pk": ["session_id"], "has_updated_at": True},
    {"table": "agno_memories", "pk": ["memory_id"], "has_updated_at": True},
    {"table": "agno_knowledge", "pk": ["id"], "has_updated_at": True},
    {"table": "agno_docs", "pk": ["id"], "has_updated_at": True},
    {"table": "agno_components", "pk": ["component_id"], "has_updated_at": True},
    {
        "table": "agno_component_configs",
        "pk": ["component_id", "version"],
        "has_updated_at": True,
    },
    {
        "table": "agno_component_links",
        "pk": ["parent_component_id", "parent_version", "link_kind", "link_key"],
        "has_updated_at": True,
    },
    {"table": "agno_approvals", "pk": ["id"], "has_updated_at": True},
    {"table": "agno_eval_runs", "pk": ["run_id"], "has_updated_at": True},
    {"table": "agno_learnings", "pk": ["learning_id"], "has_updated_at": True},
    {"table": "agno_metrics", "pk": ["id"], "has_updated_at": True},
    {"table": "agno_schedules", "pk": ["id"], "has_updated_at": True},
    {"table": "agno_schedule_runs", "pk": ["id"], "has_updated_at": False},
    {"table": "agno_schema_versions", "pk": ["table_name"], "has_updated_at": True},
    {
        "table": "agno_assist_knowledge_contents",
        "pk": ["id"],
        "has_updated_at": True,
    },
    {
        "table": "agno_assist_knowledge_vectors",
        "pk": ["id"],
        "has_updated_at": True,
    },
    {"table": "knowledge_vectors", "pk": ["id"], "has_updated_at": True},
]

# Tables that support soft-delete (have a deleted_at column)
SOFT_DELETE_TABLES = {"agno_components", "agno_component_configs"}

# State tracking tables (created in ai schema)
SYNC_STATE_TABLE = "ai._sync_state"
SYNC_DELETES_TABLE = "ai._sync_deletes"


# ── Database helpers ─────────────────────────────────────────────────────────


def _ensure_psycopg_prefix(url: str) -> str:
    """Ensure a PostgreSQL URL uses the psycopg3 driver prefix."""
    if not url.startswith("postgresql+psycopg"):
        rest = url.split("://", 1)[1]
        return f"postgresql+psycopg://{rest}"
    return url


def _plain_url(url: str) -> str:
    """Convert to plain postgresql:// URL for psycopg connections."""
    return _ensure_psycopg_prefix(url).replace("postgresql+psycopg://", "postgresql://")


def get_db_urls() -> Tuple[str, str]:
    """Get and validate database URLs from environment."""
    local_url = os.environ.get("LOCAL_DB_URL")
    neon_url = os.environ.get("DB_URL") or os.environ.get("DATABASE_URL")

    if not local_url:
        logger.error("LOCAL_DB_URL is not set. Set it in .env or environment.")
        sys.exit(1)
    if not neon_url:
        logger.error("DB_URL is not set. Set it in .env or environment.")
        sys.exit(1)

    return _ensure_psycopg_prefix(local_url), _ensure_psycopg_prefix(neon_url)


# ── State management ─────────────────────────────────────────────────────────


def ensure_sync_tables(conn) -> None:
    """Create sync state and deletes tracking tables if they don't exist."""
    with conn.cursor() as cur:
        # Sync state: tracks last synced updated_at per table
        cur.execute(
            f"""
            CREATE TABLE IF NOT EXISTS {SYNC_STATE_TABLE} (
                table_name TEXT PRIMARY KEY,
                last_synced_at BIGINT NOT NULL DEFAULT 0,
                last_sync_time TIMESTAMPTZ NOT NULL DEFAULT NOW(),
                rows_synced BIGINT NOT NULL DEFAULT 0
            );
        """
        )

        # Sync deletes log: tracks rows deleted locally that need to be
        # propagated to Neon. Populated by a trigger on each Agno table.
        cur.execute(
            f"""
            CREATE TABLE IF NOT EXISTS {SYNC_DELETES_TABLE} (
                id SERIAL PRIMARY KEY,
                table_name TEXT NOT NULL,
                pk_values JSONB NOT NULL,
                deleted_at BIGINT NOT NULL DEFAULT 0,
                synced BOOLEAN NOT NULL DEFAULT FALSE,
                created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
            );
        """
        )

        # Create index for fast unsynced deletes lookup
        cur.execute(
            f"""
            CREATE INDEX IF NOT EXISTS idx_sync_deletes_unsynced
            ON {SYNC_DELETES_TABLE} (table_name, synced)
            WHERE synced = FALSE;
        """
        )
    conn.commit()


def ensure_delete_triggers(conn) -> None:
    """Create DELETE triggers on all Agno tables to log deletions.

    When a row is deleted from a local table, the trigger inserts a record
    into _sync_deletes so the sync script can propagate the delete to Neon.
    """
    with conn.cursor() as cur:
        for table_info in SYNC_TABLES:
            table_name = table_info["table"]
            pk_cols = table_info["pk"]
            full_table = f"ai.{table_name}"

            # Skip soft-delete tables — they use deleted_at, not actual DELETE
            if table_name in SOFT_DELETE_TABLES:
                continue

            # Check if table actually exists before creating trigger
            cur.execute(
                """
                SELECT EXISTS (
                    SELECT FROM information_schema.tables
                    WHERE table_schema = 'ai' AND table_name = %s
                );
            """,
                (table_name,),
            )
            if not cur.fetchone()[0]:
                continue

            trigger_name = f"_sync_log_delete_{table_name}"
            function_name = f"_sync_log_delete_fn_{table_name}"

            # Build the OLD.pk_values JSONB expression
            pk_json_parts = ", ".join(f"'{col}', OLD.{col}" for col in pk_cols)
            pk_json = f"jsonb_build_object({pk_json_parts})"

            # Create the trigger function
            cur.execute(
                f"""
                CREATE OR REPLACE FUNCTION {function_name}()
                RETURNS TRIGGER AS $$
                BEGIN
                    INSERT INTO {SYNC_DELETES_TABLE} (table_name, pk_values, deleted_at)
                    VALUES (
                        '{table_name}',
                        {pk_json},
                        EXTRACT(EPOCH FROM NOW())::BIGINT
                    );
                    RETURN OLD;
                END;
                $$ LANGUAGE plpgsql;
            """
            )

            # Create the trigger (DROP IF EXISTS first for idempotency)
            cur.execute(
                f"""
                DROP TRIGGER IF EXISTS {trigger_name} ON {full_table};
                CREATE TRIGGER {trigger_name}
                AFTER DELETE ON {full_table}
                FOR EACH ROW EXECUTE FUNCTION {function_name}();
            """
            )

    conn.commit()


def get_last_synced_at(conn, table_name: str) -> int:
    """Get the last synced updated_at timestamp for a table."""
    with conn.cursor() as cur:
        cur.execute(
            f"SELECT last_synced_at FROM {SYNC_STATE_TABLE} WHERE table_name = %s",
            (table_name,),
        )
        row = cur.fetchone()
        return row[0] if row else 0


def update_sync_state(
    conn, table_name: str, last_synced_at: int, rows_synced: int
) -> None:
    """Update the sync state for a table."""
    with conn.cursor() as cur:
        cur.execute(
            f"""
            INSERT INTO {SYNC_STATE_TABLE} (table_name, last_synced_at, last_sync_time, rows_synced)
            VALUES (%s, %s, NOW(), %s)
            ON CONFLICT (table_name)
            DO UPDATE SET
                last_synced_at = EXCLUDED.last_synced_at,
                last_sync_time = EXCLUDED.last_sync_time,
                rows_synced = {SYNC_STATE_TABLE}.rows_synced + EXCLUDED.rows_synced;
            """,
            (table_name, last_synced_at, rows_synced),
        )
    conn.commit()


# ── Sync logic ───────────────────────────────────────────────────────────────


def get_table_columns(conn, table_name: str) -> List[str]:
    """Get column names for a table in the ai schema."""
    with conn.cursor() as cur:
        cur.execute(
            """
            SELECT column_name FROM information_schema.columns
            WHERE table_schema = 'ai' AND table_name = %s
            ORDER BY ordinal_position;
        """,
            (table_name,),
        )
        return [row[0] for row in cur.fetchall()]


def sync_table(local_conn, neon_conn, table_info: Dict) -> int:
    """Sync changed rows from local to Neon for a single table.

    Returns the number of rows synced.
    """
    table_name = table_info["table"]
    pk_cols = table_info["pk"]
    has_updated_at = table_info["has_updated_at"]

    # Get columns that exist on BOTH sides
    local_cols = get_table_columns(local_conn, table_name)
    neon_cols = get_table_columns(neon_conn, table_name)
    common_cols = [c for c in local_cols if c in neon_cols]

    if not common_cols:
        logger.debug(f"  {table_name}: no common columns, skipping")
        return 0

    # For tables with updated_at, find changes since last sync
    if has_updated_at and "updated_at" in common_cols:
        last_synced = get_last_synced_at(local_conn, table_name)
        # Subtract 2 seconds to handle clock skew and concurrent writes
        since = max(0, last_synced - 2)

        with local_conn.cursor() as cur:
            cur.execute(
                f"""
                SELECT {', '.join(common_cols)}
                FROM ai.{table_name}
                WHERE updated_at > %s
                ORDER BY updated_at ASC
                LIMIT 500;
            """,
                (since,),
            )
            rows = cur.fetchall()
    else:
        # For tables without updated_at (e.g., schedule_runs), skip by default
        # These are typically append-only and synced via replication
        logger.debug(f"  {table_name}: no updated_at column, skipping")
        return 0

    if not rows:
        logger.debug(f"  {table_name}: no changes")
        return 0

    # Build upsert statement for Neon
    col_list = ", ".join(common_cols)
    pk_list = ", ".join(pk_cols)
    # Update all non-PK, non-created_at columns on conflict
    update_cols = [c for c in common_cols if c not in pk_cols and c != "created_at"]
    update_set = ", ".join(f"{c} = EXCLUDED.{c}" for c in update_cols)

    if not update_set:
        # No columns to update on conflict — just do INSERT ON CONFLICT DO NOTHING
        upsert_sql = f"""
            INSERT INTO ai.{table_name} ({col_list})
            VALUES ({', '.join(['%s'] * len(common_cols))})
            ON CONFLICT ({pk_list}) DO NOTHING
        """
    else:
        upsert_sql = f"""
            INSERT INTO ai.{table_name} ({col_list})
            VALUES ({', '.join(['%s'] * len(common_cols))})
            ON CONFLICT ({pk_list}) DO UPDATE SET {update_set}
        """

    # Execute upserts in batches
    synced = 0
    batch_size = 50
    with neon_conn.cursor() as cur:
        for i in range(0, len(rows), batch_size):
            batch = rows[i : i + batch_size]
            try:
                for row in batch:
                    cur.execute(upsert_sql, row)
                neon_conn.commit()
                synced += len(batch)
            except Exception as e:
                neon_conn.rollback()
                logger.warning(f"  {table_name}: batch {i // batch_size} failed: {e}")
                # Try rows individually to isolate bad data
                for row in batch:
                    try:
                        cur.execute(upsert_sql, row)
                        neon_conn.commit()
                        synced += 1
                    except Exception as e2:
                        neon_conn.rollback()
                        logger.debug(f"  {table_name}: row failed: {e2}")

    # Update sync state
    if has_updated_at and rows:
        updated_at_idx = common_cols.index("updated_at")
        max_updated_at = max(
            row[updated_at_idx] for row in rows if row[updated_at_idx] is not None
        )
        update_sync_state(local_conn, table_name, max_updated_at, synced)

    logger.info(f"  {table_name}: synced {synced} rows")
    return synced


def sync_deletes(local_conn, neon_conn) -> int:
    """Propagate local deletes to Neon.

    Returns the number of deletes synced.
    """
    synced = 0

    with local_conn.cursor() as cur:
        cur.execute(
            f"""
            SELECT id, table_name, pk_values, deleted_at
            FROM {SYNC_DELETES_TABLE}
            WHERE synced = FALSE
            ORDER BY deleted_at ASC
            LIMIT 200;
        """
        )
        deletes = cur.fetchall()

    if not deletes:
        return 0

    for delete_id, table_name, pk_values, deleted_at in deletes:
        # Find the table info
        table_info = next((t for t in SYNC_TABLES if t["table"] == table_name), None)
        if not table_info:
            continue

        pk_cols = table_info["pk"]
        pk_dict = pk_values if isinstance(pk_values, dict) else json.loads(pk_values)

        # Build DELETE statement
        where_parts = []
        where_values = []
        for pk_col in pk_cols:
            where_parts.append(f"{pk_col} = %s")
            where_values.append(pk_dict.get(pk_col))

        if not where_parts:
            continue

        where_clause = " AND ".join(where_parts)
        delete_sql = f"DELETE FROM ai.{table_name} WHERE {where_clause}"

        try:
            with neon_conn.cursor() as cur:
                cur.execute(delete_sql, where_values)
            neon_conn.commit()

            # Mark as synced
            with local_conn.cursor() as cur:
                cur.execute(
                    f"UPDATE {SYNC_DELETES_TABLE} SET synced = TRUE WHERE id = %s",
                    (delete_id,),
                )
            local_conn.commit()
            synced += 1
        except Exception as e:
            neon_conn.rollback()
            logger.debug(f"  Delete failed for {table_name} {pk_dict}: {e}")

    if synced:
        logger.info(f"  Deletes: synced {synced} deletions")
    return synced


def sync_soft_deletes(local_conn, neon_conn) -> int:
    """Propagate soft-deletes (deleted_at set) for tables that use them.

    For soft-delete tables, we don't actually DELETE rows — we set deleted_at.
    The regular sync_table() already handles this via upsert, but we also
    check for rows that were soft-deleted locally but not yet on Neon.
    """
    synced = 0
    for table_name in SOFT_DELETE_TABLES:
        table_info = next((t for t in SYNC_TABLES if t["table"] == table_name), None)
        if not table_info:
            continue

        pk_cols = table_info["pk"]

        # Check table exists locally
        with local_conn.cursor() as cur:
            cur.execute(
                """
                SELECT EXISTS (
                    SELECT FROM information_schema.tables
                    WHERE table_schema = 'ai' AND table_name = %s
                );
            """,
                (table_name,),
            )
            if not cur.fetchone()[0]:
                continue

        # Find locally soft-deleted rows
        with local_conn.cursor() as cur:
            cur.execute(
                f"""
                SELECT {', '.join(pk_cols)}, deleted_at
                FROM ai.{table_name}
                WHERE deleted_at IS NOT NULL;
            """
            )
            local_deleted = cur.fetchall()

        if not local_deleted:
            continue

        # Check which of these are NOT deleted on Neon
        for row in local_deleted:
            pk_values = row[: len(pk_cols)]
            deleted_at_val = row[len(pk_cols)]

            where_parts = [f"{pk} = %s" for pk in pk_cols]
            where_clause = " AND ".join(where_parts)

            try:
                with neon_conn.cursor() as cur:
                    cur.execute(
                        f"SELECT deleted_at FROM ai.{table_name} WHERE {where_clause}",
                        pk_values,
                    )
                    neon_row = cur.fetchone()

                    if neon_row and neon_row[0] is None:
                        # Row exists on Neon but isn't soft-deleted — update it
                        cur.execute(
                            f"UPDATE ai.{table_name} SET deleted_at = %s WHERE {where_clause}",
                            [deleted_at_val] + list(pk_values),
                        )
                        neon_conn.commit()
                        synced += 1
            except Exception as e:
                neon_conn.rollback()
                logger.debug(f"  Soft-delete check failed for {table_name}: {e}")

    if synced:
        logger.info(f"  Soft-deletes: synced {synced}")
    return synced


def run_sync(local_url: str, neon_url: str) -> Dict[str, int]:
    """Run one sync cycle. Returns stats."""
    import psycopg

    stats = {"upserts": 0, "deletes": 0, "soft_deletes": 0, "errors": 0}

    try:
        local_plain = _plain_url(local_url)
        neon_plain = _plain_url(neon_url)

        with psycopg.connect(local_plain) as local_conn, psycopg.connect(
            neon_plain
        ) as neon_conn:

            # Ensure sync tracking tables exist
            ensure_sync_tables(local_conn)
            ensure_delete_triggers(local_conn)

            # Check which tables actually exist locally
            with local_conn.cursor() as cur:
                cur.execute(
                    "SELECT table_name FROM information_schema.tables WHERE table_schema = 'ai'"
                )
                existing_tables = {row[0] for row in cur.fetchall()}

            # Sync each table
            for table_info in SYNC_TABLES:
                if table_info["table"] not in existing_tables:
                    logger.debug(
                        f"  {table_info['table']}: doesn't exist yet, skipping"
                    )
                    continue

                try:
                    synced = sync_table(local_conn, neon_conn, table_info)
                    stats["upserts"] += synced
                except Exception as e:
                    logger.warning(f"  {table_info['table']}: sync error: {e}")
                    stats["errors"] += 1

            # Sync deletes
            try:
                stats["deletes"] += sync_deletes(local_conn, neon_conn)
            except Exception as e:
                logger.warning(f"  Delete sync error: {e}")
                stats["errors"] += 1

            # Sync soft-deletes
            try:
                stats["soft_deletes"] += sync_soft_deletes(local_conn, neon_conn)
            except Exception as e:
                logger.warning(f"  Soft-delete sync error: {e}")
                stats["errors"] += 1

    except Exception as e:
        logger.error(f"Sync cycle failed: {e}")
        stats["errors"] += 1

    return stats


# ── Main ─────────────────────────────────────────────────────────────────────


def main():
    parser = argparse.ArgumentParser(description="EdgeOS Local → Neon sync")
    parser.add_argument(
        "--loop", action="store_true", help="Run continuously (Docker sidecar mode)"
    )
    parser.add_argument(
        "--interval",
        type=int,
        default=5,
        help="Seconds between sync cycles (default: 5)",
    )
    parser.add_argument(
        "--once", action="store_true", help="Run one sync cycle and exit"
    )
    parser.add_argument("--verbose", action="store_true", help="Enable debug logging")
    args = parser.parse_args()

    if args.verbose:
        logging.getLogger().setLevel(logging.DEBUG)

    local_url, neon_url = get_db_urls()

    if args.once or not args.loop:
        logger.info("Running one-shot sync...")
        stats = run_sync(local_url, neon_url)
        logger.info(
            f"Sync complete: {stats['upserts']} upserts, "
            f"{stats['deletes']} deletes, "
            f"{stats['soft_deletes']} soft-deletes, "
            f"{stats['errors']} errors"
        )
        sys.exit(0 if stats["errors"] == 0 else 1)

    # Continuous mode
    logger.info(f"Starting continuous sync (interval={args.interval}s)...")
    cycle = 0
    while True:
        cycle += 1
        try:
            stats = run_sync(local_url, neon_url)
            total = stats["upserts"] + stats["deletes"] + stats["soft_deletes"]
            if total > 0 or stats["errors"] > 0:
                logger.info(
                    f"Cycle {cycle}: "
                    f"{stats['upserts']}↑ "
                    f"{stats['deletes']}✗ "
                    f"{stats['soft_deletes']}⊘ "
                    f"{stats['errors']}⚠"
                )
        except KeyboardInterrupt:
            logger.info("Sync stopped by user")
            break
        except Exception as e:
            logger.error(f"Cycle {cycle} error: {e}")

        time.sleep(args.interval)


if __name__ == "__main__":
    main()
