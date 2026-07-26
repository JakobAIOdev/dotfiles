# Login-shell environment.

for brew_binary in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  if [[ -x "$brew_binary" ]]; then
    eval "$("$brew_binary" shellenv)"
    break
  fi
done
unset brew_binary

# Zsh keeps tied PATH/path arrays unique with `typeset -U`.
typeset -U path PATH
homebrew_prefix="${HOMEBREW_PREFIX:-/opt/homebrew}"
path=(
  "$HOME/.local/bin"
  "$HOME/.antigravity/antigravity/bin"
  "$HOME/.phpvm/bin"
  "$homebrew_prefix/opt/postgresql@17/bin"
  "$homebrew_prefix/opt/python@3/libexec/bin"
  "/Library/Frameworks/Python.framework/Versions/3.12/bin"
  "$HOME/go/bin"
  "$HOME/.dotnet/tools"
  "$HOME/.spicetify"
  $path
)
export PATH
unset homebrew_prefix

export LANG="en_US.UTF-8"
export EDITOR="nvim"
export VISUAL="nvim"
export PGUSER="jakob"
export PGDATABASE="postgres"
