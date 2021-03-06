# Path
export PATH=$HOME/.local/bin:$HOME/bin:$PATH


# Editors
export EDITOR=vim
export GIT_EDITOR=$EDITOR
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR
export PAGER=less
export LESS=-FRSX

# Locale
export LC_ALL=en_US.UTF-8

# Terraform
#export TF_LOG=DEBUG
export TF_LOG_PATH="$HOME/.terraform.d/terraform.log"
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"

# FZF
FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
