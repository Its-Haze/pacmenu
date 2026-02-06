# pacmenu

Interactive fzf-based TUI for Arch Linux package management. Install, remove, and browse packages with fuzzy search, multi-select, and live previews.

## Features

- **Install** packages from official repos and AUR with live info/PKGBUILD preview
- **Remove** packages with dependency tree inspection
- **Browse** installed packages with info, dependency trees, and file listings
- **Auto-detects** your AUR helper (yay > paru > pacman fallback)
- **Degrades gracefully** when optional tools are missing
- Multi-select with Tab, keyboard-driven workflow

### Keybindings

| Key | Action |
|-----|--------|
| Tab | Select/deselect package |
| Enter | Confirm selection |
| Esc | Cancel/exit |
| Alt-P | Toggle preview panel |
| Alt-J/K | Scroll preview |
| Alt-I | Package info |
| Alt-B | View PKGBUILD (install mode, requires yay/paru) |
| Alt-D | Dependency tree (requires pacman-contrib) |
| Alt-F | Installed files list (search mode) |

### Color Coding

| Mode | Color | Meaning |
|------|-------|---------|
| Menu | Magenta | Navigation |
| Install | Green | Additive action |
| Remove | Red | Destructive action |
| Search | Cyan | Informational |

## Install

### Quick Install

```bash
curl -sSL https://raw.githubusercontent.com/Its-Haze/pacmenu/main/install.sh | bash
```

### Manual Install

```bash
git clone https://github.com/Its-Haze/pacmenu.git
cd pacmenu
make install
```

Default `PREFIX` is `~/.local`. For system-wide:

```bash
sudo make PREFIX=/usr install
```

### AUR

```bash
yay -S pacmenu
```

### Uninstall

```bash
make uninstall
# or for system-wide:
sudo make PREFIX=/usr uninstall
```

## Usage

```bash
pacmenu              # Interactive menu
pacmenu install      # Install packages
pacmenu remove       # Remove packages
pacmenu search       # Browse installed packages
pacmenu --help       # Show help
pacmenu --version    # Show version
```

Short aliases: `pacmenu i`, `pacmenu r`, `pacmenu s`

## Dependencies

| Package | Required | Purpose |
|---------|----------|---------|
| bash | Yes | Shell runtime |
| fzf | Yes | Fuzzy finder interface |
| pacman | Yes | Package management (Arch Linux) |
| yay | No | AUR support (recommended) |
| paru | No | AUR support (alternative) |
| pacman-contrib | No | Dependency tree viewing (pactree) |

## Screenshots

<!-- TODO: Add screenshots/GIFs -->

## Development

```bash
git clone https://github.com/Its-Haze/pacmenu.git
cd pacmenu
make dev       # Symlink scripts for live development
make check     # Run shellcheck + syntax validation
make clean     # Clear package cache
```

## Acknowledgments

Inspired by [Omarchy](https://github.com/DHMorse/omarchy)'s package management scripts.

## License

[MIT](LICENSE)
