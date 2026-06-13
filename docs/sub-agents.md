# Sub-agents

A sub-agent is a specialist the main agent delegates to. It has its **own context window**, its
**own system prompt**, and its **own restricted toolset**. That isolation is the point: a long code
review or a deep debugging session runs in a separate context and returns only its conclusion, so
your main thread stays focused and uncluttered.

## Anatomy

A sub-agent is a markdown file with YAML frontmatter. The body becomes its system prompt.

```markdown
---
name: code-reviewer            # required: lowercase-hyphenated, unique
description: When to delegate to this agent. Be specific — this is how the main agent decides to use it.
tools: Read, Grep, Glob, Bash  # optional: omit to inherit all tools. List only what it needs.
model: sonnet                  # optional: sonnet | opus | haiku | fable, or a full model id
---

You are a meticulous senior code reviewer.
When invoked: 1. run git diff … 2. check correctness, regressions … 3. report by severity …
```

Only `name` and `description` are required.

## Where they live

| Location | Scope |
|---|---|
| `.claude/agents/` (this kit) | Project — shared with the team via git |
| `~/.claude/agents/` | User — available in all your projects |

Project agents win over user agents with the same name.

## Writing a good one

1. **Sharp `description`.** The main agent reads it to decide when to delegate. "Use proactively
   after writing code that handles user input" beats "reviews code." Add "use proactively" / "MUST
   BE USED" when you want eager delegation.
2. **Least-privilege `tools`.** A reviewer that only reads can't accidentally edit. A planner with
   no `Edit`/`Write` can't jump to coding. Restricting tools shapes behavior as much as the prompt.
3. **One job.** If a prompt has "and also…", split it into two agents.
4. **Concrete method, not vibes.** Give numbered steps and a defined output format. The six agents in
   `.claude/agents/` are worked examples — copy their shape.
5. **Pick the model for the job.** Reasoning-heavy work (planning, debugging, security) → `opus`.
   Mechanical, high-volume work (reviews, tests, docs) → `sonnet`. Cheap/fast → `haiku`.

## Using them

- Automatic: the main agent delegates based on the `description` when the task matches.
- Explicit: ask "use the security-reviewer to check this" or wire it into a slash command (see
  `.claude/commands/review.md`).

## Common mistakes

- **Too broad.** A "do everything" agent is just the main agent with extra steps.
- **Inherits all tools by accident.** Omitting `tools` grants everything — usually not what you want
  for a read-only specialist.
- **Vague description.** If the main agent can't tell when to use it, it won't.
