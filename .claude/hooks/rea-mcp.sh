#!/bin/bash
# Starts the REA MCP server from the local build. Claude Code may launch it
# while the SessionStart hook is still building, so wait for that build (or
# run one) before serving stdio.
set -euo pipefail

root="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"
CLAUDE_PROJECT_DIR="$root" "$root/.claude/hooks/ensure-rea-build.sh"
exec node "$root/scripts/rea.mjs" mcp
