"""
EdgeOS — main entry point.

Prerequisites:
uv pip install -U fastapi uvicorn sqlalchemy pgvector psycopg openai mcp python-dotenv

Usage:
    python edgeos.py
"""

from dotenv import load_dotenv

load_dotenv()

from agno.agent import Agent
from agno.models.ollama import Ollama
from agno.os import AgentOS
from agno.team import Team
from agno.tools.hackernews import HackerNewsTools
from agno.tools.mcp import MCPTools

from app.models import OLLAMA_MODEL_ID
from app.registry import registry
from app.shared import knowledge, postgres_db

# Create your agents
agno_agent = Agent(
    name="Agno Agent",
    model=Ollama(id=OLLAMA_MODEL_ID),
    tools=[MCPTools(transport="streamable-http", url="https://docs.agno.com/mcp")],
    db=postgres_db,
    update_memory_on_run=True,
    knowledge=knowledge,
    markdown=True,
)

simple_agent = Agent(
    name="Simple Agent",
    role="Simple agent",
    id="simple_agent",
    model=Ollama(id=OLLAMA_MODEL_ID),
    instructions=["You are a simple agent"],
    db=postgres_db,
    update_memory_on_run=True,
)

research_agent = Agent(
    name="Research Agent",
    role="Research agent",
    id="research_agent",
    model=Ollama(id=OLLAMA_MODEL_ID),
    instructions=["You are a research agent"],
    tools=[HackerNewsTools()],
    db=postgres_db,
    update_memory_on_run=True,
)

# Create a team
research_team = Team(
    name="Research Team",
    description="A team of agents that research the web",
    members=[research_agent, simple_agent],
    model=Ollama(id=OLLAMA_MODEL_ID),
    id="research_team",
    instructions=[
        "You are the lead researcher of a research team! 🔍",
    ],
    db=postgres_db,
    update_memory_on_run=True,
    add_datetime_to_context=True,
    markdown=True,
)


# Create the AgentOS
agent_os = AgentOS(
    id="edgeos",
    agents=[agno_agent],
    teams=[research_team],
    registry=registry,
    db=postgres_db,
    enable_mcp_server=True,
)
app = agent_os.get_app()


if __name__ == "__main__":
    agent_os.serve(app="edgeos:app", port=7777)
