#!/usr/bin/env bash
# archer-core.sh - Shared library for archer package management TUI
# Sourced by all archer scripts. Do not execute directly.

# shellcheck disable=SC2034  # Variables used by sourcing scripts

ARCHER_VERSION="1.0.0"

# ── Colors ───────────────────────────────────────────────────────────
GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
YELLOW='\033[0;33m'
BOLD='\033[1m'
RESET='\033[0m'

# ── Output helpers ───────────────────────────────────────────────────

die() {
    echo -e "${RED}${BOLD}Error:${RESET} $*" >&2
    exit 1
}

warn() {
    echo -e "${YELLOW}${BOLD}Warning:${RESET} $*" >&2
}

info() {
    echo -e "${CYAN}${BOLD}::${RESET} $*"
}

# ── Package manager detection ────────────────────────────────────────

# Sets PM to the best available package manager (yay > paru > pacman)
detect_pm() {
    if command -v yay &>/dev/null; then
        PM="yay"
    elif command -v paru &>/dev/null; then
        PM="paru"
    else
        PM="pacman"
        warn "No AUR helper found (yay/paru). Only official repo packages available."
    fi
    export PM
}

# ── Dependency checking ──────────────────────────────────────────────

# Validates that required dependencies are installed
check_deps() {
    local missing=()

    if ! command -v pacman &>/dev/null; then
        die "pacman not found. Archer requires Arch Linux (or an Arch-based distro)."
    fi

    if ! command -v fzf &>/dev/null; then
        missing+=("fzf")
    fi

    if [[ ${#missing[@]} -gt 0 ]]; then
        die "Missing required dependencies: ${missing[*]}
  Install with: sudo pacman -S ${missing[*]}"
    fi

    if ! has_pactree; then
        warn "pactree not found. Install pacman-contrib for dependency tree viewing:
  sudo pacman -S pacman-contrib"
    fi
}

# Returns 0 if pactree is available, 1 otherwise
has_pactree() {
    command -v pactree &>/dev/null
}

# ── Cache ────────────────────────────────────────────────────────────

get_cache_dir() {
    local dir="${XDG_CACHE_HOME:-$HOME/.cache}/archer"
    mkdir -p "$dir"
    echo "$dir"
}

# ── Library resolution preamble (for documentation) ──────────────────
# Each script should include this near the top:
#
#   SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
#   for _lib in \
#       "$SCRIPT_DIR/../lib/archer-core.sh" \
#       "$HOME/.local/lib/archer/archer-core.sh" \
#       "/usr/lib/archer/archer-core.sh"; do
#       [[ -f "$_lib" ]] && { source "$_lib"; break; }
#   done
#   [[ -z "${ARCHER_VERSION:-}" ]] && { echo "Error: archer-core.sh not found" >&2; exit 1; }
