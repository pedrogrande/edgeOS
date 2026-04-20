"""
Shared infrastructure — database, vector store, and knowledge base.

Imported by registry.py and edgeos.py so both reference the same instances.

- local_db       : SQLite file (edgeos.db) — agent sessions, memory, and state.
                   Zero-latency; lives on disk; per-user and not committed to git.
- local_postgres  : Local PostgreSQL (Docker) — offline-first primary DB.
                   Used when LOCAL_DB_URL is set; falls back to neon_db.
- neon_db         : NeonDB (PostgreSQL) — AgentOS Studio components and shared knowledge.
- vector_db       : PgVector on Neon — knowledge embeddings.
- knowledge       : Shared knowledge base backed by neon_db + vector_db.

Bidirectional sync between local_postgres and neon_db:
  Neon → Local:  PostgreSQL logical replication (sub_from_neon)
  Local → Neon:  Pull-based sync (sync-to-neon.py) — no tunnel needed

When offline, local_postgres is used exclusively; changes sync when reconnected.

Requires DB_URL in the environment (loaded from .env before this module is imported).
LOCAL_DB_URL is optional — when set, local Postgres becomes the primary DB.
"""

import os
import logging

from agno.db.postgres import PostgresDb
from agno.db.sqlite import SqliteDb
from agno.knowledge.knowledge import Knowledge
from agno.vectordb.pgvector import PgVector

logger = logging.getLogger(__name__)


def _ensure_psycopg_prefix(url: str) -> str:
    """Ensure a PostgreSQL URL uses the psycopg3 driver prefix."""
    if not url.startswith("postgresql+psycopg"):
        rest = url.split("://", 1)[1]
        return f"postgresql+psycopg://{rest}"
    return url


def _test_connection(url: str, timeout: float = 3.0) -> bool:
    """Test if a PostgreSQL connection is reachable."""
    import psycopg

    plain_url = url.replace("postgresql+psycopg://", "postgresql://")
    try:
        with psycopg.connect(plain_url, connect_timeout=timeout) as conn:
            with conn.cursor() as cur:
                cur.execute("SELECT 1")
                return True
    except Exception:
        return False


# ── Neon (cloud) database — always required ─────────────────────────────────
db_url = os.environ.get("DB_URL") or os.environ.get("DATABASE_URL")
if not db_url:
    raise RuntimeError(
        "DB_URL (or DATABASE_URL) is not set. Copy .env.example to .env and fill in your Neon connection string."
    )
db_url = _ensure_psycopg_prefix(db_url)

# Local SQLite — agent sessions, memory, and per-user state (no network round-trip)
local_db = SqliteDb(db_file="edgeos.db", id="local")

# Shared Neon PostgreSQL — AgentOS Studio components and knowledge corpus
neon_db = PostgresDb(db_url=db_url, id="neon")

# ── Local PostgreSQL (Docker) — offline-first primary DB ────────────────────
local_postgres = None
local_vector_db = None
_use_local_postgres = False

local_db_url = os.environ.get("LOCAL_DB_URL")
if local_db_url:
    local_db_url = _ensure_psycopg_prefix(local_db_url)
    if _test_connection(local_db_url):
        local_postgres = PostgresDb(db_url=local_db_url, id="local_postgres")
        local_vector_db = PgVector(db_url=local_db_url, table_name="agno_docs")
        _use_local_postgres = True
        logger.info("Local PostgreSQL is available — using as primary DB")
    else:
        logger.warning(
            "LOCAL_DB_URL is set but local Postgres is not reachable. "
            "Falling back to Neon. Start local Postgres with: docker compose up -d"
        )

# ── Primary DB selection ─────────────────────────────────────────────────────
# When local Postgres is available, use it as primary for fast reads/writes.
# Bidirectional replication keeps it in sync with Neon.
# When offline, local Postgres is the only option; changes sync on reconnect.
primary_db = local_postgres if _use_local_postgres else neon_db

# Vector DB: use local when available, Neon otherwise
primary_vector_db = local_vector_db if _use_local_postgres else None

# Neon vector DB — always available (used as fallback or when local isn't set up)
vector_db = PgVector(
    db_url=db_url,
    table_name="agno_docs",
)

knowledge = Knowledge(
    name="Agno Docs",
    contents_db=primary_db,
    vector_db=primary_vector_db or vector_db,
)
