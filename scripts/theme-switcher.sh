#!/bin/bash

set -e

if defaults read -g AppleInterfaceStyle &>/dev/null; then
    THEME="mocha"
else
    THEME="latte"
fi

# switch alacritty theme
sed -i.tmp "s|catppuccin-[a-z]*\.toml|catppuccin-$THEME.toml|" "$HOME/.config/alacritty/alacritty.toml"
rm -f "$HOME/.config/alacritty/alacritty.toml.tmp"
# switch neovim theme
sed -i.tmp "s|flavour = '[a-z]*'|flavour = '$THEME'|" "$HOME/.config/nvim/lua/custom/plugins/catppuccin.lua"
rm -f "$HOME/.config/nvim/lua/custom/plugins/catppuccin.lua.tmp"
