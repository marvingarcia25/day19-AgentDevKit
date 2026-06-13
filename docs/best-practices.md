# Best practices

The principles every file in this kit is built on. Steal these even if you throw the rest away.

## 1. One source of truth, many tools

Put conventions in `AGENTS.md` (the open standard). Have tool-specific files *import* it rather than
duplicate it (`CLAUDE.md` does `@AGENTS.md`). Duplicated instructions drift; drifted instructions
contradict each other; contradictions make the agent unreliable.

## 2. Short instructions beat long ones

The agent loads `AGENTS.md`/`CLAUDE.md` every session. Long files dilute attention — a rule buried on
line 400 gets ignored. Include only what the agent **can't guess**:

| ✅ Include | ❌ Leave out |
|---|---|
| Commands it can't guess (build, test-one) | Things it can learn by reading the code |
| Conventions that differ from the defaults | Standard language idioms it already knows |
| Repo etiquette (branches, PRs) | Long tutorials or explanations |
| Env quirks, required vars, gotchas | File-by-file descriptions of the codebase |
| Architectural decisions specific to you | "Write clean code" and other truisms |

If the agent keeps ignoring a rule, your file is probably too long — prune, don't add emphasis.

## 3. Specialists over a generalist

A sub-agent with a tight system prompt and least-privilege tools outperforms one mega-prompt trying
to do everything. Each agent here does one job (plan, review, debug, test, secure, document) and
runs in its **own context window**, so a long review doesn't pollute your main thread. Give each only
the tools it needs — the `code-reviewer` is read-only; it can't accidentally change your code.

## 4. Instructions suggest; hooks enforce

`AGENTS.md` shapes behavior but is not enforcement — the agent can decide not to follow it. When
something **must** happen (formatting, blocking edits to `.env`, running a check), use a **hook** or
a **permission rule** in `settings.json`. Those run regardless of what the agent decides.

## 5. Plan before code, verify before "done"

- **Plan first** for any non-trivial task. A wrong plan is cheap to fix; wrong code isn't.
- **Verify before claiming success.** "Tests pass" means you ran them and read the output. Evidence
  before assertions — every time.

## 6. Surgical changes

Touch only what the task requires. Don't "improve" adjacent code, reformat untouched lines, or
refactor things that aren't broken. Every changed line should trace to the request. This keeps diffs
reviewable and keeps the agent from quietly breaking working code.

## 7. Least privilege by default

Start agents and permissions restrictive; widen as needed. Deny destructive commands
(`rm -rf`, `git push --force`) and reads of secret paths in `settings.json`. It's easier to grant a
missing permission than to recover from a granted-too-much one.

## 8. Treat agent config like code

Check it into git. Review changes to `AGENTS.md` and agents in PRs. Prune regularly. The config
compounds in value — but only if you maintain it like the rest of your codebase.
