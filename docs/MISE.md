# Mise: layer 2

Mise selects development tools and environment variables for the current
directory. It can also give common project commands memorable names.

It is not a container and it does not start services automatically.

```text
cd into a project
└── Mise reads mise.toml
    ├── selects the requested tool versions
    ├── applies declared environment variables
    └── makes project tasks available
```

Tasks run only when explicitly requested with `mise run <task>`.

## The three configuration levels

| File | Purpose |
|---|---|
| `~/.config/mise/config.toml` | Personal defaults available in every shell |
| `<project>/mise.toml` | Shared project tools, environment, and tasks |
| `<project>/mise.local.toml` | Optional machine-local values; never commit secrets |

The global file in these dotfiles currently selects Ruby 3.4.6. A project file
can override that version or add Node, Go, Python, and other tools.

## Core commands

```bash
mise current       # versions active in the current directory
mise ls            # versions already installed by Mise
mise install       # install versions requested by mise.toml
mise tasks         # show the project's named tasks
mise run info      # execute one task
mise exec -- node --version
mise doctor        # diagnose the Mise installation
```

`mise exec -- ...` is useful when you want to explicitly run one command inside
the resolved Mise environment.

## Trust

Project configuration can contain executable tasks and hooks. Mise therefore
requires an explicit trust decision the first time it sees a new config:

```bash
mise trust
```

Read an unfamiliar `mise.toml` before trusting it.

## Playground

The safe example lives in `~/dotfiles/examples/mise-playground`.

```bash
cd ~/dotfiles/examples/mise-playground
mise trust
mise install
mise current
mise tasks
mise run info
mise run hello
```

Notice the boundaries:

1. `cd` selects the project configuration.
2. `mise install` downloads a missing tool version.
3. `mise current` only reports state.
4. `mise run hello` explicitly executes a task.
5. Leaving the directory restores the previous environment.

## Applying this to a real project

A real project should initially define only:

1. versions already required by its source files or containers;
2. harmless non-secret development environment values;
3. commands already documented in `package.json`, a Makefile, or Compose.

This keeps Mise as a thin, understandable interface over the project instead of
creating a second build system.

Official documentation:

- <https://mise.jdx.dev/environments/>
- <https://mise.jdx.dev/tasks/>
