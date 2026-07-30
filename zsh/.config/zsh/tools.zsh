command -v starship >/dev/null && eval "$(starship init zsh)"

[[ -x "$HOME/.local/bin/mise" ]] && eval "$("$HOME/.local/bin/mise" activate zsh)"

# Ctrl-R history / Ctrl-T files / Alt-C cd
command -v fzf >/dev/null && eval "$(fzf --zsh)"

# `z <part-of-path>` jumps by frecency, `zi` picks interactively with fzf.
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# Tab completion menu. Must load after compinit (core.zsh) and after
# `fzf --zsh` above -- all three bind ^I and the last one wins. `menu no` lets
# fzf-tab capture the unambiguous prefix itself; the rest of its defaults are
# fine as shipped.
_fzf_tab=/opt/homebrew/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh
[[ -r $_fzf_tab ]] || _fzf_tab=/usr/share/zsh/plugins/fzf-tab/fzf-tab.zsh
if [[ -r $_fzf_tab ]]; then
  zstyle ':completion:*' menu no
  source $_fzf_tab
  # Preview runs in a fresh non-interactive zsh: only $realpath/$word and
  # external commands are in scope, never this config's functions or aliases.
  zstyle ':fzf-tab:complete:*:*' fzf-preview \
    '[[ -d $realpath ]] && CLICOLOR_FORCE=1 ls -1Ap -G -- $realpath || head -100 -- ${realpath:-/dev/null} 2>/dev/null'
fi
unset _fzf_tab

# Do not fake TERM_PROGRAM here: it breaks kitty graphics detection, so
# yazi/chafa image previews fall back to Apple Terminal mode.
