#!/bin/bash
version="0.38.0"
if ! nvm --version | grep -q $version; then
	sudo apt install wget -y
	cd $HOME
	. <(wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh)
	export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
	. ~/.bashrc
fi
