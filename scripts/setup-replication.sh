#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# EdgeOS Bidirectional Replication Setup
#
# Sets up PostgreSQL logical replication between local Postgres (Docker) and
# Neon cloud. Uses WITH (origin = none) to prevent replication loops.
#
# Architecture:
#   Neon → Local:  PostgreSQL logical replication (sub_from_neon)
#   Local → Neon:  Pull-based sync (sync-to-neon.py) — no tunnel needed
#
# Prerequisites:
#   1. Local Postgres running:  docker compose up -d
#   2. Schema migrated:         python scripts/migrate-local-db.py
#   3. .env file configured with LOCAL_DB_URL and DB_URL
#   4. Neon logical replication enabled (Console → Settings → Logical Replication)
#
# Usage:
#   bash scripts/setup-replication.sh          # Full setup
#   bash scripts/setup-replication.sh --status  # Check status only
# ─────────────────────────────────────────────────────────────────────────────

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# ── Load environment ─────────────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECT_ROOT"

if [ ! -f .env ]; then
    echo -e "${RED}ERROR: .env file not found. Copy .env.example to .env and fill in values.${NC}"
    exit 1
fi

# Export vars from .env — use a safe loader that handles special chars in values
# (URLs with & and ? break plain `source .env`)
while IFS='=' read -r key value; do
    # Skip comments and empty lines
    [[ -z "$key" || "$key" =~ ^# ]] && continue
    # Strip surrounding quotes if present
    value="${value#\'}"
    value="${value%\'}"
    value="${value#\"}"
    value="${value%\"}"
    export "$key=$value"
done < .env

# ── Configuration ────────────────────────────────────────────────────────────
LOCAL_PG_HOST="${LOCAL_PG_HOST:-localhost}"
LOCAL_PG_PORT="${LOCAL_PG_PORT:-5433}"
LOCAL_PG_USER="${LOCAL_PG_USER:-edgeos}"
LOCAL_PG_PASSWORD="${LOCAL_PG_PASSWORD:-edgeos_local}"
LOCAL_PG_DATABASE="${LOCAL_PG_DATABASE:-edgeos}"

# Replication user on local
LOCAL_REPL_USER="replication_user"
LOCAL_REPL_PASSWORD="${LOCAL_REPL_PASSWORD:-replication_local}"

# Neon connection (parsed from DB_URL)
# DB_URL format: postgresql+psycopg://user:pass@host/dbname?sslmode=require&channel_binding=require
NEON_DB_URL="${DB_URL}"
# Strip the +psycopg driver prefix and remove psycopg-specific params for psql
NEON_PSQL_URL=$(echo "$NEON_DB_URL" | sed 's|+psycopg://|://|' | sed 's/&channel_binding=[^&]*//g' | sed 's/?channel_binding=[^&]*&/?/g' | sed 's/?channel_binding=[^&]*$//g')

# ── Agno tables to replicate ────────────────────────────────────────────────
AGNO_TABLES=(
    "ai.agno_sessions"
    "ai.agno_memories"
    "ai.agno_knowledge"
    "ai.agno_docs"
    "ai.agno_components"
    "ai.agno_component_configs"
    "ai.agno_component_links"
    "ai.agno_approvals"
    "ai.agno_eval_runs"
    "ai.agno_learnings"
    "ai.agno_metrics"
    "ai.agno_schedules"
    "ai.agno_schedule_runs"
    "ai.agno_schema_versions"
    "ai.agno_assist_knowledge_contents"
    "ai.agno_assist_knowledge_vectors"
    "ai.knowledge_vectors"
)

# Build comma-separated table list for PUBLICATION
TABLE_LIST=$(IFS=','; echo "${AGNO_TABLES[*]}")

# ── Helper functions ─────────────────────────────────────────────────────────
local_psql() {
    PGPASSWORD="$LOCAL_PG_PASSWORD" psql -h "$LOCAL_PG_HOST" -p "$LOCAL_PG_PORT" \
        -U "$LOCAL_PG_USER" -d "$LOCAL_PG_DATABASE" -c "$1"
}

neon_psql() {
    psql "$NEON_PSQL_URL" -c "$1"
}

check_status() {
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  Replication Status"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    echo -e "\n${YELLOW}── Local Postgres ──${NC}"
    echo "Publications:"
    local_psql "SELECT pubname, puballtables FROM pg_publication;" 2>/dev/null || echo "  (no publications)"
    echo ""
    echo "Subscriptions:"
    local_psql "SELECT subname, status, received_lsn, latest_end_lsn FROM pg_stat_subscription;" 2>/dev/null || echo "  (no subscriptions)"
    echo ""
    echo "Replication slots:"
    local_psql "SELECT slot_name, slot_type, active FROM pg_replication_slots;" 2>/dev/null || echo "  (no slots)"

    echo -e "\n${YELLOW}── Neon Postgres ──${NC}"
    echo "Publications:"
    neon_psql "SELECT pubname, puballtables FROM pg_publication;" 2>/dev/null || echo "  (no publications)"
    echo ""
    echo "Subscriptions:"
    neon_psql "SELECT subname, status, received_lsn, latest_end_lsn FROM pg_stat_subscription;" 2>/dev/null || echo "  (no subscriptions)"
    echo ""
    echo "Replication slots:"
    neon_psql "SELECT slot_name, slot_type, active FROM pg_replication_slots WHERE slot_name NOT LIKE 'neon%';" 2>/dev/null || echo "  (no slots)"
}

# ── Status-only mode ────────────────────────────────────────────────────────
if [ "${1:-}" = "--status" ]; then
    check_status
    exit 0
fi

# ── Pre-flight checks ────────────────────────────────────────────────────────
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  EdgeOS Bidirectional Replication Setup"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check local Postgres is running
if ! PGPASSWORD="$LOCAL_PG_PASSWORD" psql -h "$LOCAL_PG_HOST" -p "$LOCAL_PG_PORT" \
    -U "$LOCAL_PG_USER" -d "$LOCAL_PG_DATABASE" -c "SELECT 1" &>/dev/null; then
    echo -e "${RED}ERROR: Local Postgres is not running.${NC}"
    echo "  Start it with: docker compose up -d"
    exit 1
fi
echo -e "${GREEN}✓ Local Postgres is running${NC}"

# Check Neon connectivity
if ! psql "$NEON_PSQL_URL" -c "SELECT 1" &>/dev/null; then
    echo -e "${RED}ERROR: Cannot connect to Neon.${NC}"
    echo "  Check DB_URL in .env"
    exit 1
fi
echo -e "${GREEN}✓ Neon connection works${NC}"

# Check wal_level on local
WAL_LEVEL=$(local_psql "SHOW wal_level;" 2>/dev/null | grep -o 'logical\|replica' | head -1)
if [ "$WAL_LEVEL" != "logical" ]; then
    echo -e "${RED}ERROR: Local Postgres wal_level is '$WAL_LEVEL', needs to be 'logical'.${NC}"
    echo "  This is set in docker-compose.yml command args. Restart with: docker compose down && docker compose up -d"
    exit 1
fi
echo -e "${GREEN}✓ Local wal_level = logical${NC}"

# Check Neon wal_level
NEON_WAL=$(neon_psql "SHOW wal_level;" 2>/dev/null | grep -o 'logical\|replica' | head -1)
if [ "$NEON_WAL" != "logical" ]; then
    echo -e "${RED}ERROR: Neon wal_level is '$NEON_WAL', needs to be 'logical'.${NC}"
    echo "  Enable it in Neon Console → Settings → Logical Replication"
    exit 1
fi
echo -e "${GREEN}✓ Neon wal_level = logical${NC}"

# ── Step 1: Create replication role on Neon ──────────────────────────────────
echo ""
echo -e "${YELLOW}Step 1: Set up Neon replication role...${NC}"

# Check if replication_user exists on Neon
NEON_REPL_USER="${NEON_REPL_USER:-replication_user}"
NEON_REPL_PASSWORD="${NEON_REPL_PASSWORD:-}"

if [ -z "$NEON_REPL_PASSWORD" ]; then
    echo -e "${RED}ERROR: NEON_REPL_PASSWORD not set in .env${NC}"
    echo "  Create a replication user in Neon Console and set NEON_REPL_PASSWORD."
    exit 1
fi

# Grant access on Neon
neon_psql "GRANT USAGE ON SCHEMA ai TO ${NEON_REPL_USER};" 2>/dev/null || true
neon_psql "GRANT SELECT ON ALL TABLES IN SCHEMA ai TO ${NEON_REPL_USER};" 2>/dev/null || true
neon_psql "ALTER DEFAULT PRIVILEGES IN SCHEMA ai GRANT SELECT ON TABLES TO ${NEON_REPL_USER};" 2>/dev/null || true
echo -e "${GREEN}✓ Neon replication role configured${NC}"

# ── Step 2: Create publication on Neon ───────────────────────────────────────
echo ""
echo -e "${YELLOW}Step 2: Create publication on Neon...${NC}"

# Drop existing publication if it exists (idempotent)
neon_psql "DROP PUBLICATION IF EXISTS neon_pub;" 2>/dev/null || true

# Check if any tables exist in the ai schema on Neon
NEON_TABLE_COUNT=$(neon_psql "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'ai';" 2>/dev/null | tr -d ' ')

if [ "$NEON_TABLE_COUNT" -gt 0 ] 2>/dev/null; then
    # Tables exist — create per-table publication
    neon_psql "CREATE PUBLICATION neon_pub FOR TABLE ${TABLE_LIST};" 2>/dev/null
    if [ $? -ne 0 ]; then
        # Some tables may not exist yet — fall back to schema-level publication
        echo -e "${YELLOW}⚠  Some tables not found, using schema-level publication${NC}"
        neon_psql "DROP PUBLICATION IF EXISTS neon_pub;" 2>/dev/null || true
        neon_psql "CREATE PUBLICATION neon_pub FOR TABLES IN SCHEMA ai;"
    fi
    echo -e "${GREEN}✓ Neon publication 'neon_pub' created${NC}"
else
    # No tables yet — use schema-level publication (will cover all future tables)
    echo -e "${YELLOW}⚠  No tables in ai schema yet — using schema-level publication${NC}"
    neon_psql "CREATE PUBLICATION neon_pub FOR TABLES IN SCHEMA ai;"
    echo -e "${GREEN}✓ Neon publication 'neon_pub' created (schema-level)${NC}"
    echo -e "${YELLOW}   Note: Schema-level publications cannot have tables added/removed later.${NC}"
    echo -e "${YELLOW}   Run EdgeOS once to create tables, then re-run this script for per-table publication.${NC}"
fi

# ── Step 3: Create publication on local ───────────────────────────────────────
echo ""
echo -e "${YELLOW}Step 3: Create publication on local Postgres...${NC}"

# Ensure replication_user has access
local_psql "GRANT USAGE ON SCHEMA ai TO ${LOCAL_REPL_USER};" 2>/dev/null || true
local_psql "GRANT SELECT ON ALL TABLES IN SCHEMA ai TO ${LOCAL_REPL_USER};" 2>/dev/null || true
local_psql "ALTER DEFAULT PRIVILEGES IN SCHEMA ai GRANT SELECT ON TABLES TO ${LOCAL_REPL_USER};" 2>/dev/null || true

# Drop and recreate publication
local_psql "DROP PUBLICATION IF EXISTS local_pub;" 2>/dev/null || true

# Check if any tables exist in the ai schema locally
LOCAL_TABLE_COUNT=$(local_psql "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'ai';" 2>/dev/null | tr -d ' ')

if [ "$LOCAL_TABLE_COUNT" -gt 0 ] 2>/dev/null; then
    # Tables exist — create per-table publication
    local_psql "CREATE PUBLICATION local_pub FOR TABLE ${TABLE_LIST};" 2>/dev/null
    if [ $? -ne 0 ]; then
        echo -e "${YELLOW}⚠  Some tables not found locally, using schema-level publication${NC}"
        local_psql "DROP PUBLICATION IF EXISTS local_pub;" 2>/dev/null || true
        local_psql "CREATE PUBLICATION local_pub FOR TABLES IN SCHEMA ai;"
    fi
    echo -e "${GREEN}✓ Local publication 'local_pub' created${NC}"
else
    # No tables yet — use schema-level publication
    echo -e "${YELLOW}⚠  No tables in ai schema yet — using schema-level publication${NC}"
    local_psql "CREATE PUBLICATION local_pub FOR TABLES IN SCHEMA ai;"
    echo -e "${GREEN}✓ Local publication 'local_pub' created (schema-level)${NC}"
fi

# ── Step 4: Create subscription on local (local → Neon) ─────────────────────
echo ""
echo -e "${YELLOW}Step 4: Create subscription on local Postgres (subscribing FROM Neon)...${NC}"

# Build Neon connection string for the subscription
# Use the session pooler (port 5432) for stable replication connections
# Parse DB_URL to extract components
NEON_HOST=$(echo "$NEON_PSQL_URL" | sed -n 's|.*@\([^/]*\).*|\1|p' | sed 's|:[0-9]*||')
NEON_PORT=$(echo "$NEON_PSQL_URL" | sed -n 's|.*:\([0-9]*\)/.*|\1|p')
NEON_DBNAME=$(echo "$NEON_PSQL_URL" | sed -n 's|.*/\([^?]*\).*|\1|p')

# Build subscription connection string
SUB_CONN="postgresql://${NEON_REPL_USER}:${NEON_REPL_PASSWORD}@${NEON_HOST}:${NEON_PORT:-5432}/${NEON_DBNAME}?sslmode=require"

local_psql "DROP SUBSCRIPTION IF EXISTS sub_from_neon;" 2>/dev/null || true
local_psql "CREATE SUBSCRIPTION sub_from_neon CONNECTION '${SUB_CONN}' PUBLICATION neon_pub WITH (origin = none);"
echo -e "${GREEN}✓ Local subscription 'sub_from_neon' created${NC}"

# ── Step 5: Local → Neon direction (pull-based sync) ────────────────────────
echo ""
echo -e "${YELLOW}Step 5: Local → Neon sync (pull-based)${NC}"
echo ""
echo -e "${GREEN}✓ No tunnel needed! The sync sidecar handles this direction.${NC}"
echo ""
echo "  The docker-compose 'sync' service runs sync-to-neon.py which:"
echo "  1. Polls local Postgres for changes (using updated_at timestamps)"
echo "  2. Pushes changes to Neon via SQL upserts"
echo "  3. Propagates deletes via a trigger-based log table"
echo ""
echo "  Start it with: docker compose up -d"
echo "  Check logs:    docker compose logs -f sync"
echo "  Manual sync:   python scripts/sync-to-neon.py --once"
echo ""
echo -e "${GREEN}Bidirectional sync is now fully configured!${NC}"
echo "  Neon → Local:  Logical replication (sub_from_neon)"
echo "  Local → Neon:  Pull-based sync (sync-to-neon.py)"

# ── Final status ─────────────────────────────────────────────────────────────
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}  Replication setup complete!${NC}"
echo ""
echo "  Monitor with:  bash scripts/setup-replication.sh --status"
echo "  Check health:  bash scripts/sync-status.sh"
echo "  Manual sync:   python scripts/sync-to-neon.py --once"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

check_status