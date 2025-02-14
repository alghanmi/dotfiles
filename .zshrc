#zmodload zsh/zprof
##
## Powerlevel10k instant prompt.
## 
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

##
## Customizations
##
export DISABLE_NVM_LOADING=1

##
## Shell Configuration Files
##
for filename in $(find ~/.shell.d -name '*.sh' | sort); do source $filename; done

##
## ZSH Configuration
##

# ZSH Options
setopt autocd
setopt clobber
setopt complete_aliases
setopt correct_all
setopt extended_glob
setopt interactive_comments
setopt nonomatch
setopt pushd_ignore_dups

DISABLE_MAGIC_FUNCTIONS=true

# ZSH History Options
HISTSIZE=500000
SAVEHIST=500000
HISTFILE=${HISTFILE:-$ZDOTDIR/.zsh_history}
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt APPEND_HISTORY            # append to history file
setopt HIST_NO_STORE             # Don't store history commands

# Ignore interactive commands from history
export HISTORY_IGNORE="(ls|bg|fg|pwd|exit|cd ..)"

# Set vi mode in ZSH
bindkey -e vi

##
## GnuPG and SSH
##

# Refresh gpg-agent tty in case user switches into an X session
export GPG_TTY=$(tty)

##
## ZSH Plugins and Scripts
##

# Load Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ -f "${ZINIT_HOME}/zinit.zsh" ] && source "${ZINIT_HOME}/zinit.zsh"

# FZF
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# Completion; use cache if updated within 24h
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Fish-like syntax highlighting 
zinit wait lucid light-mode for                    \
  atinit"zicompinit; zicdreplay"                   \
      zdharma-continuum/fast-syntax-highlighting   \
  atload"_zsh_autosuggest_start"                   \
      zsh-users/zsh-autosuggestions                \
  blockf atpull'zinit creinstall -q .'             \
      zsh-users/zsh-completions

# Commandline Search
zinit wait lucid for                                      \
  light-mode Aloxaf/fzf-tab                               \
  light-mode zdharma-continuum/history-search-multi-word

# Oh My ZSH Plugins and Libraries
zinit for \
  OMZP::colored-man-pages

# Plugin options
zstyle :plugin:history-search-multi-word reset-prompt-protect 1 # Enable context-based search
zstyle ':completion:*:git-checkout:*' sort false                # disable sort when completing `git checkout`
zstyle ':completion:*:descriptions' format '[%d]'               # set descriptions format to enable group support
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}           # set list-colors to enable filename colorizing
zstyle ':fzf-tab:*' switch-group ',' '.'                        # switch group using `,` and `.`

# Load theme
zinit light romkatv/powerlevel10k

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=239'
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}" # Add graphical menu for zsh-completions

# Customize Prompt
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#zprof