"""
Shared infrastructure — database, vector store, and knowledge base.

Imported by registry.py and edgeos.py so both reference the same instances.

- local_db  : SQLite file (edgeos.db) — agent sessions, memory, and state.
              Zero-latency; lives on disk; per-user and not committed to git.
- neon_db   : NeonDB (PostgreSQL) — AgentOS Studio components and shared knowledge.
- vector_db : PgVector on Neon — knowledge embeddings.
- knowledge : Shared knowledge base backed by neon_db + vector_db.

Requires DB_URL in the environment (loaded from .env before this module is imported).
"""

import os

from agno.db.postgres import PostgresDb
from agno.db.sqlite import SqliteDb
from agno.knowledge.knowledge import Knowledge
from agno.vectordb.pgvector import PgVector

db_url = os.environ.get("DB_URL") or os.environ.get("DATABASE_URL")
if not db_url:
    raise RuntimeError(
        "DB_URL (or DATABASE_URL) is not set. Copy .env.example to .env and fill in your Neon connection string."
    )
# Ensure the psycopg3 driver prefix is present
if not db_url.startswith("postgresql+psycopg"):
    # Strip any existing scheme and re-apply the correct one
    rest = db_url.split("://", 1)[1]
    db_url = "postgresql+psycopg://" + rest

# Local SQLite — agent sessions, memory, and per-user state (no network round-trip)
local_db = SqliteDb(db_file="edgeos.db", id="local")

# Shared Neon PostgreSQL — AgentOS Studio components and knowledge corpus
neon_db = PostgresDb(db_url=db_url, id="neon")

vector_db = PgVector(
    db_url=db_url,
    table_name="agno_docs",
)

knowledge = Knowledge(
    name="Agno Docs",
    contents_db=neon_db,
    vector_db=vector_db,
)
