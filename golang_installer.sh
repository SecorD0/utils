# $1 - GO version
#!/bin/bash
if [ -n "$1" ]; then
	go_version=$1
else
	go_version="1.16.5"
fi
if ! go version | grep -q $go_version; then
	sudo apt install tar wget -y
	cd $HOME
	wget "https://golang.org/dl/go$go_version.linux-amd64.tar.gz"
	sudo rm -rf /usr/local/go
	sudo tar -C /usr/local -xzf "go$go_version.linux-amd64.tar.gz"
	rm "go$go_version.linux-amd64.tar.gz"
	echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bash_profile
	. ~/.bash_profile
fi
