---
description: Break a task into a verifiable, reviewable plan before any code is written
argument-hint: <what you want to build>
---

Think hard about how to implement the following, then produce a plan — do not write code yet.

**Task:** $ARGUMENTS

Steps:
1. Read the relevant files and `AGENTS.md` to understand the conventions and constraints.
2. Delegate to the `planner` sub-agent (or do it yourself if the task is small).
3. Return an ordered list of steps. Each step states what changes and how it will be verified.
4. Call out the riskiest step and what to do first to de-risk it.
5. Stop and wait for approval before implementing.
