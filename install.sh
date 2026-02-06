#!/usr/bin/env bash
# pacmenu installer - curl one-liner:
#   curl -sSL https://raw.githubusercontent.com/Its-Haze/pacmenu/main/install.sh | bash
#
# Installs pacmenu to ~/.local/bin and ~/.local/lib/pacmenu

set -euo pipefail

REPO_URL="https://raw.githubusercontent.com/Its-Haze/pacmenu/main"
PREFIX="${HOME}/.local"
BINDIR="${PREFIX}/bin"
LIBDIR="${PREFIX}/lib/pacmenu"
COMPDIR_BASH="${PREFIX}/share/bash-completion/completions"
COMPDIR_ZSH="${PREFIX}/share/zsh/site-functions"
COMPDIR_FISH="${PREFIX}/share/fish/vendor_completions.d"
DESKTOPDIR="${PREFIX}/share/applications"

RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\033[1m'
RESET='\033[0m'

die() {
    echo -e "${RED}${BOLD}Error:${RESET} $*" >&2
    exit 1
}

# Check required dependencies
command -v pacman &>/dev/null || die "pacman not found. pacmenu requires Arch Linux."
command -v fzf &>/dev/null || die "fzf not found. Install it first: sudo pacman -S fzf"
command -v curl &>/dev/null || die "curl not found. Install it first: sudo pacman -S curl"

echo -e "${GREEN}${BOLD}Installing pacmenu...${RESET}"

# Create directories
mkdir -p "$BINDIR" "$LIBDIR" "$COMPDIR_BASH" "$COMPDIR_ZSH" "$COMPDIR_FISH" "$DESKTOPDIR"

# Download scripts
for script in pacmenu pacmenu-install pacmenu-remove pacmenu-search; do
    curl -sSL "$REPO_URL/bin/$script" -o "$BINDIR/$script"
    chmod 755 "$BINDIR/$script"
done

# Download library
curl -sSL "$REPO_URL/lib/pacmenu-core.sh" -o "$LIBDIR/pacmenu-core.sh"
chmod 644 "$LIBDIR/pacmenu-core.sh"

# Download completions
curl -sSL "$REPO_URL/completions/pacmenu.bash" -o "$COMPDIR_BASH/pacmenu"
curl -sSL "$REPO_URL/completions/_pacmenu" -o "$COMPDIR_ZSH/_pacmenu"
curl -sSL "$REPO_URL/completions/pacmenu.fish" -o "$COMPDIR_FISH/pacmenu.fish"

# Download desktop entry
curl -sSL "$REPO_URL/desktop/pacmenu.desktop" -o "$DESKTOPDIR/pacmenu.desktop"

echo ""
echo -e "${GREEN}${BOLD}pacmenu installed successfully!${RESET}"
echo ""
echo "  Usage: pacmenu              (interactive menu)"
echo "         pacmenu install      (install packages)"
echo "         pacmenu remove       (remove packages)"
echo "         pacmenu search       (browse packages)"
echo ""

# Check PATH
if [[ ":$PATH:" != *":$BINDIR:"* ]]; then
    echo -e "${BOLD}Note:${RESET} $BINDIR is not in your PATH."
    echo "  Add it with: export PATH=\"$BINDIR:\$PATH\""
fi
