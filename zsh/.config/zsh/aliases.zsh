# Small aliases that remain predictable.

alias reload='exec zsh -l'
alias cls='clear'
alias c='clear'

alias vi='nvim'
alias vim='nvim'
alias vimdiff='nvim -d'
alias v='nvim'
alias python='python3'
alias pip='pip3'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

if (( $+commands[eza] )); then
  alias ls='eza --icons=auto --group-directories-first'
  alias l='eza -lah --icons=auto --group-directories-first --git'
  alias ll='eza -lah --icons=auto --group-directories-first --git'
  alias la='eza -a --icons=auto --group-directories-first'
  alias lt='eza --tree --level=2 --icons=auto --group-directories-first'
else
  alias l='ls -lah'
  alias ll='ls -lah'
  alias la='ls -A'
fi

alias b='bat'
alias lg='lazygit'

alias g='git'
alias gs='git status --short --branch'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull --rebase'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline --decorate --graph -20'
alias gb='git branch'
alias gco='git checkout'
alias gsw='git switch'
alias gr='git restore'

alias zshconfig='$EDITOR ~/.zshrc'
alias nvconfig='cd ~/.config/nvim && nvim .'
alias ligma='limactl'

# Existing Gemini CLI helpers, preserved from the previous setup.
alias explain='gmn --no-agent -m flash -p "Erkläre diesen Terminal-Output verständlich für einen Entwickler:"'
alias fix='gmn --no-agent -m flash -p "Erkläre diesen Fehler und gib eine konkrete Lösung:"'
alias wtf='gmn --no-agent -m flash -p "Was ist hier falsch und wie behebe ich das?"'
alias ask='gmn --no-agent -m auto'

mkcd() {
  [[ -n "$1" ]] || {
    print -u2 'usage: mkcd <directory>'
    return 2
  }
  command mkdir -p -- "$1" && builtin cd -- "$1"
}
alias take='mkcd'

croot() {
  local root
  root="$(git rev-parse --show-toplevel 2>/dev/null)" || {
    print -u2 'not inside a Git repository'
    return 1
  }
  builtin cd -- "$root"
}

fe() {
  local file
  file="$(
    fd --type f --hidden --follow --exclude .git 2>/dev/null |
      fzf --preview 'bat --color=always --style=numbers --line-range=:300 {} 2>/dev/null'
  )" || return
  [[ -n "$file" ]] && "$EDITOR" "$file"
}

fif() {
  local query="${1:-}"
  rg --column --line-number --no-heading --color=always --smart-case -- "$query" |
    fzf --ansi \
      --delimiter : \
      --preview 'bat --color=always --highlight-line {2} --line-range {2}: {1}' \
      --bind 'enter:become(nvim {1} +{2})'
}
