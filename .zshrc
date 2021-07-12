##
## Powerlevel10k instant prompt.
## 
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

##
## Shell Configuration Files
##
for filename in $(find ~/.shell.d -name '*.sh' | sort); do
  source $filename
done

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
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=${HISTFILE:-$HOME/.zsh_history}
setopt appendhistory
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt inc_append_history

# Ignore interactive commands from history
export HISTORY_IGNORE="(ls|bg|fg|pwd|exit|cd ..)"

# Set vi mode in ZSH
bindkey -e vi

##
## GnuPG and SSH
##

# Refresh gpg-agent tty in case user switches into an X session
export GPG_TTY=$(tty)
eval "$(gpgconf --launch gpg-agent)"
gpg-connect-agent updatestartuptty /bye >/dev/null

# Enable SSH Agent support in GPG Agent
unset SSH_AGENT_PID
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

##
## ZSH Plugins and Scripts
##

# Load Zinit
source $HOME/.zinit/bin/zinit.zsh

# Completion; use cache if updated within 24h
autoload -Uz compinit
if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' $HOME/.zcompdump) ]; then
  compinit
else
  compinit -C
fi

# Completion for Aliases
compdef wdyadm=yadm

# Fish-like syntax highlighting 
zinit wait lucid light-mode for          \
  atinit"zicompinit; zicdreplay"         \
      zdharma/fast-syntax-highlighting   \
  atload"_zsh_autosuggest_start"         \
      zsh-users/zsh-autosuggestions      \
  blockf atpull'zinit creinstall -q .'   \
      zsh-users/zsh-completions

# Commandline Search
zinit wait lucid for                           \
  light-mode Aloxaf/fzf-tab                    \
  light-mode zdharma/history-search-multi-word 

# Oh My ZSH Plugins and Libraries
zinit for \
  OMZP::colored-man-pages \
  OMZL::termsupport.zsh



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