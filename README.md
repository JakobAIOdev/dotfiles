# `~` Jakob's dotfiles

A small, fast, and reproducible macOS development setup built around
**Ghostty**, **Neovim**, **Zsh**, **Starship**, and **Catppuccin Mocha**.

The repository uses [GNU Stow](https://www.gnu.org/software/stow/) to create
transparent symlinks into `$HOME`. Editing the live configuration therefore
edits the tracked repository files directly.

## Stack

| Area | Tools |
|---|---|
| Terminal | Ghostty |
| Editor | Neovim 0.12, lazy.nvim, Tree-sitter, Mason, Snacks |
| Shell | Zsh, Starship, fzf, zoxide |
| Runtime management | Mise |
| CLI | eza, bat, delta, lazygit, ripgrep, fd |
| Theme | Catppuccin Mocha |
| Management | GNU Stow, Homebrew Bundle |
| Validation | ShellCheck, shfmt, Gitleaks, GitHub Actions |

## Requirements

- macOS
- [Homebrew](https://brew.sh)
- Command Line Tools for Xcode (`xcode-select --install`)

## Install

```bash
git clone https://github.com/JakobAIOdev/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The installer:

1. installs the declared Homebrew tools;
2. backs up conflicting files without overwriting them;
3. links the configuration with GNU Stow;
4. installs and updates Neovim plugins.

Skip optional steps when needed:

```bash
DOTFILES_SKIP_BREW=1 ./install.sh
DOTFILES_SKIP_NVIM=1 ./install.sh
```

The installer never overwrites an unmanaged configuration. Conflicting files
are moved to a timestamped directory below
`~/.local/state/dotfiles/backups/`.

After the first installation, create the intentionally untracked,
machine-specific files:

```bash
cp ~/dotfiles/examples/gitconfig.local.example ~/.gitconfig.local
cp ~/dotfiles/examples/private.zsh.example ~/.config/zsh/private.zsh
```

Edit both copies before using them. Never commit credentials or access tokens.

## Packages

```text
dotfiles/
├── bin/        # dotfiles helper command
├── ghostty/    # ~/.config/ghostty
├── git/        # portable Git preferences
├── mise/       # ~/.config/mise
├── nvim/       # ~/.config/nvim
├── scripts/    # repository checks
├── starship/   # ~/.config/starship.toml
└── zsh/        # ~/.zshrc, ~/.zprofile, ~/.config/zsh
```

Each top-level directory is an independent Stow package.

## Daily workflow

```bash
dotfiles status    # show repository changes
dotfiles sync      # recreate all symlinks
dotfiles update    # pull, install tools, sync, update Neovim
dotfiles doctor    # verify commands and symlinks
dotfiles check     # run syntax, formatting, secret, and install checks
```

Because the active files are symlinks, normal edits appear immediately:

```bash
nvconfig
git -C ~/dotfiles status
git -C ~/dotfiles add nvim
git -C ~/dotfiles commit -m "tune neovim"
git -C ~/dotfiles push
```

Run `dotfiles check` before committing. The same check runs in GitHub Actions.

## Guides and cheatsheets

- [Neovim guide](nvim/.config/nvim/README.md)
- [Neovim cheatsheet](nvim/.config/nvim/CHEATSHEET.md)
- [Zsh cheatsheet](zsh/.config/zsh/CHEATSHEET.md)
- [Ghostty learning guide](docs/GHOSTTY.md)
- [Mise learning guide](docs/MISE.md)

## Secrets

Secrets, histories, logs, caches, and backups are intentionally excluded.

Machine-local shell values belong in:

```text
~/.config/zsh/private.zsh
```

Use [`examples/private.zsh.example`](examples/private.zsh.example) as a
starting point. Git identity belongs in `~/.gitconfig.local`, which is included
by the tracked Git configuration but never committed.

Before every push, scan the repository with:

```bash
gitleaks dir ~/dotfiles --redact
```

`dotfiles check` includes this scan.

## Manual Stow usage

```bash
cd ~/dotfiles
stow --target="$HOME" --restow bin ghostty git mise nvim starship zsh
```

Remove only the symlinks:

```bash
cd ~/dotfiles
stow --target="$HOME" --delete bin ghostty git mise nvim starship zsh
```

## License

[MIT](LICENSE)
