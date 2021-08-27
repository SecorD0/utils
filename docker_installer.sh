# $1 - Uninstall Docker? (true, false)
#!/bin/bash
if [ "$1" = "true" ]; then
	uninstall="true"
else
	uninstall="false"
fi
if [ "$uninstall" = "false" ] && ! docker --version; then
	cd
	sudo apt update
	sudo apt install curl apt-transport-https ca-certificates gnupg lsb-release -y
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt update
	sudo apt install docker-ce docker-ce-cli containerd.io -y
	docker_version=$(apt-cache madison docker-ce | grep -oPm1 "(?<=docker-ce \| )([^_]+)(?= \| https)")
	sudo apt install docker-ce="$docker_version" docker-ce-cli="$docker_version" containerd.io -y
elif [ "$uninstall" = "true" ]; then
	sudo systemctl stop docker.service
	sudo systemctl stop docker.socket
	sudo rm $(systemctl cat docker.service | grep -oPm1 "(?<=^#)([^%]+)")
	sudo rm $(systemctl cat docker.socket | grep -oPm1 "(?<=^#)([^%]+)")
	sudo apt purge docker-engine docker docker.io docker-ce docker-ce-cli -y
	sudo apt autoremove --purge docker-engine docker docker.io docker-ce -y
	sudo apt autoclean
	sudo rm -rf /var/lib/docker
	sudo rm /etc/appasudo rmor.d/docker
	sudo groupdel docker
	sudo rm -rf /etc/docker
	sudo rm -rf /usr/bin/docker
	sudo rm -rf /usr/libexec/docker
	sudo rm -rf /usr/libexec/docker/cli-plugins/docker-buildx
	sudo rm -rf /usr/libexec/docker/cli-plugins/docker-scan
	sudo rm -rf /usr/libexec/docker/cli-plugins/docker-app
	sudo rm -rf /usr/share/keyrings/docker-archive-keyring.gpg
fi
