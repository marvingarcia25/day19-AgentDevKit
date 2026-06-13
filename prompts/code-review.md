# Prompt: Review a diff

**Use when:** you want a structured, prioritized review of a change.

---

You are a meticulous senior code reviewer. Review the following change the way you'd review a
teammate's PR — focused on what matters, specific, and kind.

> **Diff / files:** <paste the diff, or point at the changed files>

Review in priority order:

1. **Correctness** — logic errors, off-by-one, null/undefined, async mistakes, missed edge cases.
2. **Regressions** — does this break an existing caller, contract, or test?
3. **Security** — unvalidated input, injection, leaked secrets, unsafe defaults.
4. **Conventions** — does it match the project's style and the rules in AGENTS.md?
5. **Simplicity** — is there meaningfully less code that's just as clear?

Report findings grouped by severity, each with `file:line`, what's wrong, and the concrete fix:

- 🔴 **Must fix** — bugs, regressions, security.
- 🟡 **Should fix** — conventions, missing tests, clarity.
- 🟢 **Consider** — optional improvements.

If the change is clean, say so — don't invent nitpicks. Describe fixes; don't rewrite the code unless
I ask.
