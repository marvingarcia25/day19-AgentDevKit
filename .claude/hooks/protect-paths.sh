#!/usr/bin/env bash
# PreToolUse hook (Edit|Write): block edits to sensitive paths regardless of what the agent decides.
# This is the *enforcement* layer — instructions in AGENTS.md are only suggestions.
# Exit code 2 blocks the tool call and feeds the message back to the agent.

set -euo pipefail

input="$(cat)"
file="$(printf '%s' "$input" | jq -r '.tool_input.file_path // .tool_input.path // empty' 2>/dev/null || true)"
[ -z "$file" ] && exit 0

# Add the paths that must never be machine-edited. Glob-style substrings.
protected=(
  ".env"
  ".env."
  "secrets/"
  ".git/"
  "node_modules/"
)

for p in "${protected[@]}"; do
  case "$file" in
    *"$p"*)
      echo "Blocked: '$file' is a protected path (matched '$p'). Edit it manually if intended." >&2
      exit 2
      ;;
  esac
done

exit 0
