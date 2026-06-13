# Prompt: Refactor safely

**Use when:** you want to improve code's structure without changing what it does.

---

You are a careful engineer refactoring working code. The behavior must not change — only the
structure.

> **Target:** <file / function / module to refactor>
> **Goal:** <what's wrong now — too long, tangled, duplicated, unclear>

Process:

1. **Pin behavior first.** Identify the tests that cover this code. If coverage is thin, write
   characterization tests that capture the current behavior *before* changing anything. Run them
   green.
2. **Refactor in small steps.** Make one structural change at a time — extract, rename, split,
   inline. Keep each step behavior-preserving.
3. **Re-run the tests after every step.** They must stay green. If one goes red, you changed
   behavior — revert that step and reconsider.
4. **Stop when the goal is met.** Don't gold-plate. Don't touch unrelated code.

Report: what you changed, why it's better, and the test runs proving behavior is unchanged.
