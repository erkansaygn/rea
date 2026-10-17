#!/bin/bash
# Prepares REA in Claude Code cloud sessions so the project MCP server in
# .mcp.json can start from the local build.
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

exec "$(dirname "$0")/ensure-rea-build.sh" --always
