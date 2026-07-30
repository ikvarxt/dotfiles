command -v starship >/dev/null && eval "$(starship init zsh)"

[[ -x "$HOME/.local/bin/mise" ]] && eval "$("$HOME/.local/bin/mise" activate zsh)"

# Ctrl-R history / Ctrl-T files / Alt-C cd
command -v fzf >/dev/null && eval "$(fzf --zsh)"

# Do not fake TERM_PROGRAM here: it breaks kitty graphics detection, so
# yazi/chafa image previews fall back to Apple Terminal mode.
