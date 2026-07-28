#!/usr/bin/env bash

set -euo pipefail

REPO="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
BASH_FILES=(
  "$REPO/install.sh"
  "$REPO/bin/.local/bin/dotfiles"
  "$REPO/scripts/check.sh"
)

info() {
  printf '\033[1;34m::\033[0m %s\n' "$1"
}

die() {
  printf '\033[1;31merror:\033[0m %s\n' "$1" >&2
  exit 1
}

require() {
  command -v "$1" >/dev/null 2>&1 ||
    die "missing required command: $1"
}

info "checking required validation tools"
for command_name in actionlint bash git gitleaks shellcheck shfmt stow stylua zsh; do
  require "$command_name"
done

info "checking Bash syntax"
for file in "${BASH_FILES[@]}"; do
  bash -n "$file"
done

info "checking Zsh syntax"
while IFS= read -r -d '' file; do
  zsh -n "$file"
done < <(find "$REPO/zsh" -type f \( -name '*.zsh' -o -name '.zshrc' -o -name '.zprofile' \) -print0)

info "running ShellCheck"
shellcheck "${BASH_FILES[@]}"

info "checking shell formatting"
shfmt -d -i 2 -ci "${BASH_FILES[@]}"

info "checking Lua formatting"
stylua --check "$REPO/nvim/.config/nvim"

info "checking GitHub Actions"
actionlint "$REPO/.github/workflows/check.yml"

info "checking whitespace"
if git -C "$REPO" grep -nI -E '[[:blank:]]+$' -- .; then
  die "trailing whitespace found"
fi

info "scanning tracked files for secrets"
gitleaks dir "$REPO" --no-banner --redact

info "testing a clean Stow installation"
TEST_HOME="$(mktemp -d "${TMPDIR:-/tmp}/dotfiles-check.XXXXXX")"
trap 'rm -rf -- "$TEST_HOME"' EXIT

HOME="$TEST_HOME" \
  DOTFILES_SKIP_BREW=1 \
  DOTFILES_SKIP_NVIM=1 \
  "$REPO/install.sh" >/dev/null

MANAGED_TARGETS=(
  "$TEST_HOME/.local/bin/dotfiles"
  "$TEST_HOME/.zshrc"
  "$TEST_HOME/.gitconfig"
  "$TEST_HOME/.config/ghostty"
  "$TEST_HOME/.config/mise"
  "$TEST_HOME/.config/nvim"
  "$TEST_HOME/.config/starship.toml"
)
MANAGED_SOURCES=(
  "$REPO/bin/.local/bin/dotfiles"
  "$REPO/zsh/.zshrc"
  "$REPO/git/.gitconfig"
  "$REPO/ghostty/.config/ghostty"
  "$REPO/mise/.config/mise"
  "$REPO/nvim/.config/nvim"
  "$REPO/starship/.config/starship.toml"
)

for index in "${!MANAGED_TARGETS[@]}"; do
  target="${MANAGED_TARGETS[$index]}"
  source="${MANAGED_SOURCES[$index]}"
  [[ -e "$target" && "$target" -ef "$source" ]] ||
    die "installer did not manage: $target"
done

info "all checks passed"
