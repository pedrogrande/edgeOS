"""
Shared infrastructure — database, vector store, and knowledge base.

Imported by registry.py and edgeos.py so both reference the same instances.
Requires DB_URL in the environment (loaded from .env before this module is imported).
"""

import os

from agno.db.postgres import PostgresDb
from agno.knowledge.knowledge import Knowledge
from agno.vectordb.pgvector import PgVector

db_url = os.environ.get("DB_URL") or os.environ.get("DATABASE_URL")
if not db_url:
    raise RuntimeError(
        "DB_URL (or DATABASE_URL) is not set. Copy .env.example to .env and fill in your Neon connection string."
    )
# Ensure the psycopg3 driver prefix is present
if db_url.startswith("postgresql://") or db_url.startswith("postgres://"):
    db_url = db_url.replace("postgres", "postgresql+psycopg", 1)

postgres_db = PostgresDb(db_url=db_url)

vector_db = PgVector(
    db_url=db_url,
    table_name="agno_docs",
)

knowledge = Knowledge(
    name="Agno Docs",
    contents_db=postgres_db,
    vector_db=vector_db,
)
