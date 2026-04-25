from mcp.server.fastmcp import FastMCP

mcp = FastMCP(
    "company-knowledge",
    instructions=(
        "Internal runbook and on-call documentation search. "
        "Use this server when investigating production incidents, "
        "verifying deployment procedures, or onboarding new engineers. "
        "Do NOT use for code search (use ripgrep) or general web search."
    ),
)
