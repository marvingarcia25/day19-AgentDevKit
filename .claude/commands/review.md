---
description: Review the current diff for bugs, regressions, and convention violations
allowed-tools: Bash(git diff:*), Bash(git status:*), Read, Grep, Glob
---

Review my uncommitted changes before I commit.

Current changes:
```
!`git diff --stat`
```

Delegate to the `code-reviewer` sub-agent. Have it review the full diff and report findings grouped
as 🔴 Must fix / 🟡 Should fix / 🟢 Consider, each with `file:line` and a concrete fix. If anything
touches auth, input handling, secrets, or external requests, also run the `security-reviewer`.
