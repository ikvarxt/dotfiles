# Must precede git.zsh, which calls compdef ~10 times.
# -C skips the once-a-day cache rebuild check; run `compinit` bare after
# installing something that ships completions.
autoload -Uz compinit && compinit -C

# Offer dotfiles without typing the leading dot -- every stow package here
# holds nothing but `.config/`, so completion would otherwise come up empty.
# Scoped to the completion system, so plain `*` (and therefore `rm *`) still
# skips them; `setopt globdots` would not.
_comp_options+=(globdots)

# Nothing sets LS_COLORS on macOS (BSD ls reads LSCOLORS), but it is the only
# variable the completion system colorizes from -- without it candidates come
# out unstyled. fd and GNU ls read it too.
export LS_COLORS='di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43'

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'   # case-insensitive
zstyle ':completion:*' group-name ''                     # group by kind
zstyle ':completion:*:descriptions' format '[%d]'        # ...with headers

# The menu that renders these is set up in tools.zsh, next to fzf-tab.

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# EDITOR matches *vi*, which would put zsh in the vi keymap.
bindkey -e

# Without HISTFILE zsh keeps no history across sessions.
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space      # leading space keeps a command out of history
setopt hist_verify            # expand !! for review instead of running it
setopt share_history

alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,.venv,venv}'
alias history='fc -l 1'
