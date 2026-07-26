# Tool integrations. Every block is optional and fails closed.

if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
fi

if [[ -n "${PHPVM_DIR:-}" && -r "$PHPVM_DIR/phpvm.sh" ]]; then
  source "$PHPVM_DIR/phpvm.sh"
fi

if (( $+commands[bat] )); then
  export BAT_THEME='Catppuccin Mocha'
fi

if (( $+commands[delta] )); then
  export GIT_PAGER='delta --dark --line-numbers --navigate'
fi

if (( $+commands[fzf] )); then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  export FZF_DEFAULT_OPTS='
    --height=45%
    --layout=reverse
    --border=rounded
    --info=inline-right
    --prompt=❯
    --pointer=◆
    --marker=✓
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
    --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
    --color=selected-bg:#45475a,border:#6c7086,label:#cdd6f4'
  export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:300 {} 2>/dev/null'"
  export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --icons=auto --color=always {} 2>/dev/null'"
  source <(fzf --zsh)
fi

if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi

typeset autosuggestions_script="${HOMEBREW_PREFIX:-/opt/homebrew}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
if [[ ! -r "$autosuggestions_script" ]]; then
  autosuggestions_script="$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

if [[ -r "$autosuggestions_script" ]]; then
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#6c7086'
  source "$autosuggestions_script"
fi
unset autosuggestions_script
