# Path-scoped rules

Files here let you scope instructions to specific file types or directories, so the main
`AGENTS.md` / `CLAUDE.md` stays short. Claude Code loads a rule **on demand** when it touches files
the rule applies to — they don't all load at session start, which keeps context lean.

Create a rule as a markdown file with frontmatter declaring what it applies to:

```markdown
---
description: Conventions for React components
globs: ["src/components/**/*.tsx"]
---

- Components are function components with typed props; no `React.FC`.
- Co-locate the test as `Component.test.tsx`.
- Styling via CSS modules, not inline styles.
```

Good candidates for a scoped rule (instead of cluttering AGENTS.md):

- Frontend conventions that only apply under `src/components/`
- Database/migration rules that only apply under `db/`
- Test conventions that only apply to `*.test.*` files
- Generated code that should never be hand-edited

Keep each rule short and specific. If a rule applies everywhere, it belongs in `AGENTS.md` instead.
