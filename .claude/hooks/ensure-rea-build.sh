#!/bin/bash
# Installs locked dependencies and builds REA under one lock so the
# SessionStart hook and the MCP launcher never build concurrently.
# Usage: ensure-rea-build.sh [--always]
#   --always  run the turbo-cached build even when dist/main.js exists.
# Build output goes to stderr; MCP stdio requires a clean stdout.
set -euo pipefail

cd "${CLAUDE_PROJECT_DIR:-$(dirname "$0")/../..}"

if command -v flock >/dev/null 2>&1; then
  lock="${TMPDIR:-/tmp}/rea-build-$(pwd | cksum | cut -d' ' -f1).lock"
  exec 9>"$lock"
  flock 9
fi

{
  if [ ! -d node_modules ]; then
    npm ci --no-audit --no-fund
  fi
  if [ "${1:-}" = "--always" ] || [ ! -f dist/main.js ]; then
    npm run build:cached
  fi
} 1>&2
