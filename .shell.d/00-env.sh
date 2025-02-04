# Base Environment Variables are available in
# ~/.zshenv

# Terraform
#export TF_LOG=DEBUG
export TF_LOG_PATH="$HOME/.terraform.d/terraform.log"
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"

# FZF
FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
