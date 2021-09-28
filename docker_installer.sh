#!/bin/bash
# Default variables
uninstall="false"
# Options
. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/colors.sh) --
option_value(){ echo "$1" | sed -e 's%^--[^=]*=%%g; s%^-[^=]*=%%g'; }
while test $# -gt 0; do
	case "$1" in
	-h|--help)
		. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/logo.sh)
		echo
		echo -e "${C_LGn}Functionality${RES}: the script installs or uninstalls Docker"
		echo
		echo -e "${C_LGn}Usage${RES}: script ${C_LGn}[OPTIONS]${RES}"
		echo
		echo -e "${C_LGn}Options${RES}:"
		echo -e "  -h, --help       show the help page"
		echo -e "  -u, --uninstall  uninstall Docker (${C_R}completely delete all images and containers${RES})"
		echo
		echo -e "${C_LGn}Useful URLs${RES}:"
		echo -e "https://github.com/SecorD0/utils/blob/main/docker_installer.sh - script URL"
		echo -e "https://t.me/letskynode — node Community"
		echo
		return 0
		;;
	-u|--uninstall)
		uninstall="true"
		shift
		;;
	*|--)
		break
		;;
	esac
done
# Actions
if [ "$uninstall" = "true" ]; then
	echo -e "${C_LGn}Uninstalling Docker...${RES}"
	sudo dpkg -r dive
	sudo systemctl stop docker.service
	sudo systemctl stop docker.socket
	sudo rm -rf `systemctl cat docker.service | grep -oPm1 "(?<=^#)([^%]+)"` `systemctl cat docker.socket | grep -oPm1 "(?<=^#)([^%]+)"`
	sudo apt purge docker-engine docker docker.io docker-ce docker-ce-cli -y
	sudo apt autoremove --purge docker-engine docker docker.io docker-ce -y
	sudo apt autoclean
	sudo rm -rf /var/lib/docker /etc/appasudo rmor.d/docker
	sudo groupdel docker
	sudo rm -rf /etc/docker /usr/bin/docker /usr/libexec/docker /usr/libexec/docker/cli-plugins/docker-buildx /usr/libexec/docker/cli-plugins/docker-scan /usr/libexec/docker/cli-plugins/docker-app /usr/share/keyrings/docker-archive-keyring.gpg
else
	cd
	if ! docker --version; then
		echo -e "${C_LGn}Docker installing...${RES}"
		sudo apt update
		sudo apt install curl apt-transport-https ca-certificates gnupg lsb-release -y
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
		echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu `lsb_release -cs` stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
		sudo apt update
		sudo apt install docker-ce docker-ce-cli containerd.io -y
		docker_version=`apt-cache madison docker-ce | grep -oPm1 "(?<=docker-ce \| )([^_]+)(?= \| https)"`
		sudo apt install docker-ce="$docker_version" docker-ce-cli="$docker_version" containerd.io -y
	fi
	if ! dpkg -s dive | grep -q installed; then
		echo -e "${C_LGn}Dive installing...${RES}"
		wget https://github.com/wagoodman/dive/releases/download/v0.9.2/dive_0.9.2_linux_amd64.deb
		sudo apt install ./dive_0.9.2_linux_amd64.deb
		rm -rf dive_0.9.2_linux_amd64.deb
	fi
fi
echo -e "${C_LGn}Done!${RES}"
