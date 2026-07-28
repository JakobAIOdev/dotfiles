#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_ROOT="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles/backups/$(date +%Y%m%d-%H%M%S)"
PACKAGES=(bin ghostty git mise nvim starship zsh)

info() {
  printf '\033[1;34m::\033[0m %s\n' "$1"
}

die() {
  printf '\033[1;31merror:\033[0m %s\n' "$1" >&2
  exit 1
}

backup_file() {
  local relative="$1"
  local source="$HOME/$relative"
  local destination="$BACKUP_ROOT/$relative"

  if [[ -L "$source" ]]; then
    return
  fi

  if [[ -e "$source" ]]; then
    mkdir -p -- "$(dirname -- "$destination")"
    mv -- "$source" "$destination"
    info "backed up ~/$relative"
  fi
}

command -v brew >/dev/null 2>&1 ||
  die "Homebrew is required: https://brew.sh"

if [[ "${DOTFILES_SKIP_BREW:-0}" != "1" ]]; then
  info "installing Homebrew dependencies"
  brew bundle --file="$DOTFILES_DIR/Brewfile"
fi

command -v stow >/dev/null 2>&1 ||
  die "GNU Stow is required: brew install stow"

# Direct file conflicts. The private Zsh file is intentionally untouched.
backup_file ".zshrc"
backup_file ".zprofile"
backup_file ".gitconfig"
backup_file ".local/bin/dotfiles"
backup_file ".config/ghostty"
backup_file ".config/mise"
backup_file ".config/starship.toml"
backup_file ".config/nvim"

while IFS= read -r file; do
  relative="${file#"$DOTFILES_DIR/zsh/"}"
  [[ "$relative" == ".zshrc" || "$relative" == ".zprofile" ]] && continue
  backup_file "$relative"
done < <(find "$DOTFILES_DIR/zsh" -type f -print)

mkdir -p -- "$HOME/.config/zsh"

info "linking dotfiles"
stow --dir="$DOTFILES_DIR" --target="$HOME" --restow "${PACKAGES[@]}"

if [[ "${DOTFILES_SKIP_NVIM:-0}" != "1" ]] && command -v nvim >/dev/null 2>&1; then
  info "syncing Neovim plugins"
  nvim --headless "+Lazy! sync" +qa
fi

if [[ -d "$BACKUP_ROOT" ]]; then
  info "backup saved to $BACKUP_ROOT"
fi

info "done"
info "restart the shell with: exec zsh -l"
info "then verify the setup with: dotfiles doctor"

if [[ ! -e "$HOME/.gitconfig.local" ]]; then
  info "Git identity is not configured yet"
  info "copy and edit: $DOTFILES_DIR/examples/gitconfig.local.example -> ~/.gitconfig.local"
fi
