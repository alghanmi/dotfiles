# Load personal config
source ~/.shell.d/*.sh

# ZSH Options
setopt autocd
setopt correct_all
setopt extendedglob
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


# Antigen Setup
if [ -f $ZSH_ANTIGEN_HOME/antigen.zsh ]; then
  #Load antigen
  source $ZSH_ANTIGEN_HOME/antigen.zsh

  # Load the oh-my-zsh's library.
  antigen use oh-my-zsh

  # Zsh completion
  antigen bundle zsh-users/zsh-syntax-highlighting # load before zsh-history-substring-search
  antigen bundle zsh-users/zsh-history-substring-search
  antigen bundle zsh-users/zsh-autosuggestions
  antigen bundle robbyrussell/oh-my-zsh plugins/zsh-completions

  # Bundles
  antigen bundle robbyrussell/oh-my-zsh plugins/git
  antigen bundle robbyrussell/oh-my-zsh paulirish/git-open
  antigen bundle robbyrussell/oh-my-zsh plugins/pip
  antigen bundle robbyrussell/oh-my-zsh plugins/python
  antigen bundle robbyrussell/oh-my-zsh plugins/virtualenv

  antigen bundle robbyrussell/oh-my-zsh plugins/command-not-found
  antigen bundle zsh-users/zsh-completions

  antigen bundle robbyrussell/oh-my-zsh plugins/terraform
  antigen bundle robbyrussell/oh-my-zsh plugins/vault
  antigen bundle robbyrussell/oh-my-zsh plugins/vagrant
  antigen bundle robbyrussell/oh-my-zsh plugins/docker

  antigen bundle rupa/z
  antigen bundle supercrabtree/k

  if [ "$(uname -s)" = "Darwin" ]; then
    antigen bundle robbyrussell/oh-my-zsh plugins/osx
  fi

  # Load theme and colors
  antigen bundle joel-porquet/zsh-dircolors-solarized
  antigen bundle zlsun/solarized-man

  antigen bundle mafredri/zsh-async
  antigen theme denysdovhan/spaceship-prompt spaceship

  # Apply changes
  antigen apply
  export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'

  # Setup Solarized colors (run after `antigen apply`)
  if [[ ! -f $HOME/.zsh-dircolors.config ]]; then
    setupsolarized dircolors.256dark
  fi
fi


# Directory color support
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

autoload -U +X bashcompinit && bashcompinit
