# GPG and SSH Agent Configuration
if [[ -z ${SSH_CONNECTION} ]]; then
  if [[ ! -S "$(gpgconf --list-dir agent-socket)" ]]; then
    eval "$(gpgconf --launch gpg-agent)"
  fi

  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# ZSH zcompile for speed-up
{
  # Function to compile a file if it's newer than its compiled version
  zcompile_if_needed() {
    local file="$1"
    if [[ -s "$file" && (! -s "${file}.zwc" || "$file" -nt "${file}.zwc") ]]; then
      zcompile "$file"
    fi
  }

  # Compile main zsh configuration files
  zcompile_if_needed "${ZDOTDIR:-$HOME}/.zshenv"
  zcompile_if_needed "${ZDOTDIR:-$HOME}/.zshrc"
  zcompile_if_needed "${ZDOTDIR:-$HOME}/.zlogin"
  zcompile_if_needed "${ZDOTDIR:-$HOME}/.zimrc"

  # Compile completion cache (significant speedup)
  zcompile_if_needed "${ZDOTDIR:-$HOME}/.zcompdump"

  # Compile p10k configuration
  zcompile_if_needed "${HOME}/.p10k.zsh"

  # Compile all shell.d configuration files
  for file in ${HOME}/.shell.d/*.sh(N); do
    zcompile_if_needed "$file"
  done
} &!
