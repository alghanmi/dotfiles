#!/bin/bash

# List credentials and regions of interest
roles=($(cat ~/.aws/credentials | grep "^\[" | sed "s/\[\(.*\)\]/\1/" | sort))
regions=(us-east-1 us-west-2 eu-central-1 eu-west-1)

function choose_from_list() {
  items=($@)
  item_id=1
  for item in ${items[@]}; do
    echo "[$(printf '%02d' $item_id)] $item"
    item_id=$(( item_id + 1 ))
  done
  item_id=$(( item_id - 1 ))

  valid_item=0
  echo ""
  while [ "$valid_item" -lt 1 ]; do
    echo -n "Please choose [1..$item_id]: "
    read item
    if [ "$item" -ge 1 ] && [ "$item" -le "$item_id" ]; then
      result="${items[ $item ]}"
      valid_item=1
    else
      echo -n "Invalid response. "
    fi
  done
}

echo -e "\e[33mPlease choose the \e[32mAWS Profile\e[33m you want:\e[0m"
choose_from_list "${roles[@]}"
export AWS_PROFILE=$result

echo -e "\e[33mPlease choose the \e[32mAWS Region\e[33m you want:\e[0m"
choose_from_list "${regions[@]}"
export AWS_DEFAULT_REGION=$result

echo -e "\e[33mYou chose: \e[32m${AWS_PROFILE}\e[33m on \e[32m${AWS_DEFAULT_REGION}\e[33m.\e[33m"
