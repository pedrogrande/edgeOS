#!/usr/bin/env bash
# EdgeOS setup script — installs uv, creates a virtual env, and installs deps.
# Run: bash setup.sh

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Colour

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  EdgeOS Setup"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# ── 1. Install uv if not present ──────────────────────────────────────────────
if ! command -v uv &>/dev/null; then
    echo -e "${YELLOW}▸ uv not found — installing...${NC}"
    curl -LsSf https://astral.sh/uv/install.sh | sh
    # Add uv to PATH for the rest of this script
    export PATH="$HOME/.local/bin:$PATH"
    echo -e "${GREEN}✓ uv installed${NC}"
else
    echo -e "${GREEN}✓ uv already installed ($(uv --version))${NC}"
fi

# ── 2. Create virtual environment with Python 3.12 ────────────────────────────
if [ ! -d ".venv" ]; then
    echo -e "${YELLOW}▸ Creating virtual environment (.venv)...${NC}"
    uv venv --python 3.12
    echo -e "${GREEN}✓ Virtual environment created${NC}"
else
    echo -e "${GREEN}✓ Virtual environment already exists${NC}"
fi

# ── 3. Install dependencies ───────────────────────────────────────────────────
echo -e "${YELLOW}▸ Installing dependencies...${NC}"
uv pip install -r requirements.txt
echo -e "${GREEN}✓ Dependencies installed${NC}"

# ── 4. Create .env from .env.example if it doesn't exist ─────────────────────
if [ ! -f ".env" ]; then
    cp .env.example .env
    echo ""
    echo -e "${YELLOW}▸ Created .env from .env.example${NC}"
    echo -e "${RED}  ➜  Open .env and fill in your DB_URL and API keys before running.${NC}"
else
    echo -e "${GREEN}✓ .env already exists${NC}"
fi

# ── 5. Start local PostgreSQL (Docker) ──────────────────────────────────────
if command -v docker &>/dev/null; then
    if docker compose version &>/dev/null; then
        echo -e "${YELLOW}▸ Starting local PostgreSQL (Docker)...${NC}"
        docker compose up -d
        echo -e "${GREEN}✓ Local PostgreSQL started${NC}"

        # Wait for Postgres to be ready
        echo -e "${YELLOW}▸ Waiting for Postgres to be ready...${NC}"
        LOCAL_PG_HOST="${LOCAL_PG_HOST:-localhost}"
        LOCAL_PG_PORT="${LOCAL_PG_PORT:-5432}"
        LOCAL_PG_USER="${LOCAL_PG_USER:-edgeos}"
        LOCAL_PG_PASSWORD="${LOCAL_PG_PASSWORD:-edgeos_local}"
        LOCAL_PG_DATABASE="${LOCAL_PG_DATABASE:-edgeos}"

        MAX_RETRIES=30
        RETRY_COUNT=0
        until PGPASSWORD="$LOCAL_PG_PASSWORD" psql -h "$LOCAL_PG_HOST" -p "$LOCAL_PG_PORT" \
            -U "$LOCAL_PG_USER" -d "$LOCAL_PG_DATABASE" -c "SELECT 1" &>/dev/null; do
            RETRY_COUNT=$((RETRY_COUNT + 1))
            if [ $RETRY_COUNT -ge $MAX_RETRIES ]; then
                echo -e "${RED}  ✗ Postgres did not become ready in time${NC}"
                echo -e "${YELLOW}  Run 'docker compose logs postgres' to check${NC}"
                break
            fi
            sleep 1
        done

        if [ $RETRY_COUNT -lt $MAX_RETRIES ]; then
            echo -e "${GREEN}✓ Postgres is ready${NC}"
        fi
    else
        echo -e "${YELLOW}⚠ Docker Compose not found. Skipping local Postgres setup.${NC}"
        echo -e "${YELLOW}  Install Docker Compose for offline-first support.${NC}"
    fi
else
    echo -e "${YELLOW}⚠ Docker not found. Skipping local Postgres setup.${NC}"
    echo -e "${YELLOW}  Install Docker for offline-first support.${NC}"
fi

# ── 6. Migrate local database schema ─────────────────────────────────────────
if [ -f ".env" ] && [ -f "scripts/migrate-local-db.py" ]; then
    # Check if LOCAL_DB_URL is set in .env
    if grep -q "^LOCAL_DB_URL=" .env && ! grep -q "^LOCAL_DB_URL=$" .env; then
        echo -e "${YELLOW}▸ Running local database migration...${NC}"
        if [ -d ".venv" ]; then
            source .venv/bin/activate
            python scripts/migrate-local-db.py 2>/dev/null && echo -e "${GREEN}✓ Local database migrated${NC}" || echo -e "${YELLOW}⚠ Migration skipped (local DB may not be ready yet)${NC}"
            deactivate
        else
            echo -e "${YELLOW}⚠ Virtual environment not found. Run migration manually:${NC}"
            echo "  source .venv/bin/activate && python scripts/migrate-local-db.py"
        fi
    else
        echo -e "${YELLOW}⚠ LOCAL_DB_URL not configured. Skipping local migration.${NC}"
        echo -e "${YELLOW}  Set LOCAL_DB_URL in .env and run: python scripts/migrate-local-db.py${NC}"
    fi
fi

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}  Setup complete!${NC}"
echo ""
echo "  Next steps:"
echo "  1. Edit .env and add your DB_URL (and any API keys)"
echo "  2. Activate the virtual environment:"
echo "       source .venv/bin/activate"
echo "  3. (Optional) Set up bidirectional replication:"
echo "       bash scripts/setup-replication.sh"
echo "  4. Run EdgeOS:"
echo "       python edgeos.py"
echo ""
echo "  Offline-first mode:"
echo "  • Local Postgres runs in Docker (docker compose up -d)"
echo "  • Set LOCAL_DB_URL in .env to enable offline-first mode"
echo "  • Bidirectional sync keeps local and Neon in sync"
echo "  • Monitor sync: bash scripts/sync-status.sh"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
