#!/bin/bash
if ! docker --version; then
	cd
	sudo apt update
	sudo apt install curl apt-transport-https ca-certificates gnupg lsb-release -y
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt install docker-ce -y
	sudo apt install docker-ce-cli containerd.io -y
	version=$(apt-cache madison docker-ce | grep -oPm1 "(?<=docker-ce \| )([^_]+)(?= \| https)")
	sudo apt install docker-ce="$version" docker-ce-cli="$version" containerd.io -y
fi
