#!/bin/bash
version="1.16.5"
if ! go version | grep -q $version; then
	sudo apt install tar -y
	cd $HOME
	wget "https://golang.org/dl/go$version.linux-amd64.tar.gz"
	sudo rm -rf /usr/local/go
	sudo tar -C /usr/local -xzf "go$version.linux-amd64.tar.gz"
	rm go1.16.5.linux-amd64.tar.gz
	echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bash_profile
	source ~/.bash_profile
fi
