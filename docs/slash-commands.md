# Slash commands

A slash command is a saved prompt you invoke with `/name`. It turns a workflow you'd otherwise retype
every time into one token. They live as markdown files in `.claude/commands/` (project) or
`~/.claude/commands/` (personal).

## Anatomy

```markdown
---
description: One line shown in the command list
argument-hint: <what to type after the command>
allowed-tools: Bash(git diff:*), Read, Grep   # optional: restrict tools for this command
---

The prompt body. Use $ARGUMENTS for everything the user typed after the command,
or $1, $2 for positional args.

Embed live command output with a leading bang in backticks:
!`git status --short`

Reference a file's contents with @:
@AGENTS.md
```

## The three superpowers

1. **`$ARGUMENTS` / `$1`** — inject what the user typed. `/test signup form` → `$ARGUMENTS` is
   "signup form".
2. **`` !`command` ``** — run a shell command and inline its output into the prompt *before* the
   agent sees it. Great for `git status`, `git diff`, build output.
3. **`@file`** — pull a file's contents into the prompt. Great for "follow the conventions in
   `@AGENTS.md`".

## What makes a good command

- **Encodes a repeated workflow**, not a one-off. `/review`, `/commit`, `/plan` are run dozens of
  times; a bespoke task isn't worth a file.
- **Composes sub-agents.** The best commands delegate: `/review` calls the `code-reviewer` agent.
  The command is the *trigger and context*; the agent is the *expertise*.
- **Scoped tools.** Use `allowed-tools` to keep a command from doing more than its job.

## The commands in this kit

| Command | Does |
|---|---|
| `/plan <task>` | Breaks a task into a verifiable plan before any code (via `planner`). |
| `/review` | Reviews the current diff (via `code-reviewer`, plus `security-reviewer` when relevant). |
| `/test <target>` | Writes and runs tests (via `test-writer`). |
| `/commit` | Conventional commit of current work; never pushes. |
| `/explain <thing>` | Read-only walkthrough of a file, function, or flow. |

Copy `templates/command.md.template` to start your own.
