# AGENTS.md - AI Agent Instructions for Archer

## Project Overview

Archer is an interactive fzf-based TUI for Arch Linux package management. It provides install, remove, and search/browse functionality through a unified `archer` command that dispatches to dedicated scripts.

## Architecture

```
bin/archer           → Main launcher, fzf menu, subcommand dispatcher
bin/archer-install   → Package installation (official + AUR)
bin/archer-remove    → Package removal
bin/archer-search    → Package browsing (read-only)
lib/archer-core.sh   → Shared library (PM detection, colors, helpers)
```

Every script sources `archer-core.sh` via a resolution preamble that searches three locations: relative to the script (dev), `~/.local/lib/` (user install), `/usr/lib/` (system install).

## Critical Rules

1. **Never hardcode a terminal emulator.** Desktop entry uses `Terminal=true`. Scripts are terminal-agnostic.
2. **Never hardcode a package manager.** Always use `$PM` (set by `detect_pm()` in archer-core.sh). The detection order is yay > paru > pacman.
3. **Never use `--noconfirm`.** Users must always review and confirm package operations.
4. **Maintain shellcheck compliance.** All scripts must pass `shellcheck` with no warnings. Run `make check`.
5. **Degrade gracefully.** If an optional tool (pactree, yay, paru) is missing, show a helpful message instead of crashing.
6. **Keep scripts POSIX-adjacent bash.** Use `#!/usr/bin/env bash` and `set -euo pipefail`.

## Color Convention

| Context | Color | Usage |
|---------|-------|-------|
| Install | Green | Additive/safe actions |
| Remove | Red | Destructive actions |
| Search | Cyan | Informational/read-only |
| Menu | Magenta | Navigation/selection |
| Warnings | Yellow | Non-fatal issues |

## Development Workflow

```bash
make dev     # Symlink bin/ and lib/ to ~/.local for live testing
make check   # Run shellcheck + bash -n
make clean   # Clear ~/.cache/archer
```

## File Structure

| Path | Purpose | Auto-generated? |
|------|---------|-----------------|
| `lib/archer-core.sh` | Shared library | No |
| `bin/archer` | Main launcher | No |
| `bin/archer-install` | Install mode | No |
| `bin/archer-remove` | Remove mode | No |
| `bin/archer-search` | Search/browse mode | No |
| `completions/` | Shell completions (bash, zsh, fish) | No |
| `desktop/archer.desktop` | XDG desktop entry | No |
| `Makefile` | Build/install targets | No |
| `PKGBUILD` | AUR packaging | No |
| `install.sh` | Curl one-liner installer | No |

## Testing Checklist

When making changes, verify:

- [ ] `make check` passes (shellcheck + syntax)
- [ ] Works with pacman only (no AUR helper)
- [ ] Works with yay
- [ ] Works with paru
- [ ] Works without pactree (pacman-contrib not installed)
- [ ] `archer --help` and `archer --version` work
- [ ] Interactive menu works (no args)
- [ ] Each subcommand works: install, remove, search
- [ ] `make install` and `make uninstall` are clean

## Version Bumping

Version is defined in `lib/archer-core.sh` as `ARCHER_VERSION`. Update it there; all scripts inherit it. Also update `PKGBUILD` pkgver to match.
