# Emacs-style editing with useful history and word navigation.

bindkey -e

autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[OA' up-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search
bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search

bindkey '^[b' backward-word
bindkey '^[f' forward-word
bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word
bindkey '^[[3~' delete-char
bindkey '^[[Z' reverse-menu-complete

# Ctrl-Z toggles the current process instead of only suspending it.
fancy-ctrl-z() {
  if [[ -n "$BUFFER" ]]; then
    zle push-input
  else
    fg
    zle redisplay
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
