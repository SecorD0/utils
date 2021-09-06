#!/bin/bash
# $1 - any command
start=$(date +%s)
$1
. ~/.bash_profile
echo -e "The operation lasted \e[40m\e[92m$((`date +%s`-$start))\e[0m seconds"
