# AgentDevKit setup (Windows PowerShell) — personalize the kit for your project.
# Safe to run more than once. Everything it does is reversible (it's your repo now).

$ErrorActionPreference = "Stop"
Set-Location (Join-Path $PSScriptRoot "..")   # repo root

function Ask($prompt, $default) {
  $r = Read-Host $prompt
  if ([string]::IsNullOrWhiteSpace($r)) { return $default } else { return $r }
}

Write-Host "AgentDevKit setup" -ForegroundColor Cyan
Write-Host "This personalizes AGENTS.md and removes the parts you don't need. Press Enter for defaults.`n"

# --- Project name -------------------------------------------------------------
$defaultName = Split-Path -Leaf (Get-Location)
$project = Ask "Project name [$defaultName]" $defaultName

if (Select-String -Path "AGENTS.md" -Pattern "<language/framework>" -Quiet) {
  Write-Host "-> AGENTS.md still has placeholders. Open it and fill them in - it's the highest-value file." -ForegroundColor Yellow
}

# --- Tool selection -----------------------------------------------------------
Write-Host ""
$useClaude = Ask "Use Claude Code? [Y/n]" "Y"
$useCodex  = Ask "Use Codex / Cursor / other AGENTS.md tools? [Y/n]" "Y"

if ($useClaude -match '^[Nn]') {
  Write-Host "  You can remove the Claude-specific bits: Remove-Item -Recurse -Force .claude, CLAUDE.md"
}
if ($useCodex -match '^[Nn]') {
  Write-Host "  AGENTS.md still helps Claude Code via the @AGENTS.md import - keeping it is recommended."
}

# --- MCP reminder -------------------------------------------------------------
Write-Host ""
Write-Host '-> MCP: edit .mcp.json to keep only the servers you use. Put secrets in env vars (${VAR}).' -ForegroundColor Yellow

# --- Next steps ---------------------------------------------------------------
Write-Host ""
Write-Host "Setup complete for: $project" -ForegroundColor Green
@"

Next:
  1. Fill in AGENTS.md   - replace every <placeholder>. The highest-leverage step.
  2. Trim .mcp.json      - keep only the MCP servers you'll use.
  3. Open your agent:
       claude            (reads CLAUDE.md + .claude/ automatically)
       codex             (reads AGENTS.md automatically)
  4. Try the loop:  /plan  ->  implement  ->  /review  ->  /test  ->  /commit

Read docs/getting-started.md for the full tour.
"@ | Write-Host

# Note: PowerShell doesn't use Unix execute bits; the bash hooks run under Git Bash / WSL,
# which Claude Code uses for its Bash tool. No chmod needed here.
