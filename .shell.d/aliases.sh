# Personal/Private YADM Repository
alias pyadm='yadm --yadm-dir ~/.yadm-personal'

# Standard Aliases
if [ "$(uname -s)" = "Darwin" ]; then
  # ls colored
  alias ls='ls -G'
  alias ll='ls -Gl'
  alias lt='ls -Glht'

  # Package Management
  alias update='brew update && brew upgrade --cleanup && brew cleanup && brew cask cleanup && brew prune && brew cask upgrade && brew doctor'

  #dircolors
  alias dircolors='gdircolors'

  # Check open ports
  alias op='lsof -i | grep -E "(LISTEN|ESTABLISHED)"'
else
  # ls colored
  alias ls='ls --color=auto'
  alias ll='ls -l --color=auto'
  alias lt='ls -lht --color=auto'

  # Package Management
  alias update='sudo apt update && sudo apt full-upgrade && sudo apt autoremove && sudo apt clean'
fi

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# GPG Aliases
alias gpg-reload='echo KILLAGENT | gpg-connect-agent && gpg-connect-agent /bye; gpgconf --kill gpg-agent'

# Alias vi to vim
alias vi='vim'

# TLS Certificate Checks
alias ssl_cert='openssl x509 -text -noout -in '
alias ssl_cert_connect='openssl s_client -showcerts -connect '
alias ssl_nmap='nmap --script ssl-cert,ssl-enum-ciphers -p 443 '

# What is my ip
alias myip='curl ifconfig.co'
alias myipdns='dig +short myip.opendns.com @resolver1.opendns.com'

# AWS Helpers
alias awsenv='source ~/bin/aws-profile-picker.sh'
alias awsroles='cat ~/.aws/credentials| grep "^\[" | sed "s/\[\(.*\)\]/\1/" | sort'

# Mount remote fs `rmnt <remote> <local>`
alias rmnt='sshfs -o uid=$(id -u) -o gid=$(id -g)'

# Stop all SSH ControlMaster connections
alias ssh-kill-cm='find ~/.ssh/sockets -type s -exec ssh ssh -o ControlPath={} -O stop \;'

## Functions (used as aliases)
# SSH without using key
function ssh_nokey() { ssh -o PreferredAuthentications=keyboard-interactive,password -o PubkeyAuthentication=no "$@" ;}

# TLS Certificate Checks
function ssl_cert_connect_dns() { openssl s_client -showcerts -connect "$@" | openssl x509 -text -noout | grep DNS  ;}
