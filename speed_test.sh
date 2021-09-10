#!/bin/bash
# $1 - any command(s) (string)
sudo apt install jq -y
start=$(date +%s.%N)
for command in "$@"; do
	$command | sed -e "s%\"%%g; s%'%%g"
	. ~/.bash_profile
	echo -e "The operation lasted \e[40m\e[92m$(jq -n "$(date +%s.%N)-$start")\e[0m seconds"
done
