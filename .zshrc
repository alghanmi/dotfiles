#zmodload zsh/zprof

##
## Powerlevel10k instant prompt.
##
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

##
## Shell Configuration Files
##
for filename in $(find ~/.shell.d -name '*.sh' | sort); do source $filename; done

##
## ZSH Configuration
##

# ZSH Environment Options
setopt AUTO_CD
setopt AUTO_PUSHD
setopt CLOBBER
setopt COMPLETE_ALIASES
setopt CORRECT_ALL
setopt EXTENDED_GLOB
setopt INTERACTIVE_COMMENTS
setopt NO_NOMATCH
setopt PUSHD_IGNORE_DUPS

export DISABLE_MAGIC_FUNCTIONS=true
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=239'
bindkey -e vi

# ZSH History Options
HISTSIZE=1000000
SAVEHIST=1000000
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

export HISTORY_IGNORE="(ls|bg|fg|pwd|exit|cd ..)" # Ignore interactive commands from history

##
## GnuPG and SSH
##

# Refresh gpg-agent tty in case user switches into an X session
export GPG_TTY=$(tty)

##
## ZSH Frameworks and Modules
##

# Add custom fpath
fpath+=(${XDG_DATA_HOME}/zsh-completions)


# Load ZIM:FW
zstyle ':zim:zmodule' use 'degit'
zstyle ':zim' 'disable-version-check' 'false'
[ -r "${ZIM_HOME}/zimfw.zsh" ] && source ${ZIM_HOME}/init.zsh

# FZF
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

zstyle ':completion:*:descriptions' format '[%d]'                    # set descriptions format to enable group support
zstyle ':completion:*:git-checkout:*' sort false                     # disable sort when completing `git checkout`
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}                # set list-colors to enable filename colorizing
zstyle ':completion:*' menu no                                       # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup                       # make full use of TMUX's "popup" feature. Requires tmux >= 3.2
zstyle ':fzf-tab:*' switch-group ',' '.'                             # switch group using `,` and `.`
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'   # preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0                       # Use pop-up pads
zstyle ':fzf-tab:*' popup-min-size 50 8                              # adjust pop-up minimum size

# history-search-multi-word module options
zstyle ':plugin:history-search-multi-word' reset-prompt-protect 1  # Enable context-based search
zstyle ':plugin:history-search-multi-word' clear-on-cancel 'yes'   # Whether pressing Ctrl-C or ESC should clear entered query

# Alias Autocompletion
compdef _yadm wyadm

export SDKMAN_DIR=${HOMEBREW_PREFIX}/opt/sdkman-cli/libexec
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"

#autoload -U colors && colors

# Customize Prompt
[[ -f ${HOME}/.p10k.zsh ]] && source ${HOME}/.p10k.zsh

#zprof

