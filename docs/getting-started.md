# Getting started

A 10-minute tour of AgentDevKit and your first three edits. By the end you'll understand every file
here and have it configured for your project.

## 1. Run setup (1 min)

```bash
./scripts/setup.sh        # macOS / Linux / WSL / Git Bash
pwsh ./scripts/setup.ps1  # Windows PowerShell
```

It asks for your project name, which tools you use, and which sub-agents you want, then removes the
parts you don't need. Everything it does is reversible — it's your repo now.

## 2. Make `AGENTS.md` yours (5 min)

This is the highest-leverage file in the kit. Open [`AGENTS.md`](../AGENTS.md) and replace every
`<placeholder>` with the real thing:

- **Setup & test commands** — the exact commands. Agents iterate far faster when they don't have to
  guess how to run one test.
- **Conventions that differ from the defaults** — only these. Don't tell the agent things it already
  knows; a bloated file gets ignored.
- **Structure & boundaries** — what not to touch, what's generated.

Rule of thumb: if you'd have to explain it to a new hire on their first day, it goes in `AGENTS.md`.

## 3. Try the workflow (3 min)

Open your agent and run a real task through the kit:

```
/plan add input validation to the signup form
```

`/plan` delegates to the `planner` sub-agent, which reads your code and returns a verifiable plan.
Approve it, let the agent implement, then:

```
/review        # code-reviewer checks the diff
/test signup   # test-writer adds and runs tests
/commit        # conventional commit, no push
```

That's the core loop: **plan → implement → review → test → commit**, each step a specialist.

## 4. What to read next

| You want to… | Read |
|---|---|
| Understand the principles behind every file | [best-practices.md](best-practices.md) |
| Write your own sub-agent | [sub-agents.md](sub-agents.md) |
| Add a slash command | [slash-commands.md](slash-commands.md) |
| Connect external tools (GitHub, DBs) | [mcp.md](mcp.md) |
| Enforce a rule the agent keeps ignoring | [hooks.md](hooks.md) |
| Tune your instruction files | [writing-instructions.md](writing-instructions.md) |

## The one thing to remember

**Instructions shape behavior; hooks enforce it.** If the agent *should usually* do something, write
it in `AGENTS.md`. If it *must* happen, make it a hook. Don't try to make instructions do a hook's
job — you'll just grow the file until nothing in it gets followed.
