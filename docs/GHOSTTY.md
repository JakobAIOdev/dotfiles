# Ghostty: layer 1

Ghostty is the application that draws the terminal window. It does not replace
Zsh, Neovim, Git, or Mise. Opening Ghostty starts Zsh inside a new terminal
surface.

```text
Ghostty window
└── Zsh shell
    ├── normal commands
    └── Neovim
```

## What the tracked configuration changes

The live configuration is `~/.config/ghostty/config.ghostty`, linked from this
repository with GNU Stow.

| Setting | Purpose |
|---|---|
| `theme` | Uses the same Catppuccin Mocha colors as Neovim and Starship |
| `font-family` | Uses 0xProto Nerd Font Mono for text and icons |
| `font-size` | Sets the initial text size |
| `window-padding-*` | Adds a small breathing space around terminal content |
| `window-save-state` | Restores the last window size and position |
| `cursor-style*` | Uses a visible, non-blinking block cursor |
| `mouse-hide-while-typing` | Hides the pointer while keyboard input is active |

## First commands

Run these after opening Ghostty:

```bash
echo "$SHELL"    # shows the shell running inside Ghostty
pwd              # shows the current directory
dotfiles doctor  # checks the managed setup
nvim             # opens the editor inside Ghostty
```

## Default macOS shortcuts

These are Ghostty defaults, not custom mappings:

| Shortcut | Action |
|---|---|
| `Cmd+T` | New tab |
| `Cmd+D` | New split on the right |
| `Cmd+Shift+D` | New split below |
| `Cmd+Option+Arrow` | Focus a neighboring split |
| `Cmd+Shift+Enter` | Zoom or restore the current split |
| `Cmd+W` | Close the current surface |
| `Cmd++` / `Cmd+-` | Increase or decrease font size |
| `Cmd+0` | Reset font size |
| `Cmd+F` | Search terminal output |
| `Cmd+,` | Open the configuration |
| `Cmd+Shift+,` | Reload the configuration |

## Ten-minute exercise

1. Open Ghostty and run `pwd`.
2. Press `Cmd+D` and run `eza` in the new split.
3. Move between splits with `Cmd+Option+Left/Right`.
4. Zoom one split with `Cmd+Shift+Enter`, then restore it.
5. Start `nvim` in one split and `lazygit` in the other.
6. Change `font-size` by one point, save, and reload with `Cmd+Shift+,`.

After this exercise, the difference between a terminal, shell, split, and
terminal application should be visible rather than theoretical.

## Useful discovery commands

The app bundle contains the CLI even though macOS does not add it to `PATH`:

```bash
/Applications/Ghostty.app/Contents/MacOS/ghostty +version
/Applications/Ghostty.app/Contents/MacOS/ghostty +list-themes
/Applications/Ghostty.app/Contents/MacOS/ghostty +list-keybinds --default
```

Official documentation: <https://ghostty.org/docs>
