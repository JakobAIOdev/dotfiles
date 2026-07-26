# Keep this file last: syntax highlighting wraps the final ZLE widgets.

typeset syntax_highlighting_script="${HOMEBREW_PREFIX:-/opt/homebrew}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

if [[ -r "$syntax_highlighting_script" ]]; then
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
  typeset -A ZSH_HIGHLIGHT_STYLES
  ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f38ba8'
  ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#cba6f7'
  ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#89b4fa'
  ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#89b4fa'
  ZSH_HIGHLIGHT_STYLES[precommand]='fg=#f9e2af'
  ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#6c7086'
  ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#a6e3a1,underline'
  ZSH_HIGHLIGHT_STYLES[path]='fg=#a6e3a1,underline'
  ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#6c7086'
  ZSH_HIGHLIGHT_STYLES[globbing]='fg=#f5c2e7'
  ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#fab387'
  ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#89dceb'
  ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#89dceb'
  ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#a6e3a1'
  ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#a6e3a1'
  ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#a6e3a1'
  ZSH_HIGHLIGHT_STYLES[redirection]='fg=#f5c2e7'
  ZSH_HIGHLIGHT_STYLES[comment]='fg=#6c7086,italic'
  source "$syntax_highlighting_script"
fi
unset syntax_highlighting_script
