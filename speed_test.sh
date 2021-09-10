#!/bin/bash
# $1 - any command(s). For example: "df" 'ls -la'
sudo apt install jq -y
start=$(date +%s.%N)
for command in "$@"; do
	eval $command
	. ~/.bash_profile
	echo -e "The operation lasted \e[40m\e[92m$(jq -n "$(date +%s.%N)-$start")\e[0m seconds"
done
