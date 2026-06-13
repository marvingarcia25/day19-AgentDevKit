# Writing AGENTS.md and CLAUDE.md

Your instruction files are the agent's onboarding doc — loaded fresh every session. Getting them
right is the single biggest lever on agent quality. This guide is how to write them well.

## The split: AGENTS.md vs CLAUDE.md

- **`AGENTS.md`** — everything tool-agnostic: conventions, commands, structure, etiquette. Every tool
  reads it (the [open standard](https://agents.md)).
- **`CLAUDE.md`** — imports `AGENTS.md` via `@AGENTS.md`, then adds only Claude-Code-specific notes
  (which sub-agents to use, that hooks are active). Keep it thin.

This way you maintain one file, and Codex/Cursor/Gemini stay in sync for free.

## The hierarchy (Claude Code)

CLAUDE.md files load by scope, most-specific winning:

| Scope | Location | For |
|---|---|---|
| Managed | OS-level managed path | Org-wide policy (IT/DevOps) |
| User | `~/.claude/CLAUDE.md` | Your personal prefs across all projects |
| Project | `./CLAUDE.md` or `./.claude/CLAUDE.md` | Team-shared, in git (this kit) |
| Local | `./CLAUDE.local.md` | Your machine-only notes (git-ignored) |

Ancestor files load in full at launch; subdirectory files load on demand. For big repos, push
narrow, path-scoped rules into `.claude/rules/` (see [the rules README](../.claude/rules/README.md))
so the top-level file stays short.

## What to include (and not)

| ✅ Include | ❌ Leave out |
|---|---|
| Commands the agent can't guess | Anything it can learn from the code |
| Conventions that differ from defaults | Standard idioms it already knows |
| Branch/PR/commit etiquette | Info that changes often (link instead) |
| Required env vars, setup quirks | File-by-file codebase descriptions |
| Non-obvious gotchas | "Write clean code" truisms |

## Make it stick

- **Be specific and concise.** "Use `pnpm`, not `npm`" beats a paragraph on package management.
- **Structure with headers** so the agent can navigate it.
- **Emphasis sparingly.** `IMPORTANT:` / `YOU MUST` raise adherence — but if *everything* is
  important, nothing is.
- **Import, don't duplicate.** `@path/to/file` pulls another file in. `CLAUDE.md` uses `@AGENTS.md`.
- **Test it.** Change a rule, watch whether behavior actually shifts. Treat the file like code:
  review it when things go wrong, prune it regularly.

## Failure smells

- The agent ignores a rule → the file is probably too long; that rule is getting lost. Prune.
- The agent asks something the file answers → the phrasing is ambiguous; make it explicit.
- Two tools behave differently → you duplicated instead of imported, and they've drifted.

## Auto memory (bonus)

Beyond the files you write, Claude Code keeps its own *auto memory* — notes it writes from your
corrections and preferences, indexed by a local `MEMORY.md`. You don't manage it, but know it exists:
when you correct the agent ("we use tabs"), it may remember next session. Run `/memory` to view/edit.
