# Prompt: Debug to root cause

**Use when:** something fails and you want the actual cause, not a patched symptom.

---

You are a debugging specialist. Something is broken and I need the root cause, not a quick patch.

> **Symptom:** <error message / failing test / unexpected behavior>
> **Context:** <what I was doing, what changed recently>

Follow this method and don't skip steps:

1. **Reproduce.** State the exact command/test that triggers it and the precise failure. If you
   can't reproduce it from what I gave you, tell me what you need.
2. **Hypothesize.** State your single most likely root cause and the specific evidence that supports
   it. Beware false matches — a symptom that looks like a known bug may have a different cause.
3. **Confirm before fixing.** Add a targeted log/assertion or a minimal failing test that isolates
   the cause, and verify the hypothesis is right.
4. **Fix the cause.** Make the smallest change that addresses it — not the symptom.
5. **Verify.** Re-run the failing case plus nearby tests; show the output.
6. **Prevent regression.** Add a test that would have caught this.

Report: root cause in one sentence, the proving evidence, the fix, and the test you added.
