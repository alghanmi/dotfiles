# GPG and SSH Agent Configuration
#eval "$(gpgconf --launch gpg-agent)"
#export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

if [[ -z ${SSH_CONNECTION} ]]; then
	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
#if [[ -z ${SSH_CONNECTION} ]] && [[ ! -S "$(gpgconf --list-dir agent-socket)" ]]; then
#	export GPG_TTY=$(tty)
#	eval "$(gpgconf --launch gpg-agent)"
#	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
#fi




# ZSH zcompile for speed-up
{
  # zcompile the completion cache for siginificant speedup
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
  
  # zcompile .zshrc
  zshrc="${ZDOTDIR:-$HOME}/.zshrc"
  if [[ -s "$zshrc" && (! -s "${zshrc}.zwc" || "$zshrc" -nt "${zshrc}.zwc") ]]; then
      zcompile "$zshrc"
  fi
} &!
