# $1 - Node.js version
#!/bin/bash
if [ -n "$1" ]; then
	nodejs_version=$1
else
	nodejs_version="14.17.5"
fi
if ! node --version | grep -q $nodejs_version; then
	sudo apt install tar wget -y
	. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/nvm_installer.sh)
	nvm install $nodejs_version
	nvm use $nodejs_version
fi
