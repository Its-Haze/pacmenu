# CLAUDE.md - Claude Code Instructions for pacmenu

pacmenu is an fzf-based TUI for Arch Linux package management (install/remove/search).

## Quick Reference

- **Shared library:** `lib/pacmenu-core.sh` (version, PM detection, colors, helpers)
- **Scripts:** `bin/pacmenu`, `bin/pacmenu-install`, `bin/pacmenu-remove`, `bin/pacmenu-search`
- **Version:** Set `PACMENU_VERSION` in `lib/pacmenu-core.sh`, keep `PKGBUILD` pkgver in sync
- **Lint:** `make check` (shellcheck + bash -n)
- **Dev setup:** `make dev` (symlinks to ~/.local)

## Rules

- Use `$PM` from `detect_pm()`, never hardcode yay/paru/pacman
- Never add `--noconfirm` to any package operation
- All scripts must pass `shellcheck`
- Degrade gracefully when optional tools are missing

See `AGENTS.md` for full architecture and testing details.
