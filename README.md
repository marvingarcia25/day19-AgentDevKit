# AgentDevKit

**A batteries-included bootstrap for your first agentic AI development environment.**

Clone this repo, run one setup script, and you have a sensible, tool-agnostic configuration for
coding agents like **Claude Code**, **OpenAI Codex**, **Cursor**, and anything else that reads the
[`AGENTS.md`](https://agents.md) standard — complete with ready-made sub-agents, slash commands,
a reusable prompt library, MCP wiring, and the best practices baked in.

> Day 19 of my 1000 days challenge. Day 18 was a framework for *building* an AI app; this one is
> about *configuring the AI agents that build your apps*.

---

## Why this exists

The first time you open an agentic coding tool, you face a blank `CLAUDE.md`, an empty
`.claude/agents/` folder, and a dozen blog posts disagreeing about how to use them. Most people
either under-configure (and the agent guesses badly) or over-configure (and the agent drowns in a
2,000-line instruction file it can't follow).

AgentDevKit is the configuration a senior engineer would hand you on day one:

- **One source of truth, many tools.** Your conventions live in `AGENTS.md` (the open standard).
  `CLAUDE.md` imports it and adds only Claude-specific bits. No copy-paste drift between tools.
- **Specialists, not a generalist.** Six focused sub-agents (planner, reviewer, debugger, test
  writer, security reviewer, docs writer) each with a tight system prompt and least-privilege tools.
- **Repeatable workflows.** Slash commands turn "plan this, then review it, then write tests" into
  `/plan`, `/review`, `/test`.
- **Guardrails, not vibes.** Hooks and `settings.json` enforce formatting and protect sensitive
  paths — because instructions are suggestions, hooks are rules.
- **Designed to be read.** Every file is short, commented, and meant to be edited. Delete what you
  don't need.

---

## Quickstart

```bash
# 1. Get the kit (copy it into a new or existing project)
git clone https://github.com/<you>/agent-dev-kit my-project
cd my-project

# 2. Run setup — fills in project name, picks the tools you use, removes the rest
./scripts/setup.sh           # macOS / Linux / WSL / Git Bash
#   or
pwsh ./scripts/setup.ps1     # Windows PowerShell

# 3. Open your agent and go
claude          # Claude Code reads CLAUDE.md + .claude/ automatically
codex           # Codex reads AGENTS.md automatically
```

That's it. The agent now knows your conventions, has specialists to delegate to, and slash
commands for your common workflows.

---

## What's inside

```
agent-dev-kit/
├── AGENTS.md                 # ⭐ Source of truth: conventions every tool reads
├── CLAUDE.md                 # Claude Code entry point — imports AGENTS.md + CC specifics
├── .mcp.json                 # Example MCP servers (project scope, env-var expansion)
├── .claude/
│   ├── settings.json         # Team-shared permissions + hooks (checked into git)
│   ├── agents/               # Sub-agents — specialists Claude delegates to
│   │   ├── planner.md
│   │   ├── code-reviewer.md
│   │   ├── debugger.md
│   │   ├── test-writer.md
│   │   ├── security-reviewer.md
│   │   └── docs-writer.md
│   ├── commands/             # Slash commands — repeatable workflows
│   │   ├── plan.md  review.md  test.md  commit.md  explain.md
│   ├── hooks/                # Enforced automation (format, protect paths)
│   └── rules/                # Path-scoped instructions loaded on demand
├── prompts/                  # Reusable, tool-agnostic prompt library
├── templates/                # Copy-paste starting points for new agents/commands
├── docs/                     # Onboarding guides — start with getting-started.md
└── scripts/                  # setup.sh / setup.ps1
```

---

## The mental model

| Concept | What it is | Where it lives | Read more |
|---|---|---|---|
| **Memory / instructions** | Persistent rules the agent loads every session | `AGENTS.md`, `CLAUDE.md` | [docs/writing-instructions.md](docs/writing-instructions.md) |
| **Sub-agents** | Specialists with their own context + tools the main agent delegates to | `.claude/agents/*.md` | [docs/sub-agents.md](docs/sub-agents.md) |
| **Slash commands** | Saved prompts you invoke with `/name` | `.claude/commands/*.md` | [docs/slash-commands.md](docs/slash-commands.md) |
| **Hooks** | Scripts that run on events — the enforcement layer | `.claude/settings.json` + `.claude/hooks/` | [docs/hooks.md](docs/hooks.md) |
| **MCP** | Connectors to external tools/data (GitHub, DBs, browsers) | `.mcp.json` | [docs/mcp.md](docs/mcp.md) |
| **Prompts** | Reusable instructions you paste into any tool | `prompts/` | [prompts/README.md](prompts/README.md) |

**The golden rule:** instructions shape behavior; hooks enforce it. If something *must* happen,
make it a hook. If it *should usually* happen, write it in `AGENTS.md`.

---

## Where to start reading

1. **[docs/getting-started.md](docs/getting-started.md)** — a 5-minute tour and your first edits.
2. **[AGENTS.md](AGENTS.md)** — the file every tool reads. Make it yours.
3. **[docs/best-practices.md](docs/best-practices.md)** — the principles behind every file here.
4. **[.claude/agents/planner.md](.claude/agents/planner.md)** — read one sub-agent to understand
   the shape of all of them.

---

## Tool support

| Tool | Reads | Notes |
|---|---|---|
| **Claude Code** | `CLAUDE.md`, `.claude/` | Full support: sub-agents, commands, hooks, MCP. |
| **OpenAI Codex** | `AGENTS.md` | Conventions + MCP. Sub-agents/commands are CC-specific. |
| **Cursor** | `AGENTS.md` | Conventions. Has its own rules UI you can mirror. |
| **Gemini CLI / others** | `AGENTS.md` | Anything following the open standard gets your conventions. |

The kit is deliberately layered so non-Claude tools still get the most important thing — your
conventions — even though the richer features (sub-agents, hooks) are Claude Code-specific today.

---

## License

MIT. Take it, fork it, delete half of it. The best agent config is the one you actually maintain.
