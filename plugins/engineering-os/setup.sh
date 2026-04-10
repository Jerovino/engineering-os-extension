#!/bin/sh
# Engineering OS Setup Wizard — macOS/Linux
# Sets up your personal Engineering OS vault and configures the plugin.
set -e

PLUGIN_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$HOME/.config/engineering-os"
CONFIG_FILE="$CONFIG_DIR/config"

# ─── Step 1: Idempotency check ────────────────────────────────────────────────

if [ -f "$CONFIG_FILE" ]; then
  echo ""
  echo "Engineering OS is already configured."
  echo ""
  echo "  Config:     $CONFIG_FILE"
  # shellcheck disable=SC1090
  . "$CONFIG_FILE"
  echo "  Vault:      $VAULT_PATH"
  echo "  Mode:       $ENGINEERING_OS_MODE"
  echo ""
  echo "To reconfigure, delete $CONFIG_FILE and re-run this script."
  echo ""
  exit 0
fi

# ─── Step 2: Prerequisites ────────────────────────────────────────────────────

echo ""
echo "Engineering OS Setup"
echo "===================="
echo ""
echo "Checking prerequisites..."

if ! command -v claude >/dev/null 2>&1; then
  echo ""
  echo "ERROR: 'claude' CLI not found."
  echo "Install Claude Code first: https://claude.ai/code"
  exit 1
fi
echo "  claude CLI:  found"

if ! command -v git >/dev/null 2>&1; then
  echo "  git:         not found (required for Mode 2 / git backup)"
else
  echo "  git:         found"
fi

echo ""
echo "Note: Obsidian is optional. Any markdown editor works — VS Code,"
echo "iA Writer, Typora, or even a plain text editor."
echo ""

# ─── Step 3: Vault location ──────────────────────────────────────────────────

DEFAULT_VAULT="$HOME/EngineeringOS"
printf "Where should your vault live? [default: %s]: " "$DEFAULT_VAULT"
read -r VAULT_PATH
VAULT_PATH="${VAULT_PATH:-$DEFAULT_VAULT}"
# Expand ~ manually if present
case "$VAULT_PATH" in
  "~"*) VAULT_PATH="$HOME${VAULT_PATH#"~"}" ;;
esac

echo ""

# ─── Step 4: Mode selection ──────────────────────────────────────────────────

echo "Choose a usage mode:"
echo ""
echo "  1) Local only        — vault lives on disk, no git backup"
echo "  2) Local + Git repo  — vault is a private git repository;"
echo "                         /daily-wrap-up and /weekly-checkpoint auto-commit"
echo ""
printf "Mode [1 or 2, default: 1]: "
read -r MODE_INPUT
MODE_INPUT="${MODE_INPUT:-1}"

case "$MODE_INPUT" in
  1) ENGINEERING_OS_MODE="local" ;;
  2) ENGINEERING_OS_MODE="repo" ;;
  *)
    echo "Invalid choice. Defaulting to Mode 1 (local only)."
    ENGINEERING_OS_MODE="local"
    ;;
esac

echo ""

# ─── Step 5: Personalisation prompts ─────────────────────────────────────────

echo "Tell me about yourself (used to personalize your vault files):"
echo ""

printf "Your full name: "
read -r YOUR_NAME

printf "Your current title/role: "
read -r YOUR_ROLE

printf "Your company name: "
read -r YOUR_COMPANY

printf "What should I call your AI assistant? [default: Alex]: "
read -r ASSISTANT_NAME
ASSISTANT_NAME="${ASSISTANT_NAME:-Alex}"

printf "Number of teams you lead: "
read -r NUMBER_OF_TEAMS

printf "Number of direct reports: "
read -r NUMBER_OF_DIRECT_REPORTS

printf "Total people across your teams: "
read -r TOTAL_PEOPLE

printf "Current top priorities (comma-separated, e.g. 'Platform reliability, Team growth'): "
read -r CURRENT_PRIORITIES

echo ""

# ─── Step 6: Copy vault template ─────────────────────────────────────────────

echo "Creating vault at: $VAULT_PATH"

if [ -d "$VAULT_PATH" ]; then
  echo ""
  echo "WARNING: Vault directory already exists at $VAULT_PATH"
  printf "Continue and copy template files into it? [y/N]: "
  read -r CONFIRM
  case "$CONFIRM" in
    y|Y) ;;
    *)
      echo "Aborted. No files were changed."
      exit 0
      ;;
  esac
fi

cp -r "$PLUGIN_DIR/vault-template/." "$VAULT_PATH/"
echo "  Vault files copied."

# ─── Step 7: Placeholder substitution ────────────────────────────────────────

echo "  Personalizing vault files..."

# Portable sed in-place (works on both macOS and Linux)
sedi() {
  if sed --version >/dev/null 2>&1; then
    # GNU sed (Linux)
    sed -i "$@"
  else
    # BSD sed (macOS) — requires empty string for backup extension
    sed -i '' "$@"
  fi
}

find "$VAULT_PATH" -name "*.md" | while read -r FILE; do
  sedi "s/\[YOUR_NAME\]/$YOUR_NAME/g" "$FILE"
  sedi "s/\[YOUR_ROLE\]/$YOUR_ROLE/g" "$FILE"
  sedi "s/\[YOUR_COMPANY\]/$YOUR_COMPANY/g" "$FILE"
  sedi "s/\[ASSISTANT_NAME\]/$ASSISTANT_NAME/g" "$FILE"
  sedi "s/\[NUMBER_OF_TEAMS\]/$NUMBER_OF_TEAMS/g" "$FILE"
  sedi "s/\[NUMBER_OF_DIRECT_REPORTS\]/$NUMBER_OF_DIRECT_REPORTS/g" "$FILE"
  sedi "s/\[TOTAL_PEOPLE\]/$TOTAL_PEOPLE/g" "$FILE"
  sedi "s/\[CURRENT_PRIORITIES\]/$CURRENT_PRIORITIES/g" "$FILE"
done

# Write mode marker into vault's CLAUDE.md
sedi "s|<!-- SETUP: mode=local -->|<!-- SETUP: mode=$ENGINEERING_OS_MODE -->|" \
  "$VAULT_PATH/CLAUDE.md"

echo "  Placeholders replaced."

# ─── Step 8: Write config file ───────────────────────────────────────────────

mkdir -p "$CONFIG_DIR"

cat > "$CONFIG_FILE" <<EOF
VAULT_PATH="$VAULT_PATH"
ENGINEERING_OS_MODE="$ENGINEERING_OS_MODE"
EOF

echo "  Config written: $CONFIG_FILE"

# ─── Step 9: Git setup (mode 2 only) ─────────────────────────────────────────

if [ "$ENGINEERING_OS_MODE" = "repo" ]; then
  echo ""
  echo "Setting up git repository..."

  cd "$VAULT_PATH"
  git init -q
  git add -A
  git commit -q -m "Initial Engineering OS vault setup"
  echo "  Git repository initialized."
  echo ""

  if command -v gh >/dev/null 2>&1; then
    printf "Create a private GitHub repository for your vault? [Y/n]: "
    read -r CREATE_REPO
    CREATE_REPO="${CREATE_REPO:-Y}"
    case "$CREATE_REPO" in
      y|Y)
        REPO_NAME="engineering-os-vault"
        gh repo create "$REPO_NAME" --private --source=. --remote=origin --push -q && \
          echo "  Private repo created and pushed: github.com/$(gh api user --jq .login)/$REPO_NAME" || \
          echo "  gh repo create failed — see manual instructions below."
        ;;
    esac
  else
    echo "  'gh' CLI not found. To set up remote backup manually:"
    echo ""
    echo "    1. Create a private repo on GitHub (e.g., engineering-os-vault)"
    echo "    2. Run:"
    echo "       cd \"$VAULT_PATH\""
    echo "       git remote add origin git@github.com:<your-username>/engineering-os-vault.git"
    echo "       git push -u origin main"
  fi
fi

# ─── Done ─────────────────────────────────────────────────────────────────────

echo ""
echo "Setup complete!"
echo ""
echo "  Vault:  $VAULT_PATH"
echo "  Mode:   $ENGINEERING_OS_MODE"
echo ""
echo "Start your first session:"
echo "  cd \"$VAULT_PATH\" && claude"
echo "  Then type: /morning"
echo ""
