#!/bin/bash
# Prepares REA in Claude Code cloud sessions so the project MCP server in
# .mcp.json can start from the local build.
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

cd "${CLAUDE_PROJECT_DIR:-$(dirname "$0")/../..}"

# Install locked dependencies once; the cached container keeps node_modules.
if [ ! -d node_modules ]; then
  npm ci --no-audit --no-fund
fi

# Turbo-cached build of the runtime and packaged skill used by `rea mcp`.
npm run build:cached
