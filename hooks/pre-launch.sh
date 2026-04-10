#!/bin/bash
set -euo pipefail

# Set up Context7 MCP if API key is provided
if [ -n "${CONTEXT7_API_KEY:-}" ]; then
    echo "Configuring Context7 MCP server..."
    mise exec node@lts -- ctx7 setup --claude --mcp --api-key "$CONTEXT7_API_KEY" -y
fi
