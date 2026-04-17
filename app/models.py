# Primary model provider: Ollama (cloud models via Ollama Cloud)
# Set OLLAMA_API_KEY env var for cloud access

# Default model for agents, teams, and workflows
OLLAMA_MODEL_ID = "glm-5.1:cloud"

# Available cloud models for specialized agents
OLLAMA_MINIMAX_MODEL_ID = "minimax-m2.7:cloud"
OLLAMA_QWEN_MODEL_ID = "qwen3.5:397b-cloud"
OLLAMA_GLM5_MODEL_ID = "glm-5:cloud"

# OpenAI — used for embeddings only
OPENAI_EMBEDDER_MODEL_ID = "text-embedding-3-small"
