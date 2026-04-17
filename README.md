
# EdgeOS

A personal AI operating system powered by [Agno](https://agno.com) and Neon Postgres.

## Quick start (Mac)

### 1. Clone the repo

```bash
git clone https://github.com/YOUR_USERNAME/edgeos.git
cd edgeos
```

### 2. Run the setup script

This installs `uv` (Python package manager) if needed, creates a virtual environment, and installs all dependencies.

```bash
bash setup.sh
```

### 3. Fill in your credentials

Open the `.env` file that was created and add your values:

```
DB_URL=postgresql+psycopg://...   ← your Neon connection string
OLLAMA_API_KEY=...                 ← your Ollama Cloud key
```

Get your Neon connection string from [console.neon.tech](https://console.neon.tech).

### 4. Run EdgeOS

```bash
source .venv/bin/activate
python edgeos.py
```

The server starts on **http://localhost:7777**.

---

## Environment variables

| Variable | Required | Description |
|---|---|---|
| `DB_URL` | ✅ | Neon Postgres connection string |
| `OLLAMA_API_KEY` | ✅ | Ollama Cloud API key |
| `EXA_API_KEY` | Optional | Exa AI web search |
| `LINEAR_API_KEY` | Optional | Linear project management |
| `LINKUP_API_KEY` | Optional | Linkup search |

See `.env.example` for the full list.

---

## Manual setup (if you prefer)

```bash
# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Create venv and install deps
uv venv --python 3.12
source .venv/bin/activate
uv pip install -r requirements.txt

# Configure environment
cp .env.example .env
# edit .env with your values

# Run
python edgeos.py
```