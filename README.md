
# EdgeOS

A multi-agent console [Agno](https://agno.com).



## Quick start (Mac)

### 1. Clone the repo

```bash
git clone https://github.com/pedrogrande/edgeOS.git
cd edgeOS
```

### 2. Run the setup script

This installs `uv` (Python package manager) if needed, creates a virtual environment, and installs all dependencies.

```bash
bash setup.sh
```

### 3. Fill in your credentials

Open the `.env` file that was created and add your values:

```
DB_URL=postgresql+psycopg://...   ← your Postgresql database connection string [Options below]
OLLAMA_API_KEY=...                 ← your Ollama Cloud key [Ollama instructions below]
OPENAI_API_KEY=...                ← [OpenAI key](https://developers.openai.com/) (used for embedding generation in the registry, not for agents' LLM calls by default)

# Optional tool API keys:
EXA_API_KEY=...                   ← [Exa AI web search](https://exa.ai/)
LINEAR_API_KEY=...                ← [Linear project management](https://linear.app/docs/api-and-webhooks)
LINKUP_API_KEY=...                ← [Linkup search](https://www.linkup.so/)
TAVILY_API_KEY=...                ← [Tavily agent orchestration](https://www.tavily.com/)	
SERPER_API_KEY=...							  ← [Serper search](https://serper.dev/)
```

Get your Neon connection string from [console.neon.tech](https://console.neon.tech).

### 4. Run EdgeOS

```bash
source .venv/bin/activate
python edgeos.py
```

The server starts on **http://localhost:7777**.

---

### 5. Go to Agno AgentOS

Go to [os.agno.com](https://os.agno.com) and log in with your Agno account (Create an account if you don't already have one). 

Connect EdgeOS to your Agno account using the "Connect AgentOS" button in the sidebar, and enter the URL `http://localhost:7777`.

See video and info here: https://docs.agno.com/agent-os/connect-your-os

Now you can start building agents and teams in the AgentOS Studio!

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

---

## Appendix: Setting up Ollama Cloud

1. Go to [Ollama Cloud](https://ollama.com/cloud) and create an account.
2. Create an API key in the dashboard and copy it to your `.env` file as `OLLAMA_API_KEY`.

