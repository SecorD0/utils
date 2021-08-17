# $1 - GO version
#!/bin/bash
if [ -n "$1" ]; then
	version=$1
else
	version="1.16.5"
fi
if ! go version | grep -q $version; then
	sudo apt install tar wget -y
	cd $HOME
	wget "https://golang.org/dl/go$version.linux-amd64.tar.gz"
	sudo rm -rf /usr/local/go
	sudo tar -C /usr/local -xzf "go$version.linux-amd64.tar.gz"
	rm "go$version.linux-amd64.tar.gz"
	echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bash_profile
	. ~/.bash_profile
fi
