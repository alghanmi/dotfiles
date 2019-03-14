# Load shell config files
for filename in $(find ~/.shell.d -name '*.sh'); do
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
  antigen bundle robbyrussell/oh-my-zsh plugins/git
  antigen bundle robbyrussell/oh-my-zsh plugins/golang
  antigen bundle robbyrussell/oh-my-zsh plugins/python
  antigen bundle robbyrussell/oh-my-zsh plugins/pip
  antigen bundle robbyrussell/oh-my-zsh plugins/virtualenv
  antigen bundle robbyrussell/oh-my-zsh plugins/vscod

  antigen bundle robbyrussell/oh-my-zsh plugins/docker
  antigen bundle robbyrussell/oh-my-zsh plugins/terraform
  antigen bundle robbyrussell/oh-my-zsh plugins/vagrant
  antigen bundle robbyrussell/oh-my-zsh plugins/vault

  antigen bundle rupa/z
  antigen bundle supercrabtree/k

  if [ "$(uname -s)" = "Darwin" ]; then
    antigen bundle robbyrussell/oh-my-zsh plugins/osx
  fi

  # Load theme and colors
  antigen bundle zlsun/solarized-man

  antigen bundle mafredri/zsh-async
  antigen bundle sindresorhus/pure

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
