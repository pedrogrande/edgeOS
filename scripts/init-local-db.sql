-- EdgeOS Local PostgreSQL Initialization
-- Runs automatically on first `docker compose up`

-- ── Install pgvector extension ──────────────────────────────────────────────
-- Install in the public schema (default) so that VECTOR(1536) resolves
-- without a schema prefix. This is how most local Postgres setups work.
-- Neon uses the `extensions` schema, but locally we use `public` for simplicity.
-- The replication handles the schema difference transparently.
CREATE EXTENSION IF NOT EXISTS vector;

-- ── Create the extensions schema for Neon compatibility ─────────────────────
-- Neon installs pgvector in the extensions schema. We create the schema
-- here so that any Neon-specific DDL referencing extensions.vector works.
-- The actual vector type lives in public, which is where Agno expects it.
CREATE SCHEMA IF NOT EXISTS extensions;

-- ── Create the ai schema (Agno stores all tables here) ─────────────────────
CREATE SCHEMA IF NOT EXISTS ai;

-- ── Create replication role ────────────────────────────────────────────────
-- This role is used by Neon to subscribe to local publications.
-- Password is set via PGPASSWORD env var in setup-replication.sh.
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'replication_user') THEN
        CREATE ROLE replication_user WITH REPLICATION LOGIN PASSWORD 'replication_local';
    END IF;
END
$$;

-- Grant replication user access to the ai schema
GRANT USAGE ON SCHEMA ai TO replication_user;
GRANT SELECT ON ALL TABLES IN SCHEMA ai TO replication_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA ai GRANT SELECT ON TABLES TO replication_user;

-- Grant replication user access to the extensions schema
GRANT USAGE ON SCHEMA extensions TO replication_user;

-- ── Grant ownership to the application user ────────────────────────────────
-- The POSTGRES_USER env var (default: edgeos) creates the superuser.
-- We grant it full access to the ai and extensions schemas.
-- NOTE: Shell variable substitution does NOT work in SQL init files.
-- If you change LOCAL_PG_USER in docker-compose.yml, update this file too.
GRANT ALL ON SCHEMA ai TO edgeos;
GRANT ALL ON SCHEMA extensions TO edgeos;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA ai TO edgeos;
ALTER DEFAULT PRIVILEGES IN SCHEMA ai GRANT ALL ON TABLES TO edgeos;