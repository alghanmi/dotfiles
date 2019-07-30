##
## TMUX environment setup
##

# XTERM modifications (in case needed)
export TERM="xterm-256color"

# Set $TERM for TMUX
if [ -n "$TMUX" ]; then
  export TERM=screen-256color
fi

alias tmux='tmux -2'
