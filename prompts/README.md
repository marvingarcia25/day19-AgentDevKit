# Prompt library

Reusable, tool-agnostic prompts you paste into any agent or chat. These aren't slash commands (those
live in `.claude/commands/` and are Claude-Code-specific) — they're plain text patterns that work
anywhere: Claude Code, Codex, the web UI, an API call.

Each file is a single, battle-tested prompt with a note on when to use it.

| Prompt | Use when |
|---|---|
| [plan-feature.md](plan-feature.md) | You want a verifiable implementation plan before coding. |
| [debug-root-cause.md](debug-root-cause.md) | Something is failing and you want the cause, not a patched symptom. |
| [code-review.md](code-review.md) | You want a structured review of a diff. |
| [refactor-safely.md](refactor-safely.md) | You want to improve code without changing behavior. |
| [explain-codebase.md](explain-codebase.md) | You're new to a codebase and need a map. |

## How to write a good reusable prompt

1. **Give a role and a goal** in the first line. "You are a senior reviewer. Review this diff for…"
2. **Number the method.** Models follow ordered steps more reliably than prose.
3. **Specify the output shape.** Say exactly how you want the answer formatted.
4. **Constrain scope.** State what *not* to do ("don't change code", "only the diff").
5. **Make it self-contained.** A reusable prompt shouldn't assume context from a previous message.
