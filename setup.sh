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

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}  Setup complete!${NC}"
echo ""
echo "  Next steps:"
echo "  1. Edit .env and add your DB_URL (and any API keys)"
echo "  2. Activate the virtual environment:"
echo "       source .venv/bin/activate"
echo "  3. Run EdgeOS:"
echo "       python edgeos.py"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
