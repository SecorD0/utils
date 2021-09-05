#!/bin/bash
# $1 - NVM version
if [ -n "$1" ]; then
	nvm_version=$1
else
	nvm_version="0.38.0"
fi
if ! nvm --version | grep -q $nvm_version; then
	sudo apt install wget -y
	cd $HOME
	. <(wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/v$nvm_version/install.sh")
	export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
	. ~/.bashrc
fi
