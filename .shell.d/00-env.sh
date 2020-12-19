# Path
export PATH=$HOME/.local/bin:$HOME/bin:$PATH


# Editors
export EDITOR=vim
export GIT_EDITOR=$EDITOR
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR
export PAGER=less
export LESS=-FRSX

# Terraform
#export TF_LOG=DEBUG
export TF_LOG_PATH="$HOME/.terraform.d/terraform.log"
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
