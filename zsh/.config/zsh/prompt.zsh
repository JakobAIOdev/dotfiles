# Starship handles Git state asynchronously and keeps the prompt responsive.

if (( $+commands[starship] )); then
  export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship.toml"
  eval "$(starship init zsh)"
else
  PROMPT='%F{blue}%~%f %F{green}❯%f '
fi
