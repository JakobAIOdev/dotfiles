# Neovim configuration

This is a small, keyboard-first Neovim setup for daily work with Go,
TypeScript/JavaScript, Lua, Ruby, Python, PHP, Kotlin, C#, SQL, Docker, YAML,
JSON, Markdown, and web projects.

The configuration uses lazy.nvim for plugin management and keeps the visual
language aligned with Ghostty, Starship, and Catppuccin Mocha.

## Understand the navigation model

The labels at the very top of the macOS window belong to Ghostty. The labels
inside Neovim belong to Neovim's bufferline.

```text
Ghostty tab
└── Neovim process
    ├── buffer: an open file
    ├── window: a view that displays one buffer
    └── split: multiple windows visible at the same time
```

This setup primarily uses buffers and windows. Native Neovim tab pages are not
part of the normal workflow.

### Switch open files

| Key | Action |
|---|---|
| `Shift-H` | Previous buffer |
| `Shift-L` | Next buffer |
| `[b` / `]b` | Previous or next buffer |
| `Space ,` | Select from all open buffers |
| `Space bd` | Close the current buffer while keeping the split |
| `Space bo` | Close every other buffer |

The filenames shown in Neovim's top bar are buffers, even though they look like
tabs.

### Move between visible windows

| Key | Action |
|---|---|
| `Ctrl-H` | Focus the window on the left |
| `Ctrl-J` | Focus the window below |
| `Ctrl-K` | Focus the window above |
| `Ctrl-L` | Focus the window on the right |
| `Space -` | Create a horizontal split |
| `Space \|` | Create a vertical split |
| `Space wd` | Close the current window |
| `Space we` | Make all windows equal in size |

With the explorer on the left, the most common movement is:

```text
file window  -- Ctrl-H -->  explorer
explorer     -- Ctrl-L -->  file window
```

`Space e` opens or focuses the explorer from anywhere. The directional
`Ctrl-H/J/K/L` mappings continue to work when more file splits are open.

### Ghostty tabs are separate

| Key | Action |
|---|---|
| `Cmd-1`, `Cmd-2`, ... | Select a Ghostty tab by number |
| `Cmd-T` | Create a Ghostty tab |
| `Cmd-W` | Close the active Ghostty surface |
| `Cmd-D` | Create a Ghostty split on the right |
| `Cmd-Shift-D` | Create a Ghostty split below |

Ghostty shortcuts manage terminal surfaces. They do not switch Neovim files.

## Daily workflow

| Key | Action |
|---|---|
| `Space Space` | Smart file and recent-file search |
| `Space e` | Toggle the file explorer |
| `Space /` | Search text in the project |
| `Space ff` | Find files |
| `Space fg` | Search project text |
| `Space ww` | Save the current file |
| `Space wa` | Save every modified file |
| `Space ot` | Toggle the floating terminal |
| `Space gg` | Open Lazygit |
| `Space z` | Toggle Zen mode |
| `Space qq` | Quit Neovim |

Press `Space` and wait briefly to discover available mappings through
which-key.

## File explorer

| Key | Action |
|---|---|
| `Space e` | Open or focus the explorer |
| `Ctrl-H` | Focus the explorer from the file window |
| `Ctrl-L` | Return from the explorer to the file window |
| `Enter` / `l` | Open a file or directory |
| `h` | Collapse a directory |
| `Backspace` | Move to the parent directory |
| `a` | Add a file or directory |
| `r` | Rename |
| `d` | Move to the system Trash |
| `H` | Toggle hidden files |
| `I` | Toggle Git-ignored files |
| `P` | Toggle the preview |

Git-ignored and hidden files are visible by default.

## Code intelligence

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gr` | Show references |
| `gI` | Go to implementation |
| `K` | Show hover documentation |
| `Space ca` | Code action |
| `Space cr` | Rename symbol |
| `Space cf` | Format |
| `gl` | Show the diagnostic under the cursor |
| `[d` / `]d` | Previous or next diagnostic |

Language servers, formatters, debuggers, and Tree-sitter parsers are installed
through Mason and the plugin configuration.

## Tests and debugging

| Key | Action |
|---|---|
| `Space tt` | Run the nearest test |
| `Space tf` | Run the current test file |
| `Space ta` | Run all tests |
| `Space tl` | Repeat the last test |
| `Space to` | Open test output |
| `Space ts` | Open the test summary |
| `Space td` | Debug the nearest test |
| `F5` | Start or continue debugging |
| `F10` / `F11` / `F12` | Step over, into, or out |
| `Space db` | Toggle a breakpoint |
| `Space du` | Toggle the debug UI |
| `Space dt` | Stop debugging |

Go tests and local Vitest projects are supported through Neotest.

## Health and maintenance

```vim
:Lazy
:Mason
:checkhealth
:ConformInfo
```

Run the repository-wide validation from the shell:

```bash
dotfiles check
dotfiles doctor
```

The compact key reference remains available in
[`CHEATSHEET.md`](CHEATSHEET.md).
