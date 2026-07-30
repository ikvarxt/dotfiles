# Must precede git.zsh, which calls compdef ~10 times.
# -C skips the once-a-day cache rebuild check; run `compinit` bare after
# installing something that ships completions.
autoload -Uz compinit && compinit -C

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
