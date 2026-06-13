#!/usr/bin/env bash
# AgentDevKit setup — personalize the kit for your project.
# Safe to run more than once. Everything it does is reversible (it's your repo now).

set -euo pipefail
cd "$(dirname "$0")/.."   # repo root

bold() { printf '\033[1m%s\033[0m\n' "$1"; }
ask()  { read -r -p "$1" REPLY; echo "${REPLY:-$2}"; }

bold "AgentDevKit setup"
echo "This personalizes AGENTS.md and removes the parts you don't need. Press Enter to accept defaults."
echo

# --- Project name -------------------------------------------------------------
default_name="$(basename "$PWD")"
project="$(ask "Project name [$default_name]: " "$default_name")"

# Replace the first placeholder heading occurrence in AGENTS.md project overview.
if grep -q "This is a \`<language/framework>\`" AGENTS.md 2>/dev/null; then
  bold "→ AGENTS.md still has placeholders. Open it and fill them in — it's the highest-value file."
fi

# --- Make hook scripts executable --------------------------------------------
chmod +x .claude/hooks/*.sh 2>/dev/null || true
chmod +x scripts/*.sh 2>/dev/null || true
bold "→ Made hook + setup scripts executable."

# --- Tool selection: trim what you don't use ---------------------------------
echo
echo "Which agent tools do you use? (others' config will be left in place but you can delete it)"
use_claude="$(ask "Use Claude Code? [Y/n]: " "Y")"
use_codex="$(ask "Use Codex / Cursor / other AGENTS.md tools? [Y/n]: " "Y")"

case "$use_claude" in [Nn]*)
  echo "  You can remove the Claude-specific bits: rm -rf .claude CLAUDE.md" ;;
esac
case "$use_codex" in [Nn]*)
  echo "  AGENTS.md still benefits Claude Code via the @AGENTS.md import — keeping it is recommended." ;;
esac

# --- MCP reminder -------------------------------------------------------------
echo
bold "→ MCP: edit .mcp.json to keep only the servers you use. Put secrets in env vars (\${VAR})."

# --- Next steps ---------------------------------------------------------------
echo
bold "Setup complete for: $project"
cat <<'EOF'

Next:
  1. Fill in AGENTS.md   — replace every <placeholder>. This is the highest-leverage step.
  2. Trim .mcp.json      — keep only the MCP servers you'll use.
  3. Open your agent:
       claude            (reads CLAUDE.md + .claude/ automatically)
       codex             (reads AGENTS.md automatically)
  4. Try the loop:  /plan  →  implement  →  /review  →  /test  →  /commit

Read docs/getting-started.md for the full tour.
EOF
