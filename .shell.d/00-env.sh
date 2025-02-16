# Local Path
export PATH=${HOME}/.local/bin:${PATH}

# Terraform
#export TF_LOG=DEBUG
export TF_LOG_PATH="$HOME/.terraform.d/terraform.log"
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"

# FZF
FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# Python
export PYTHON_HISTORY=${XDG_STATE_HOME}/python_history
export PYTHONPYCACHEPREFIX=${XDG_CACHE_HOME}/python
export PYTHONUSERBASE=${XDG_DATA_HOME}/python
