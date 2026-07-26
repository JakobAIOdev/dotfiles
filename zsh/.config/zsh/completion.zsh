# Fast native completion with a cached compdump.

autoload -Uz compinit
zmodload zsh/complist

typeset -g ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-${ZSH_VERSION}"
[[ -d "${ZSH_COMPDUMP:h}" ]] || command mkdir -p -- "${ZSH_COMPDUMP:h}"

if [[ ! -f "$ZSH_COMPDUMP" || -n "$ZSH_COMPDUMP"(#qN.mh+24) ]]; then
  compinit -d "$ZSH_COMPDUMP"
else
  compinit -C -d "$ZSH_COMPDUMP"
fi

zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/completion"
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{8}  %d%f'
zstyle ':completion:*:warnings' format '%F{1}  no matches%f'
zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*'

if [[ -n "${LS_COLORS:-}" ]]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# Don't offer internal dotfiles unless the typed prefix starts with a dot.
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true

unset ZSH_COMPDUMP
