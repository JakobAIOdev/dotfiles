# Jakob's interactive Zsh setup.
# The actual configuration lives in ~/.config/zsh to keep this file boring.

export ZSH_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

for config_file in \
  options \
  completion \
  keybindings \
  aliases \
  integrations \
  prompt
do
  [[ -r "$ZSH_CONFIG_DIR/$config_file.zsh" ]] &&
    source "$ZSH_CONFIG_DIR/$config_file.zsh"
done
unset config_file

# Machine-local values and secrets never belong in the shared config.
[[ -r "$ZSH_CONFIG_DIR/private.zsh" ]] &&
  source "$ZSH_CONFIG_DIR/private.zsh"

# Syntax highlighting must be loaded after every other integration.
[[ -r "$ZSH_CONFIG_DIR/plugins.zsh" ]] &&
  source "$ZSH_CONFIG_DIR/plugins.zsh"
