# Path
export PATH=${HOME}/.local/bin:${PATH}

# Homebrew Shell Environment
[ -f ${HOME}/.brewrc ] && source ${HOME}/.brewrc

# Editors
export EDITOR=vim
export GIT_EDITOR=${EDITOR}
export USE_EDITOR=${EDITOR}
export VISUAL=${EDITOR}
export PAGER=less
export LESS=-FRSX

# Locale
export LC_ALL=en_US.UTF-8

# ZSH Configuration Home
export ZDOTDIR=${ZDOTDIR:-$HOME}

# Disable ZSH Shell Sessions (used by MacOS)
export SHELL_SESSIONS_DISABLE=1
