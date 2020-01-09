# Enable Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load shell config files
for filename in $(find ~/.shell.d -name '*.sh' | sort); do
  source $filename
done

# ZSH Options
setopt autocd
setopt clobber
setopt complete_aliases
setopt correct_all
setopt extended_glob
setopt interactive_comments
setopt pushd_ignore_dups

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

# vi mode
bindkey -e vi

# Set locale
export LC_ALL=en_US.UTF-8

# Refresh gpg-agent tty in case user switches into an X session
export GPG_TTY=$(tty)
eval "$(gpgconf --launch gpg-agent)"
gpg-connect-agent updatestartuptty /bye >/dev/null

# Enable SSH Agent support in GPG Agent
unset SSH_AGENT_PID
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

# Ruby Configuration
if command -v rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

# Antigen Setup
if [ -f $ZSH_ANTIGEN_HOME/antigen.zsh ]; then
  #Load antigen
  source $ZSH_ANTIGEN_HOME/antigen.zsh

  # Load the oh-my-zsh's library.
  antigen use oh-my-zsh

  # Zsh completion and highlighting
  antigen bundle zsh-users/zsh-syntax-highlighting # load before zsh-history-substring-search
  antigen bundle zsh-users/zsh-history-substring-search
  antigen bundle zsh-users/zsh-autosuggestions
  antigen bundle zsh-users/zsh-completions

  # Bundles
  antigen bundle git
  antigen bundle golang
  antigen bundle python
  antigen bundle pip
  antigen bundle virtualenv
  antigen bundle vscod

  antigen bundle docker
  antigen bundle terraform
  antigen bundle vagrant
  antigen bundle vault

  antigen bundle rupa/z
  antigen bundle supercrabtree/k

  if [ "$(uname -s)" = "Darwin" ]; then
    antigen bundle osx
  fi

  # Load theme and colors
  antigen bundle zlsun/solarized-man
  antigen theme romkatv/powerlevel10k

  # Apply changes
  antigen apply

  # Setup Solarized colors (run after `antigen apply`)
  export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=239'
  zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}" # Add graphical menu for zsh-completions

  # Completion; use cache if updated within 24h
  autoload -Uz compinit
  if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
    compinit -d $HOME/.zcompdump;
  else
    compinit -C;
  fi

  # Compltion for aliases
  compdef pyadm=yadm
fi

# Customize Prompt
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
