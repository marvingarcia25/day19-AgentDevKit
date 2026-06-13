#!/usr/bin/env bash
# PostToolUse hook (Edit|Write): auto-format the file the agent just touched.
# Receives the tool-call JSON on stdin. Exits 0 so it never blocks the agent.
#
# Wire it up in .claude/settings.json (already done in this kit). Add the formatters
# your project uses below — this runs after every Edit/Write so keep it fast.

set -euo pipefail

input="$(cat)"
# Extract the edited file path from the hook payload (requires jq; no-op if absent).
file="$(printf '%s' "$input" | jq -r '.tool_input.file_path // .tool_input.path // empty' 2>/dev/null || true)"
[ -z "$file" ] && exit 0
[ -f "$file" ] || exit 0

case "$file" in
  *.ts|*.tsx|*.js|*.jsx|*.json|*.css|*.md)
    command -v npx >/dev/null 2>&1 && npx --no-install prettier --write "$file" >/dev/null 2>&1 || true
    ;;
  *.py)
    command -v black >/dev/null 2>&1 && black -q "$file" >/dev/null 2>&1 || true
    ;;
  *.cs)
    command -v dotnet >/dev/null 2>&1 && dotnet format --include "$file" >/dev/null 2>&1 || true
    ;;
  *.go)
    command -v gofmt >/dev/null 2>&1 && gofmt -w "$file" >/dev/null 2>&1 || true
    ;;
esac

exit 0
