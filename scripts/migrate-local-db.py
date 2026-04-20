#!/usr/bin/env python3
"""
Migrate Agno schema to the local PostgreSQL database.

Creates all required tables in the `ai` schema on the local Postgres instance.
This must run BEFORE setting up bidirectional replication, because both sides
need identical table structures.

Usage:
    python scripts/migrate-local-db.py

Requires LOCAL_DB_URL in .env or environment.
"""

import os
import sys

# Ensure project root is on the path
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from dotenv import load_dotenv

load_dotenv()

from agno.db.postgres import PostgresDb
from agno.knowledge.knowledge import Knowledge
from agno.vectordb.pgvector import PgVector


def get_local_db_url() -> str:
    """Get and validate the local database URL."""
    db_url = os.environ.get("LOCAL_DB_URL")
    if not db_url:
        print("ERROR: LOCAL_DB_URL is not set.")
        print("  Copy .env.example to .env and fill in LOCAL_DB_URL.")
        sys.exit(1)

    # Ensure psycopg3 driver prefix
    if not db_url.startswith("postgresql+psycopg"):
        rest = db_url.split("://", 1)[1]
        db_url = "postgresql+psycopg://" + rest

    return db_url


def migrate_schema(db_url: str) -> None:
    """Run Agno schema migrations on the local database."""
    print("Creating Agno schema on local Postgres...")

    # Create PostgresDb instance — this auto-creates tables on first use
    local_db = PostgresDb(db_url=db_url, id="local_postgres")

    # Force table creation by touching the db
    try:
        local_db.create()
        print("✓ Agno schema tables created successfully")
    except Exception as e:
        print(f"✓ Tables may already exist: {e}")

    # Also set up PgVector table for knowledge embeddings
    print("Creating PgVector table for knowledge embeddings...")
    vector_db = PgVector(db_url=db_url, table_name="agno_docs")
    try:
        vector_db.create()
        print("✓ PgVector table created successfully")
    except Exception as e:
        print(f"✓ Vector table may already exist: {e}")

    # Also create the knowledge contents table
    print("Creating knowledge tables...")
    knowledge_db = PostgresDb(db_url=db_url, id="local_postgres_knowledge")
    try:
        knowledge_db.create()
        print("✓ Knowledge tables created successfully")
    except Exception as e:
        print(f"✓ Knowledge tables may already exist: {e}")


def verify_schema(db_url: str) -> None:
    """Verify that all expected Agno tables exist in the ai schema."""
    import psycopg

    # Convert to plain psycopg URL for direct SQL
    plain_url = db_url.replace("postgresql+psycopg://", "postgresql://")

    with psycopg.connect(plain_url) as conn:
        with conn.cursor() as cur:
            cur.execute(
                """
                SELECT table_name FROM information_schema.tables
                WHERE table_schema = 'ai'
                ORDER BY table_name;
            """
            )
            tables = [row[0] for row in cur.fetchall()]

    expected = [
        "agno_approvals",
        "agno_assist_knowledge_contents",
        "agno_assist_knowledge_vectors",
        "agno_component_configs",
        "agno_component_links",
        "agno_components",
        "agno_docs",
        "agno_eval_runs",
        "agno_knowledge",
        "agno_learnings",
        "agno_memories",
        "agno_metrics",
        "agno_schedule_runs",
        "agno_schedules",
        "agno_schema_versions",
        "agno_sessions",
        "knowledge_vectors",
    ]

    print(f"\nFound {len(tables)} tables in ai schema:")
    for t in tables:
        print(f"  ✓ ai.{t}")

    missing = set(expected) - set(tables)
    if missing:
        print(f"\n⚠ Missing tables: {', '.join(sorted(missing))}")
        print("  Run EdgeOS once to create remaining tables, then re-run this script.")
    else:
        print("\n✓ All expected Agno tables present!")


def main() -> None:
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("  EdgeOS Local DB Migration")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")

    db_url = get_local_db_url()
    print(f"Connecting to: {db_url.split('@')[1] if '@' in db_url else '(local)'}\n")

    migrate_schema(db_url)
    verify_schema(db_url)

    print("\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("  Migration complete!")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")


if __name__ == "__main__":
    main()
