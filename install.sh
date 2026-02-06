#!/usr/bin/env bash
# archer installer - curl one-liner:
#   curl -sSL https://raw.githubusercontent.com/OWNER/archer/main/install.sh | bash
#
# Installs archer to ~/.local/bin and ~/.local/lib/archer

set -euo pipefail

REPO_URL="https://raw.githubusercontent.com/Its-Haze/archer/main"
PREFIX="${HOME}/.local"
BINDIR="${PREFIX}/bin"
LIBDIR="${PREFIX}/lib/archer"
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
command -v pacman &>/dev/null || die "pacman not found. Archer requires Arch Linux."
command -v fzf &>/dev/null || die "fzf not found. Install it first: sudo pacman -S fzf"
command -v curl &>/dev/null || die "curl not found. Install it first: sudo pacman -S curl"

echo -e "${GREEN}${BOLD}Installing archer...${RESET}"

# Create directories
mkdir -p "$BINDIR" "$LIBDIR" "$COMPDIR_BASH" "$COMPDIR_ZSH" "$COMPDIR_FISH" "$DESKTOPDIR"

# Download scripts
for script in archer archer-install archer-remove archer-search; do
    curl -sSL "$REPO_URL/bin/$script" -o "$BINDIR/$script"
    chmod 755 "$BINDIR/$script"
done

# Download library
curl -sSL "$REPO_URL/lib/archer-core.sh" -o "$LIBDIR/archer-core.sh"
chmod 644 "$LIBDIR/archer-core.sh"

# Download completions
curl -sSL "$REPO_URL/completions/archer.bash" -o "$COMPDIR_BASH/archer"
curl -sSL "$REPO_URL/completions/_archer" -o "$COMPDIR_ZSH/_archer"
curl -sSL "$REPO_URL/completions/archer.fish" -o "$COMPDIR_FISH/archer.fish"

# Download desktop entry
curl -sSL "$REPO_URL/desktop/archer.desktop" -o "$DESKTOPDIR/archer.desktop"

echo ""
echo -e "${GREEN}${BOLD}archer installed successfully!${RESET}"
echo ""
echo "  Usage: archer              (interactive menu)"
echo "         archer install      (install packages)"
echo "         archer remove       (remove packages)"
echo "         archer search       (browse packages)"
echo ""

# Check PATH
if [[ ":$PATH:" != *":$BINDIR:"* ]]; then
    echo -e "${BOLD}Note:${RESET} $BINDIR is not in your PATH."
    echo "  Add it with: export PATH=\"$BINDIR:\$PATH\""
fi
