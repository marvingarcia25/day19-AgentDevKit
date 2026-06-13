# MCP — connecting external tools

The **Model Context Protocol** lets your agent talk to external systems — GitHub, databases, a
browser, your filesystem, internal APIs — through a standard interface. An MCP server exposes tools;
your agent calls them like any other tool.

## Configuring servers

This kit ships `.mcp.json` at the repo root (project scope). It's checked into git, so the whole team
gets the same tools. Each entry names a server and how to launch it:

```jsonc
{
  "mcpServers": {
    "github": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": { "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_TOKEN}" }
    }
  }
}
```

## Scopes — who gets the server

| Scope | Loads in | Shared with team | Stored in |
|---|---|---|---|
| **Local** (default) | Current project only | No | `~/.claude.json` |
| **Project** | Current project only | **Yes**, via git | `.mcp.json` (this kit) |
| **User** | All your projects | No | `~/.claude.json` |

Use **project** scope for tools the whole team needs (this repo's GitHub, its database). Use **user**
scope for personal tools you want everywhere. When the same server is defined twice, local wins over
project wins over user.

## Secrets: never hardcode them

`.mcp.json` is in git, so it must not contain tokens. Use environment-variable expansion:

- `${GITHUB_TOKEN}` — expands to the env var; empty if unset.
- `${DB_URL:-postgres://localhost/dev}` — uses a default when the var is unset.

Put the real values in your shell or a git-ignored `.env`. This is why `.env` is both `.gitignore`d
and blocked by the `protect-paths` hook.

## Adding a server

1. Find one (the official servers cover filesystem, fetch, GitHub, git, and more; many vendors ship
   their own).
2. Add an entry to `.mcp.json`, passing any secrets via `${VAR}`.
3. Restart the agent. In Claude Code, run `/mcp` to confirm it connected and see its tools.

## A caution

Each MCP server is code you're running and tools you're handing the agent. Add servers you trust,
grant them the least access they need, and keep credentials in env vars. More tools also means more
context the agent has to reason over — don't connect servers you won't use.
