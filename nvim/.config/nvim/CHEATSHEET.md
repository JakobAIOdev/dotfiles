# Jakob's Neovim Cheatsheet

`Leader` ist `Space`. Die wichtigsten Mappings erscheinen automatisch über
which-key, sobald du `Space` drückst.

## Daily flow

| Key | Aktion |
| --- | --- |
| `Space Space` | Smarte Datei-/Recent-Suche |
| `Space e` | File Explorer |
| `Space /` | Text im Projekt suchen |
| `Space ,` | Offene Buffer |
| `Space ww` | Datei speichern |
| `Space wa` | Alle Dateien speichern |
| `Space o t` | Floating Terminal |
| `Ctrl+\` | Floating Terminal (alternative binding) |
| `Space z` | Zen Mode |
| `Space qq` | Neovim schließen |

## Finden

| Key | Aktion |
| --- | --- |
| `Space ff` | Dateien |
| `Space fg` | Text im Projekt |
| `Space fb` | Buffer |
| `Space fr` | Zuletzt geöffnete Dateien |
| `Space fc` | Neovim-Config durchsuchen |
| `Space fw` | Wort oder visuelle Auswahl suchen |
| `Space fh` | Help Pages |
| `Space fk` | Keymaps |
| `Space ft` | TODO/FIXME Kommentare |
| `Space fu` | Undo History |
| `Space fR` | Registers |
| `Space fd` | Diagnostics |

Im Picker funktionieren `Ctrl+j/k`, `Tab`, `Enter`, `Esc` und `?` für Hilfe.

## Explorer

| Key | Aktion |
| --- | --- |
| `Space e` | Explorer öffnen |
| `Ctrl+h` | Vom Code in den Explorer wechseln |
| `Ctrl+l` | Vom Explorer zurück zum Code wechseln |
| `Enter` / `l` | Datei öffnen / Ordner aufklappen |
| `h` | Ordner zuklappen |
| `Backspace` | Einen Ordner nach oben |
| `a` | Datei oder Ordner anlegen (`/` am Ende = Ordner) |
| `r` | Umbenennen |
| `d` | Löschen (System-Papierkorb) |
| `H` | Versteckte Dateien ein/aus |
| `I` | Git-ignorierte Dateien ein/aus |
| `P` | Preview ein/aus |

## LSP und Code

| Key | Aktion |
| --- | --- |
| `gd` | Definitionen |
| `gD` | Deklaration |
| `gr` | Referenzen |
| `gI` | Implementierungen |
| `gy` | Typ-Definitionen |
| `K` | Hover-Dokumentation |
| `gK` | Signature Help |
| `Space ca` | Code Action |
| `Space cr` | Rename |
| `Space cf` | Formatieren |
| `Space uh` | Inlay Hints ein/aus |
| `gl` | Diagnostic unter Cursor |
| `[d` / `]d` | Vorheriges/nächstes Diagnostic |
| `[e` / `]e` | Vorheriger/nächster Error |
| `Space xx` | Workspace Diagnostics |
| `Space xX` | Buffer Diagnostics |
| `Space xs` | Document Symbols |

Completion läuft über Blink:

| Key | Aktion |
| --- | --- |
| `Tab` / `Shift+Tab` | Nächster/vorheriger Vorschlag |
| `Enter` | Vorschlag bestätigen |
| `Ctrl+Space` | Completion oder Dokumentation öffnen |
| `Ctrl+e` | Completion schließen |
| `Ctrl+k` | Signature Help |

Installierte Sprachunterstützung: Lua, Go, TypeScript/JavaScript, ESLint,
HTML/CSS/Emmet/Tailwind, JSON/YAML, Bash, Python/Pyright/Ruff, PHP, Ruby,
Kotlin, C#, SQL, Dockerfile und Markdown.

## Git

| Key | Aktion |
| --- | --- |
| `]h` / `[h` | Nächster/vorheriger Hunk |
| `Space ghs` | Hunk stagen |
| `Space ghr` | Hunk resetten |
| `Space ghp` | Hunk Preview |
| `Space ghb` | Volles Line Blame |
| `Space ghd` | Diff gegen Index |
| `Space gtb` | Inline Blame ein/aus |
| `Space gs` | Git Status Picker |
| `Space gc` | Git Log Picker |
| `Space go` | Auswahl auf GitHub/GitLab öffnen |
| `Space gb` | Kurzes Line Blame |

`Space gg` öffnet Lazygit, falls `lazygit` auf dem System installiert ist.

## Buffer, Fenster und Harpoon

| Key | Aktion |
| --- | --- |
| `Shift+h/l` oder `[b` / `]b` | Buffer wechseln |
| `Space bd` | Buffer schließen, Split behalten |
| `Space bo` | Andere Buffer schließen |
| `Space bp` | Buffer pinnen |
| `Ctrl+h/j/k/l` | Fenster wechseln |
| `Space -` / `Space \|` | Horizontaler/vertikaler Split |
| `Space wd` | Fenster schließen |
| `Space we` | Fenster gleich groß |
| `Space ha` | Datei zu Harpoon |
| `Space hh` | Harpoon-Menü |
| `Space 1..4` | Harpoon-Datei 1 bis 4 |

## Tests und Debugging

Go-Tests und JavaScript-/TypeScript-Tests mit lokalem Vitest laufen über Neotest:

| Key | Aktion |
| --- | --- |
| `Space tt` | Nächster Test |
| `Space tf` | Aktuelle Testdatei |
| `Space ta` | Alle Tests |
| `Space tl` | Letzten Test wiederholen |
| `Space to` | Test-Output |
| `Space ts` | Test-Summary |
| `Space td` | Test debuggen |

| Key | Aktion |
| --- | --- |
| `F5` | Debug starten/fortsetzen |
| `F10` / `F11` / `F12` | Step over/into/out |
| `Space db` | Breakpoint |
| `Space dB` | Conditional Breakpoint |
| `Space du` | Debug UI |
| `Space de` | Ausdruck auswerten |
| `Space dt` | Debugging beenden |

## Editing und Navigation

| Key | Aktion |
| --- | --- |
| `s` | Flash Jump |
| `S` | Treesitter Flash |
| `Space p` (visual) | Einfügen, ohne Yank-Register zu verlieren |
| `Space D` | Löschen ins Void-Register |
| `J` / `K` (visual) | Auswahl hoch/runter bewegen |
| `gc{motion}` | Kommentieren |
| `ys{motion}{char}` | Surround hinzufügen |
| `ds{char}` | Surround entfernen |
| `cs{alt}{neu}` | Surround ändern |
| `Ctrl+Space` (normal/visual) | Treesitter-Auswahl erweitern |

## Sessions und Tools

| Key/Command | Aktion |
| --- | --- |
| `Space qs` | Session des aktuellen Ordners laden |
| `Space qS` | Session auswählen |
| `Space ql` | Letzte Session laden |
| `Space .` | Scratch Buffer |
| `:Lazy` | Plugins verwalten |
| `:Mason` | LSPs und CLI-Tools verwalten |
| `:ConformInfo` | Formatter für aktuellen Buffer prüfen |
| `:FormatDisable` | Format-on-save global deaktivieren |
| `:FormatDisable!` | Format-on-save nur im Buffer deaktivieren |
| `:FormatEnable` | Format-on-save wieder aktivieren |
| `:checkhealth` | Neovim-Systemcheck |
| `:VimBeGood` | Vim-Movement trainieren |
