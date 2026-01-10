#!/bin/bash

set -e

ALACRITTY_CONFIG="$HOME/.config/alacritty/alacritty.toml"

VALID_THEMES=("latte" "frappe" "macchiato" "mocha")

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

is_valid_theme() {
    local theme=$1
    for valid in "${VALID_THEMES[@]}"; do
        if [[ "$valid" == "$theme" ]]; then
            return 0
        fi
    done
    return 1
}

switch_theme() {
    local theme=$1
    local theme_import="./catppuccin-$theme.toml"

    if grep -q "^import = \[" "$ALACRITTY_CONFIG"; then
        sed -i.tmp "s|^import = \[.*catppuccin-[a-z]*\.toml.*\]|import = [\"$theme_import\"]|" "$ALACRITTY_CONFIG"
    elif grep -q "^import = \".*catppuccin-[a-z]*\.toml\"" "$ALACRITTY_CONFIG"; then
        sed -i.tmp "s|^import = \".*catppuccin-[a-z]*\.toml\"|import = [\"$theme_import\"]|" "$ALACRITTY_CONFIG"
    else
        sed -i.tmp "1i\\
import = [\"$theme_import\"]\\
" "$ALACRITTY_CONFIG"
    fi

    rm -f "$ALACRITTY_CONFIG.tmp"
}

main() {
    if [[ $# -eq 0 ]]; then
        echo -e "${RED}sepecify theme nema"
        echo ""
        exit 0
    fi

    local theme=$1

    if ! is_valid_theme "$theme"; then
        echo -e "${RED}invalid theme '$theme'${NC}"
        exit 1
    fi

    switch_theme "$theme"
    echo ""
}

main "$@"
