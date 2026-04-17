"""AgentOS"""

from os import getenv
from pathlib import Path

from dotenv import load_dotenv

# Load .env file before anything else
load_dotenv()

from agno.os import AgentOS

from agents.agno_assist import agno_assist
from agents.shared import postgres_db
from agents.web_agent import web_agent
from app.registry import registry
from teams.multilingual_team import multilingual_team
from teams.reasoning_finance_team import reasoning_research_team
from workflows.investment_workflow import investment_workflow
from workflows.research_workflow import research_workflow

os_config_path = str(Path(__file__).parent.joinpath("config.yaml"))

# Only one instance should run the scheduler when sharing a database
_enable_scheduler = getenv("ENABLE_SCHEDULER", "true").lower() == "true"

# Create the AgentOS
agent_os = AgentOS(
    id="EdgeOS",
    agents=[web_agent, agno_assist],
    teams=[multilingual_team, reasoning_research_team],
    workflows=[investment_workflow, research_workflow],
    # Studio Registry — makes tools, models, and DBs available in the visual builder
    registry=registry,
    # Scheduler — enables cron-based agent/workflow execution
    # Set ENABLE_SCHEDULER=false on all but one instance when sharing a database
    scheduler=_enable_scheduler,
    scheduler_poll_interval=15,
    # Database — enables Components, Scheduler, and Approval routers
    db=postgres_db,
    # Configuration for the AgentOS
    config=os_config_path,
)
app = agent_os.get_app()

if __name__ == "__main__":
    # Serve the application
    agent_os.serve(app="main:app", reload=True)
