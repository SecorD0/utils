#!/bin/bash
# $1 - any command
sudo apt install jq -y
start=$(date +%s.%N)
$1
. ~/.bash_profile
echo -e "The operation lasted \e[40m\e[92m$(jq -n "$(date +%s.%N)-$start")\e[0m seconds"
