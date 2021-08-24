# $1 - Node.js version
#!/bin/bash
if [ -n "$1" ]; then
	node_version=$1
else
	node_version="14.17.5"
fi
if ! node --version | grep -q $node_version; then
	sudo apt install tar wget -y
	. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/nvm_installer.sh)
	nvm install $node_version
	nvm use $node_version
fi