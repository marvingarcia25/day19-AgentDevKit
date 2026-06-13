# Hooks — the enforcement layer

A hook is a script that runs automatically on an agent event. Unlike `AGENTS.md` instructions — which
the agent *may* follow — a hook runs **every time**, no matter what the agent decides. This is how you
turn "please format your code" into "code is always formatted."

## When to reach for a hook

Use an instruction when something *should usually* happen. Use a hook when it **must**:

| Need | Mechanism |
|---|---|
| "Usually run tests before done" | Instruction in `AGENTS.md` |
| "Always format files after editing" | `PostToolUse` hook (this kit's `format.sh`) |
| "Never let the agent edit `.env`" | `PreToolUse` hook (this kit's `protect-paths.sh`) or `permissions.deny` |
| "Notify me when a long task finishes" | `Stop` hook |

## How they're wired

Hooks are declared in `.claude/settings.json` under `hooks`, matched to an event and a tool pattern:

```jsonc
"hooks": {
  "PreToolUse": [
    { "matcher": "Edit|Write",
      "hooks": [{ "type": "command", "command": ".claude/hooks/protect-paths.sh" }] }
  ],
  "PostToolUse": [
    { "matcher": "Edit|Write",
      "hooks": [{ "type": "command", "command": ".claude/hooks/format.sh" }] }
  ]
}
```

Common events: `PreToolUse` (before a tool runs — can **block** it), `PostToolUse` (after),
`UserPromptSubmit`, `Stop`, `SubagentStop`, `SessionStart`.

## The contract

- The hook receives the event as **JSON on stdin** (tool name, arguments, file path, etc.).
- **Exit code 0** — allow / success.
- **Exit code 2** — block the action; stderr is fed back to the agent as the reason. This is what
  `protect-paths.sh` uses to stop edits to `.env`.
- Keep hooks **fast and idempotent** — `PostToolUse: Edit|Write` runs after *every* edit.

## This kit's hooks

- **`format.sh`** (`PostToolUse`) — formats the file the agent just wrote, by extension (Prettier,
  Black, `dotnet format`, gofmt). No-ops if the formatter isn't installed.
- **`protect-paths.sh`** (`PreToolUse`) — blocks writes to `.env`, `secrets/`, `.git/`, and
  `node_modules/`. Edit the `protected` list to match your repo.

## Windows note

The shipped hooks are bash (they run under Git Bash / WSL, which Claude Code uses for Bash tools).
On pure PowerShell setups, point the `command` at a `.ps1` equivalent, or invoke
`bash .claude/hooks/format.sh`. The format hook degrades gracefully — if a formatter is missing it
simply does nothing.
