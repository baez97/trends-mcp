import os
from fastmcp import FastMCP

mcp = FastMCP("Email MCP Server 📨")

@mcp.tool
def get_google_trends():
    """
    Returns a list of Google Trends related to Software
    """
    return ["AI Agent", "n8n", "Blockchain"]

mcp.run(
    transport="http",
    host="0.0.0.0",
    port=int(os.getenv("PORT", 8080))
)