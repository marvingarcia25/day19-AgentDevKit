---
description: Stage, write a conventional commit message, and commit the current changes
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git diff:*), Bash(git commit:*), Bash(git log:*)
---

Create a commit for my current work.

Context:
```
!`git status --short`
!`git diff --stat`
```

Steps:
1. Review the changes so the message is accurate.
2. Verify there are no secrets, debug prints, or commented-out code in the diff. Stop if there are.
3. Follow this repo's commit conventions from `AGENTS.md` (imperative mood, one logical change).
4. Stage the relevant files and commit. Do **not** push unless I ask.
5. Show me the resulting `git log -1`.
