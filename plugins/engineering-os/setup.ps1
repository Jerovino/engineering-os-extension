# Engineering OS Setup Wizard — Windows (PowerShell)
# Sets up your personal Engineering OS vault and configures the plugin.
$ErrorActionPreference = "Stop"

$PluginDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ConfigDir = "$env:APPDATA\engineering-os"
$ConfigFile = "$ConfigDir\config.ps1"

# ─── Step 1: Idempotency check ────────────────────────────────────────────────

if (Test-Path $ConfigFile) {
    Write-Host ""
    Write-Host "Engineering OS is already configured."
    Write-Host ""
    . $ConfigFile
    Write-Host "  Config:  $ConfigFile"
    Write-Host "  Vault:   $env:VAULT_PATH"
    Write-Host "  Mode:    $env:ENGINEERING_OS_MODE"
    Write-Host ""
    Write-Host "To reconfigure, delete $ConfigFile and re-run this script."
    Write-Host ""
    exit 0
}

# ─── Step 2: Prerequisites ────────────────────────────────────────────────────

Write-Host ""
Write-Host "Engineering OS Setup"
Write-Host "===================="
Write-Host ""
Write-Host "Checking prerequisites..."

if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
    Write-Host ""
    Write-Host "ERROR: 'claude' CLI not found."
    Write-Host "Install Claude Code first: https://claude.ai/code"
    exit 1
}
Write-Host "  claude CLI:  found"

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "  git:         not found (required for Mode 2 / git backup)"
} else {
    Write-Host "  git:         found"
}

Write-Host ""
Write-Host "Note: Obsidian is optional. Any markdown editor works — VS Code,"
Write-Host "iA Writer, Typora, or even Notepad."
Write-Host ""

# ─── Step 3: Vault location ──────────────────────────────────────────────────

$DefaultVault = "$HOME\EngineeringOS"
$VaultInput = Read-Host "Where should your vault live? [default: $DefaultVault]"
if (-not $VaultInput) { $VaultPath = $DefaultVault } else { $VaultPath = $VaultInput }

Write-Host ""

# ─── Step 4: Mode selection ──────────────────────────────────────────────────

Write-Host "Choose a usage mode:"
Write-Host ""
Write-Host "  1) Local only        - vault lives on disk, no git backup"
Write-Host "  2) Local + Git repo  - vault is a private git repository;"
Write-Host "                         /daily-wrap-up and /weekly-checkpoint auto-commit"
Write-Host ""
$ModeInput = Read-Host "Mode [1 or 2, default: 1]"
if (-not $ModeInput) { $ModeInput = "1" }

switch ($ModeInput) {
    "1" { $EngOsMode = "local" }
    "2" { $EngOsMode = "repo" }
    default {
        Write-Host "Invalid choice. Defaulting to Mode 1 (local only)."
        $EngOsMode = "local"
    }
}

Write-Host ""

# ─── Step 5: Personalisation prompts ─────────────────────────────────────────

Write-Host "Tell me about yourself (used to personalize your vault files):"
Write-Host ""

$YourName          = Read-Host "Your full name"
$YourRole          = Read-Host "Your current title/role"
$YourCompany       = Read-Host "Your company name"
$AssistantNameIn   = Read-Host "What should I call your AI assistant? [default: Alex]"
if (-not $AssistantNameIn) { $AssistantName = "Alex" } else { $AssistantName = $AssistantNameIn }
$NumberOfTeams     = Read-Host "Number of teams you lead"
$NumberOfDirReps   = Read-Host "Number of direct reports"
$TotalPeople       = Read-Host "Total people across your teams"
$CurrentPriorities = Read-Host "Current top priorities (comma-separated)"

Write-Host ""

# ─── Step 6: Copy vault template ─────────────────────────────────────────────

Write-Host "Creating vault at: $VaultPath"

if (Test-Path $VaultPath) {
    Write-Host ""
    Write-Host "WARNING: Vault directory already exists at $VaultPath"
    $Confirm = Read-Host "Continue and copy template files into it? [y/N]"
    if ($Confirm -notmatch "^[yY]$") {
        Write-Host "Aborted. No files were changed."
        exit 0
    }
}

$VaultTemplatePath = Join-Path $PluginDir "vault-template"
Copy-Item -Path "$VaultTemplatePath\*" -Destination $VaultPath -Recurse -Force
Write-Host "  Vault files copied."

# ─── Step 7: Placeholder substitution ────────────────────────────────────────

Write-Host "  Personalizing vault files..."

Get-ChildItem -Path $VaultPath -Filter "*.md" -Recurse | ForEach-Object {
    $Content = Get-Content $_.FullName -Raw
    $Content = $Content -replace '\[YOUR_NAME\]',          $YourName
    $Content = $Content -replace '\[YOUR_ROLE\]',          $YourRole
    $Content = $Content -replace '\[YOUR_COMPANY\]',       $YourCompany
    $Content = $Content -replace '\[ASSISTANT_NAME\]',     $AssistantName
    $Content = $Content -replace '\[NUMBER_OF_TEAMS\]',    $NumberOfTeams
    $Content = $Content -replace '\[NUMBER_OF_DIRECT_REPORTS\]', $NumberOfDirReps
    $Content = $Content -replace '\[TOTAL_PEOPLE\]',       $TotalPeople
    $Content = $Content -replace '\[CURRENT_PRIORITIES\]', $CurrentPriorities
    Set-Content -Path $_.FullName -Value $Content -NoNewline
}

# Write mode marker into vault's CLAUDE.md
$ClaudeVaultMd = Join-Path $VaultPath "CLAUDE.md"
$ClaudeContent = Get-Content $ClaudeVaultMd -Raw
$ClaudeContent = $ClaudeContent -replace '<!-- SETUP: mode=local -->', "<!-- SETUP: mode=$EngOsMode -->"
Set-Content -Path $ClaudeVaultMd -Value $ClaudeContent -NoNewline

Write-Host "  Placeholders replaced."

# ─── Step 8: Write config file ───────────────────────────────────────────────

if (-not (Test-Path $ConfigDir)) {
    New-Item -ItemType Directory -Path $ConfigDir | Out-Null
}

@"
`$env:VAULT_PATH = "$VaultPath"
`$env:ENGINEERING_OS_MODE = "$EngOsMode"
"@ | Set-Content -Path $ConfigFile

Write-Host "  Config written: $ConfigFile"

# ─── Step 9: Git setup (mode 2 only) ─────────────────────────────────────────

if ($EngOsMode -eq "repo") {
    Write-Host ""
    Write-Host "Setting up git repository..."

    Push-Location $VaultPath
    try {
        git init -q
        git add -A
        git commit -q -m "Initial Engineering OS vault setup"
        Write-Host "  Git repository initialized."
        Write-Host ""

        if (Get-Command gh -ErrorAction SilentlyContinue) {
            $CreateRepo = Read-Host "Create a private GitHub repository for your vault? [Y/n]"
            if (-not $CreateRepo -or $CreateRepo -match "^[yY]$") {
                $RepoName = "engineering-os-vault"
                try {
                    gh repo create $RepoName --private --source=. --remote=origin --push -q
                    $GhUser = gh api user --jq .login
                    Write-Host "  Private repo created and pushed: github.com/$GhUser/$RepoName"
                } catch {
                    Write-Host "  gh repo create failed. See manual instructions below."
                    $ShowManual = $true
                }
            }
        } else {
            $ShowManual = $true
        }

        if ($ShowManual) {
            Write-Host "  To set up remote backup manually:"
            Write-Host ""
            Write-Host "    1. Create a private repo on GitHub (e.g., engineering-os-vault)"
            Write-Host "    2. Run:"
            Write-Host "       cd `"$VaultPath`""
            Write-Host "       git remote add origin git@github.com:<your-username>/engineering-os-vault.git"
            Write-Host "       git push -u origin main"
        }
    } finally {
        Pop-Location
    }
}

# ─── Done ─────────────────────────────────────────────────────────────────────

Write-Host ""
Write-Host "Setup complete!"
Write-Host ""
Write-Host "  Vault:  $VaultPath"
Write-Host "  Mode:   $EngOsMode"
Write-Host ""
Write-Host "Start your first session:"
Write-Host "  cd `"$VaultPath`"; claude"
Write-Host "  Then type: /morning"
Write-Host ""
