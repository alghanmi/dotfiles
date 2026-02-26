# XDG Base Directory Configuration
# https://specifications.freedesktop.org/basedir-spec/latest/
export XDG_CACHE_HOME=${HOME}/.cache
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_DATA_HOME=${HOME}/.local/share
export XDG_STATE_HOME=${HOME}/.local/state

# MacOS Path Initialization
# The /usr/libexec/path_helper script will cause duplicate PATH entries when using TMUX. This issue
# is partially resolved in zprofile (see comments there). However we need to reset the path here to
# avoid duplicates.
[ -f "${XDG_CONFIG_HOME}/macos/path-init" ] && source "${XDG_CONFIG_HOME}/macos/path-init"

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
export ZSH_COMPDUMP=${XDG_CACHE_HOME}/zsh/zcompdump

export ZIM_CONFIG_FILE=${ZDOTDIR}/.zimrc
export ZIM_HOME=${XDG_CACHE_HOME}/zim

# ZSH Shell Prompt
export STARSHIP_CONFIG=${XDG_CONFIG_HOME}/starship/starship.toml
export STARSHIP_CACHE=${XDG_CACHE_HOME}/starship

# Disable ZSH Shell Sessions (used by MacOS)
export SHELL_SESSIONS_DISABLE=1
