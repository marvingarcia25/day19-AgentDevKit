---
description: Write or improve tests for the given target, then run them
argument-hint: <file, function, or feature to test>
---

Add tests for: $ARGUMENTS

Delegate to the `test-writer` sub-agent. It should:
1. Read existing tests to match the project's framework and style.
2. Cover the happy path, edge cases, and failure modes — testing behavior, not internals.
3. Run the test suite (see the test command in `AGENTS.md`) and show the output.

Report what was covered, what was intentionally skipped and why, and the test run result.
