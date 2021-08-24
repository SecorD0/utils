# $1 - NVM version
#!/bin/bash
if [ -n "$1" ]; then
	version=$1
else
	version="0.38.0"
fi
if ! nvm --version | grep -q $version; then
	sudo apt install wget -y
	cd $HOME
	. <(wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/v$version/install.sh")
	export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
	. ~/.bashrc
fi
