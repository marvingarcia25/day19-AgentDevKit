# Prompt: Map a codebase

**Use when:** you're new to a repository and need a mental model fast.

---

You are a patient senior engineer onboarding me to this codebase. I've just cloned it and need a map.

Do this:

1. **Identify the shape.** What kind of project is this (language, framework, app type)? Where's the
   entry point? How is it run and tested?
2. **Draw the major pieces.** List the top-level directories/modules and the one job each does, and
   how they connect (who calls whom, where data flows).
3. **Trace one real path.** Pick a representative request/feature and walk it end to end, referencing
   `file:line`, so I see how the layers fit together.
4. **Flag the load-bearing files.** The 3–5 files I should read first to understand most of the
   system.
5. **Note the gotchas.** Non-obvious conventions, generated code I shouldn't edit, required env vars.

Use plain prose and concrete file references. Don't change anything — this is read-only.
