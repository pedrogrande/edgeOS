#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# EdgeOS Replication Repair Script
#
# Rebuilds bidirectional replication from scratch. Use this when:
#   - Neon has dropped an inactive replication slot (>40h offline)
#   - Replication is broken or lagging significantly
#   - You need to re-sync after a long offline period
#
# This script:
#   1. Drops all existing publications and subscriptions
#   2. Re-syncs data from Neon to local (pg_dump/pg_restore)
#   3. Re-creates publications and subscriptions
#
# WARNING: This will briefly interrupt replication. Local writes during
# the repair may be lost if they haven't synced to Neon yet.
#
# Usage:
#   bash scripts/repair-sync.sh
# ─────────────────────────────────────────────────────────────────────────────

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECT_ROOT"

if [ ! -f .env ]; then
    echo -e "${RED}ERROR: .env file not found.${NC}"
    exit 1
fi

# Safe .env loader — handles special chars in values (URLs with & and ?)
while IFS='=' read -r key value; do
    [[ -z "$key" || "$key" =~ ^# ]] && continue
    value="${value#\'}"
    value="${value%\'}"
    value="${value#\"}"
    value="${value%\"}"
    export "$key=$value"
done < .env

LOCAL_PG_HOST="${LOCAL_PG_HOST:-localhost}"
LOCAL_PG_PORT="${LOCAL_PG_PORT:-5433}"
LOCAL_PG_USER="${LOCAL_PG_USER:-edgeos}"
LOCAL_PG_PASSWORD="${LOCAL_PG_PASSWORD:-edgeos_local}"
LOCAL_PG_DATABASE="${LOCAL_PG_DATABASE:-edgeos}"

NEON_DB_URL="${DB_URL}"
NEON_PSQL_URL=$(echo "$NEON_DB_URL" | sed 's|+psycopg://|://|' | sed 's/&channel_binding=[^&]*//g' | sed 's/?channel_binding=[^&]*&/?/g' | sed 's/?channel_binding=[^&]*$//g')

local_psql() {
    PGPASSWORD="$LOCAL_PG_PASSWORD" psql -h "$LOCAL_PG_HOST" -p "$LOCAL_PG_PORT" \
        -U "$LOCAL_PG_USER" -d "$LOCAL_PG_DATABASE" -c "$1"
}

neon_psql() {
    psql "$NEON_PSQL_URL" -c "$1"
}

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  EdgeOS Replication Repair"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "${RED}⚠  This will drop and recreate all replication objects.${NC}"
echo -e "${RED}   Local writes that haven't synced to Neon may be lost.${NC}"
echo ""
read -p "Continue? [y/N] " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 0
fi

# ── Step 1: Drop existing replication objects ────────────────────────────────
echo ""
echo -e "${YELLOW}Step 1: Dropping existing replication objects...${NC}"

# Local: drop subscriptions first, then publications
local_psql "DROP SUBSCRIPTION IF EXISTS sub_from_neon;" 2>/dev/null || true
local_psql "DROP PUBLICATION IF EXISTS local_pub;" 2>/dev/null || true
echo -e "${GREEN}✓ Local replication objects dropped${NC}"

# Neon: drop subscriptions first, then publications
neon_psql "DROP SUBSCRIPTION IF EXISTS sub_from_local;" 2>/dev/null || true
neon_psql "DROP PUBLICATION IF EXISTS neon_pub;" 2>/dev/null || true
echo -e "${GREEN}✓ Neon replication objects dropped${NC}"

# ── Step 2: Re-sync data from Neon to local ──────────────────────────────────
echo ""
echo -e "${YELLOW}Step 2: Re-syncing data from Neon to local...${NC}"
echo "  (This may take a moment for large datasets)"

# Dump the ai schema from Neon and restore to local
# Use --no-owner --no-privileges to avoid permission issues
# Use --clean to drop existing tables before restoring
# Use --if-exists to avoid errors if tables don't exist yet
PGPASSWORD="$LOCAL_PG_PASSWORD" pg_dump \
    "$NEON_PSQL_URL" \
    --schema=ai \
    --no-owner \
    --no-privileges \
    --clean \
    --if-exists \
    --data-only \
    | PGPASSWORD="$LOCAL_PG_PASSWORD" psql \
        -h "$LOCAL_PG_HOST" -p "$LOCAL_PG_PORT" \
        -U "$LOCAL_PG_USER" -d "$LOCAL_PG_DATABASE" 2>/dev/null

echo -e "${GREEN}✓ Data re-synced from Neon to local${NC}"

# ── Step 3: Re-run setup-replication.sh ──────────────────────────────────────
echo ""
echo -e "${YELLOW}Step 3: Re-creating replication...${NC}"
bash "$SCRIPT_DIR/setup-replication.sh"

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  Repair complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"