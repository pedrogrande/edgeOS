#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# EdgeOS Replication Health Check
#
# Checks the health and lag of bidirectional replication between
# local Postgres and Neon.
#
# Usage:
#   bash scripts/sync-status.sh
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
        -U "$LOCAL_PG_USER" -d "$LOCAL_PG_DATABASE" -t -A -c "$1" 2>/dev/null || true
}

neon_psql() {
    psql "$NEON_PSQL_URL" -t -A -c "$1" 2>/dev/null || true
}

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  EdgeOS Replication Health Check"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# ── Local Postgres ──────────────────────────────────────────────────────────
echo -e "\n${YELLOW}── Local Postgres ──${NC}"

# Check if local Postgres is running
if PGPASSWORD="$LOCAL_PG_PASSWORD" psql -h "$LOCAL_PG_HOST" -p "$LOCAL_PG_PORT" \
    -U "$LOCAL_PG_USER" -d "$LOCAL_PG_DATABASE" -c "SELECT 1" &>/dev/null; then
    echo -e "${GREEN}✓ Local Postgres is running${NC}"
else
    echo -e "${RED}✗ Local Postgres is NOT running${NC}"
    echo "  Start with: docker compose up -d"
fi

# wal_level
WAL=$(local_psql "SHOW wal_level;" 2>/dev/null | tr -d ' ')
if [ "$WAL" = "logical" ]; then
    echo -e "${GREEN}✓ wal_level = logical${NC}"
else
    echo -e "${RED}✗ wal_level = ${WAL:-unknown} (needs 'logical')${NC}"
fi

# Publications
echo ""
echo "Publications:"
PUBS=$(local_psql "SELECT pubname, puballtables FROM pg_publication;" 2>/dev/null)
if [ -n "$PUBS" ]; then
    echo "$PUBS" | while IFS='|' read -r name all_tables; do
        echo "  $name (all_tables=$all_tables)"
    done
else
    echo "  (none)"
fi

# Subscriptions
echo ""
echo "Subscriptions (local → Neon via replication):"
SUBS=$(local_psql "SELECT subname, status, pid FROM pg_stat_subscription;" 2>/dev/null)
if [ -n "$SUBS" ]; then
    echo "$SUBS" | while IFS='|' read -r name status pid; do
        if [ "$status" = "streaming" ] || [ "$status" = "running" ]; then
            echo -e "  ${GREEN}$name: $status (pid=$pid)${NC}"
        else
            echo -e "  ${YELLOW}$name: $status (pid=$pid)${NC}"
        fi
    done
else
    echo "  (none)"
fi

# Pull-based sync state
echo ""
echo "Pull-based sync (local → Neon via sync-to-neon.py):"
SYNC_STATE=$(local_psql "SELECT table_name, last_synced_at, last_sync_time, rows_synced FROM ai._sync_state ORDER BY table_name;" 2>/dev/null)
if [ -n "$SYNC_STATE" ]; then
    echo "$SYNC_STATE" | while IFS='|' read -r table last_at last_time rows; do
        echo "  $table: last_sync=${last_at:-0}, rows=$rows, at=$last_time"
    done
else
    echo "  (sync not yet initialized — run: python scripts/sync-to-neon.py --once)"
fi

# Replication lag (local as subscriber)
echo ""
echo "Replication lag (local behind Neon):"
LAG=$(local_psql "
    SELECT
        subname,
        pg_wal_lsn_diff(pg_current_wal_lsn(), received_lsn) AS lag_bytes,
        now() - last_msg_receipt_time AS lag_time
    FROM pg_stat_subscription
    WHERE subname = 'sub_from_neon';
" 2>/dev/null)
if [ -n "$LAG" ]; then
    echo "$LAG" | while IFS='|' read -r name lag_bytes lag_time; do
        echo "  $name: ${lag_bytes:-0} bytes behind, ${lag_time:-unknown} lag"
    done
else
    echo "  (no active subscription)"
fi

# ── Neon Postgres ───────────────────────────────────────────────────────────
echo -e "\n${YELLOW}── Neon Postgres ──${NC}"

# Check Neon connectivity
if psql "$NEON_PSQL_URL" -c "SELECT 1" &>/dev/null; then
    echo -e "${GREEN}✓ Neon connection works${NC}"
else
    echo -e "${RED}✗ Cannot connect to Neon${NC}"
fi

# Publications
echo ""
echo "Publications:"
PUBS=$(neon_psql "SELECT pubname, puballtables FROM pg_publication;" 2>/dev/null)
if [ -n "$PUBS" ]; then
    echo "$PUBS" | while IFS='|' read -r name all_tables; do
        echo "  $name (all_tables=$all_tables)"
    done
else
    echo "  (none)"
fi

# Subscriptions
echo ""
echo "Subscriptions (Neon → local via replication):"
SUBS=$(neon_psql "SELECT subname, status, pid FROM pg_stat_subscription WHERE subname = 'sub_from_local';" 2>/dev/null)
if [ -n "$SUBS" ]; then
    echo "$SUBS" | while IFS='|' read -r name status pid; do
        if [ "$status" = "streaming" ] || [ "$status" = "running" ]; then
            echo -e "  ${GREEN}$name: $status (pid=$pid)${NC}"
        else
            echo -e "  ${YELLOW}$name: $status (pid=$pid)${NC}"
        fi
    done
else
    echo "  (none — using pull-based sync instead)"
fi

# ── Row counts comparison ────────────────────────────────────────────────────
echo -e "\n${YELLOW}── Row Count Comparison ──${NC}"

TABLES="agno_sessions agno_memories agno_knowledge agno_docs agno_components"
for table in $TABLES; do
    LOCAL_COUNT=$(local_psql "SELECT COUNT(*) FROM ai.${table};" 2>/dev/null || echo "N/A")
    NEON_COUNT=$(neon_psql "SELECT COUNT(*) FROM ai.${table};" 2>/dev/null || echo "N/A")
    LOCAL_COUNT=$(echo "$LOCAL_COUNT" | tr -d ' ')
    NEON_COUNT=$(echo "$NEON_COUNT" | tr -d ' ')
    if [ "$LOCAL_COUNT" = "$NEON_COUNT" ]; then
        echo -e "  ${GREEN}ai.$table: local=$LOCAL_COUNT neon=$NEON_COUNT ✓${NC}"
    else
        echo -e "  ${YELLOW}ai.$table: local=$LOCAL_COUNT neon=$NEON_COUNT ✗ (drift)${NC}"
    fi
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"