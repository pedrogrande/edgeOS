"""
Shared infrastructure — database, vector store, and knowledge base.

Imported by registry.py and edgeos.py so both reference the same instances.

Two-tier DB strategy:
  Local storage  → JsonDb (file-based, zero setup) for sessions, memory, scheduler, agent state
  DATABASE_URL   → Neon (remote, shared) for knowledge vectors only

Set DATABASE_URL in .env with your Neon connection string.
Local data is stored in the ./data/ directory.
"""

import os
from pathlib import Path

from agno.db.json import JsonDb
from agno.knowledge.knowledge import Knowledge
from agno.vectordb.pgvector import PgVector


def _normalise(url: str) -> str:
    """Ensure the psycopg3 driver prefix is present."""
    if url.startswith("postgresql://") or url.startswith("postgres://"):
        return url.replace("postgres", "postgresql+psycopg", 1)
    return url


# Local file-based DB — zero setup, stores data in ./data/
local_data_dir = Path(__file__).parent.parent / "data"
local_data_dir.mkdir(exist_ok=True)
postgres_db = JsonDb(path=str(local_data_dir))

# Remote Neon — shared knowledge vectors only
neon_url = os.environ.get("DATABASE_URL") or os.environ.get("DB_URL")
if not neon_url:
    raise RuntimeError(
        "DATABASE_URL is not set. Copy .env.example to .env and fill in your Neon connection string."
    )
neon_url = _normalise(neon_url)

vector_db = PgVector(
    db_url=neon_url,
    table_name="agno_docs",
)

knowledge = Knowledge(
    name="Agno Docs",
    contents_db=postgres_db,
    vector_db=vector_db,
)
