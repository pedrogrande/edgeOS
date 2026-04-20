"""
AgentOS Studio Registry.

Registers tools, models, and databases for use in Studio's visual builder.
Components defined here become available when composing agents, teams, and
workflows in the control plane.
"""

import os

from agno.models.ollama import Ollama
from agno.registry import Registry
from agno.tools.arxiv import ArxivTools
from agno.tools.csv_toolkit import CsvTools
from agno.tools.file_generation import FileGenerationTools
from agno.tools.hackernews import HackerNewsTools
from agno.tools.knowledge import KnowledgeTools
from agno.tools.local_file_system import LocalFileSystemTools
from agno.tools.memory import MemoryTools
from agno.tools.reasoning import ReasoningTools
from agno.tools.scheduler import SchedulerTools
from agno.tools.sleep import SleepTools
from agno.tools.visualization import VisualizationTools
from agno.tools.webbrowser import WebBrowserTools
from agno.tools.webtools import WebTools
from agno.tools.linear import LinearTools

from app.shared import knowledge, local_db, neon_db, vector_db
from app.models import (
    OLLAMA_GLM5_MODEL_ID,
    OLLAMA_MINIMAX_MODEL_ID,
    OLLAMA_MODEL_ID,
    OLLAMA_QWEN_MODEL_ID,
)

_tools = [
    # Search & research
    ArxivTools(),
    HackerNewsTools(),
    WebTools(),
    WebBrowserTools(),
    # Reasoning & memory
    ReasoningTools(),
    KnowledgeTools(knowledge=knowledge),
    MemoryTools(db=local_db),
    # Data & files
    CsvTools(),
    FileGenerationTools(),
    LocalFileSystemTools(),
    LinearTools(),
    # Visualization
    VisualizationTools(output_dir="charts"),
    # Workflow control
    SchedulerTools(db=local_db),
    SleepTools(),
]

# Conditional tools — only register if API keys are available
if os.getenv("EXA_API_KEY"):
    from agno.tools.exa import ExaTools

    _tools.append(ExaTools())

if os.getenv("LINEAR_API_KEY"):
    _tools.append(LinearTools())

if os.getenv("LINKUP_API_KEY"):
    from agno.tools.linkup import LinkupTools

    _tools.append(LinkupTools())

# MCP servers — created lazily to avoid blocking startup on connection
if os.getenv("AGNO_DOCS_MCP_URL"):
    from agno.tools.mcp import MCPTools

    _agno_docs_tools = MCPTools(
        url=os.getenv("AGNO_DOCS_MCP_URL"), transport="streamable-http"
    )
    _agno_docs_tools.name = "agno-docs"
    _tools.append(_agno_docs_tools)

if os.getenv("AGNO_EDGEOS_MCP_URL"):
    from agno.tools.mcp import MCPTools

    _agno_edgeos_tools = MCPTools(
        url=os.getenv("AGNO_EDGEOS_MCP_URL"), transport="streamable-http"
    )
    _agno_edgeos_tools.name = "agno-edgeos"
    _tools.append(_agno_edgeos_tools)

if os.getenv("BASEROW_MCP_URL"):
    from agno.tools.mcp import MCPTools

    _baserow_tools = MCPTools(url=os.getenv("BASEROW_MCP_URL"), transport="sse")
    _baserow_tools.name = "baserow"
    _tools.append(_baserow_tools)

registry = Registry(
    name="EdgeOS Registry",
    tools=_tools,
    models=[
        Ollama(id=OLLAMA_MODEL_ID),
        Ollama(id=OLLAMA_MINIMAX_MODEL_ID),
        Ollama(id=OLLAMA_QWEN_MODEL_ID),
        Ollama(id=OLLAMA_GLM5_MODEL_ID),
    ],
    dbs=[local_db, neon_db],
    vector_dbs=[vector_db],
)
