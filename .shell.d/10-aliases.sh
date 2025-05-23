# Standard Aliases
if [ "$(uname -s)" = "Darwin" ]; then
  if command -v gls >/dev/null 2>&1; then
    # GNU ls (from coreutils)
    alias ls='gls -F --color'
    alias l='gls -lAh --color'
    alias ll='gls -l --color'
    alias la='gls -A --color'
  else
    # BSD ls colored
    alias ls='ls -G'
    alias ll='ls -Gl'
    alias lt='ls -Glht'
  fi

  # Package Management
  alias update='brew update && brew upgrade && brew upgrade --cask && brew doctor'

  #dircolors
  alias dircolors='gdircolors'

  # Check open ports
  alias open-ports='lsof -i | grep -E "(LISTEN|ESTABLISHED)"'
else
  # ls colored
  alias ls='ls --color=auto'
  alias ll='ls -l --color=auto'
  alias lt='ls -lht --color=auto'

  # Package Management
  alias update='sudo apt update && sudo apt full-upgrade && sudo apt autoremove && sudo apt clean'
fi

# grep colored
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ip colored
alias ip='ip -c'

# GPG Aliases
alias gpg-reload='gpg-connect-agent reloadagent /bye'

# Alias vi to vim
alias vi='vim'

# TLS Certificate Checks
alias ssl_cert='openssl x509 -text -noout -in '
alias ssl_cert_connect='openssl s_client -showcerts -connect '
alias ssl_nmap='nmap --script ssl-cert,ssl-enum-ciphers -p 443 '

# What is my ip
alias myip='curl ifconfig.co'
alias myipdns='dig +short myip.opendns.com @resolver1.opendns.com'

# Terraform
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfi='terraform init'
alias tff='terraform fmt'

# Mount remote fs `rmnt <remote> <local>`
alias rmnt='sshfs -o uid=$(id -u) -o gid=$(id -g)'

# Stop all SSH ControlMaster connections
alias ssh-kill-cm='find ~/.ssh/sockets -type s ! -name "root-*" -exec ssh ssh -o ControlPath={} -O exit \;'
alias ssh-kill-cm-root='sudo find ~/.ssh/sockets -type s -name "root-*" -exec ssh ssh -o ControlPath={} -O exit \;'

# Docker Aliases
alias docker-clean='docker ps -a --format "{{ .ID }}" | xargs docker rm; docker images --filter "dangling=true" --format "{{ .ID }}" | xargs docker rmi'

alias yadm-code='cd $HOME && yadm list -a | xargs code --new-window'

## Functions (used as aliases)
# SSH without using key
function ssh_nokey() { ssh -o PreferredAuthentications=keyboard-interactive,password -o PubkeyAuthentication=no "$@" ;}

# TLS Certificate Checks
function ssl_cert_connect_dns() { openssl s_client -showcerts -connect "$@" | openssl x509 -text -noout | grep DNS  ;}

# Obtain Weather information from wttr
function w(){curl "https://wttr.in/$1?F"}
