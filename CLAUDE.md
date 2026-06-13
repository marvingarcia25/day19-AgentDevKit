# CLAUDE.md

This file is Claude Code's entry point. It imports the shared, tool-agnostic conventions and adds
only the Claude-specific bits, so there's no duplication between tools.

## Project conventions

@AGENTS.md

<!--
The line above imports AGENTS.md in full. Keep your real project conventions in AGENTS.md so every
tool (Codex, Cursor, …) sees them. Put ONLY Claude-Code-specific guidance below.
-->

## Working with this repo in Claude Code

- **Delegate to specialists.** This repo ships sub-agents in `.claude/agents/`. Prefer them for
  their specialty: `planner` for breaking down work, `code-reviewer` before committing, `debugger`
  for failures, `test-writer` for coverage, `security-reviewer` for anything touching auth/input,
  `docs-writer` for READMEs and guides.
- **Use the slash commands.** `/plan`, `/review`, `/test`, `/commit`, and `/explain` encode the
  standard workflows — reach for them instead of re-explaining each time.
- **Hooks are active.** Formatting runs automatically on file writes and certain paths are
  protected (see `.claude/settings.json`). If an edit is blocked, that's the guardrail, not a bug.
- **MCP servers** are declared in `.mcp.json`. Run `/mcp` to see what's connected.

## Before you say "done"

Run the verification this project expects (tests + formatter from AGENTS.md) and read the output
before reporting success. Evidence before assertions — every time.
