# Jakob's Zsh Cheatsheet

> Deine wichtigsten Shell-Shortcuts auf einen Blick.

## Suche & Navigation

| Shortcut / Command | Funktion |
|---|---|
| `Ctrl-R` | Command-History mit fuzzy Search durchsuchen |
| `Ctrl-T` | Datei suchen und in den aktuellen Command einsetzen |
| `Option-C` | Verzeichnis suchen und direkt hineinspringen |
| `z <name>` | Zu einem häufig verwendeten Verzeichnis springen |
| `zi` | Bekannte Verzeichnisse interaktiv auswählen |
| `..` | Ein Verzeichnis nach oben |
| `...` | Zwei Verzeichnisse nach oben |
| `....` | Drei Verzeichnisse nach oben |
| `croot` | Zum Root des aktuellen Git-Repositories springen |
| `mkcd <ordner>` | Verzeichnis erstellen und direkt öffnen |
| `take <ordner>` | Kurzform von `mkcd` |

### Beispiele

```zsh
z portfolio
zi
croot
take neuer-service
```

## Dateien & Ordner

| Command | Funktion |
|---|---|
| `ls` | Cleane Dateiübersicht mit Icons |
| `l` / `ll` | Ausführliche Ansicht inklusive versteckter Dateien und Git-Status |
| `la` | Alle Dateien kompakt anzeigen |
| `lt` | Verzeichnisbaum bis Tiefe 2 |
| `b <datei>` | Datei mit Syntax-Highlighting anzeigen |
| `fe` | Datei fuzzy suchen und in Neovim öffnen |
| `fif [text]` | Projektinhalt durchsuchen, Vorschau anzeigen und Treffer öffnen |

### Beispiele

```zsh
ll
lt
b package.json
fe
fif "TODO"
```

## Neovim

| Command | Funktion |
|---|---|
| `v <datei>` | Datei in Neovim öffnen |
| `vi <datei>` | Ebenfalls Neovim |
| `vim <datei>` | Ebenfalls Neovim |
| `vimdiff <a> <b>` | Zwei Dateien vergleichen |
| `nvconfig` | Neovim-Konfiguration öffnen |

```zsh
v app.rb
vimdiff alt.lua neu.lua
nvconfig
```

## Git

| Command | Ausgeschriebener Command |
|---|---|
| `g` | `git` |
| `gs` | `git status --short --branch` |
| `ga <datei>` | `git add <datei>` |
| `gaa` | `git add --all` |
| `gc` | `git commit` |
| `gcm "message"` | `git commit -m "message"` |
| `gp` | `git push` |
| `gpl` | `git pull --rebase` |
| `gd` | `git diff` |
| `gds` | `git diff --staged` |
| `gl` | Kompakter Git-Graph der letzten 20 Commits |
| `gb` | Branches anzeigen |
| `gco <branch>` | Branch auschecken |
| `gsw <branch>` | Branch wechseln |
| `gr <datei>` | Änderungen einer Datei wiederherstellen |
| `lg` | Lazygit öffnen |

### Typischer Workflow

```zsh
gs
gd
ga src/app.ts
gcm "feat: add dashboard"
gp
```

> `gd`, `gds` und andere Git-Ausgaben verwenden automatisch Delta für ein
> lesbareres Diff.

## AI-Helfer

| Command | Funktion |
|---|---|
| `ask "frage"` | Gemini CLI im Auto-Modus fragen |
| `explain` | Terminal-Output verständlich erklären lassen |
| `fix` | Fehler analysieren und konkrete Lösung erhalten |
| `wtf` | Kurz erklären lassen, was kaputt ist |

Beispiel mit Pipe:

```zsh
npm run build 2>&1 | fix
```

## Shell bedienen

| Shortcut / Command | Funktion |
|---|---|
| `↑` / `↓` | History passend zum bereits eingegebenen Prefix durchsuchen |
| `Option-←` / `Option-→` | Wortweise springen |
| `Option-Backspace` | Vorheriges Wort oder Pfadsegment löschen |
| `Tab` | Completion öffnen |
| `Shift-Tab` | Rückwärts durch Completion navigieren |
| `Ctrl-Z` | Aktuellen Prozess pausieren beziehungsweise zurückholen |
| `Ctrl-C` | Aktuellen Command abbrechen |
| `Ctrl-L` | Terminal leeren |
| `c` / `cls` | Terminal leeren |
| `reload` | Zsh komplett neu starten |

## Config

| Command / Datei | Funktion |
|---|---|
| `zshconfig` | `~/.zshrc` bearbeiten |
| `exec zsh -l` | Login-Shell neu starten |
| `~/.config/zsh/` | Modulare Zsh-Konfiguration |
| `~/.config/starship.toml` | Prompt-Design |
| `~/.zshrc.backup-20260726` | Backup der vorherigen Config |

## Prompt lesen

```text
projekt   branch !2 ?1           v24  󱎫 2s  20:14
❯
```

- ` branch`: aktueller Git-Branch
- `!2`: zwei geänderte Dateien
- `?1`: eine ungetrackte Datei
- `+3`: drei Dateien im Staging
- `⇡2` / `⇣1`: Commits vor beziehungsweise hinter Remote
- Runtime-Symbole erscheinen nur in passenden Projekten
- `󱎫 2s`: Laufzeit des letzten längeren Commands
- Grünes `❯`: letzter Command war erfolgreich
- Rotes `❯`: letzter Command ist fehlgeschlagen

## Die fünf wichtigsten Commands

```zsh
Ctrl-R          # alten Command finden
z <name>        # zu einem Projekt springen
fe              # Datei suchen und bearbeiten
fif <text>      # Inhalt im Projekt suchen
lg              # Git visuell bedienen
```
