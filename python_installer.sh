#!/bin/bash
# Default variables
python_version="3.9.6"
# Options
. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/colors.sh) --
option_value(){ echo "$1" | sed -e 's%^--[^=]*=%%g; s%^-[^=]*=%%g'; }
while test $# -gt 0; do
	case "$1" in
	-h|--help)
		. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/logo.sh)
		echo
		echo -e "${C_LGn}Functionality${RES}: the script installs Python"
		echo
		echo -e "${C_LGn}Usage${RES}: script ${C_LGn}[OPTIONS]${RES}"
		echo
		echo -e "${C_LGn}Options${RES}:"
		echo -e "  -h, --help             show the help page"
		echo -e "  -v, --version VERSION  Python VERSION to install (default is ${C_LGn}${python_version}${RES})"
		echo
		echo -e "${C_LGn}Useful URLs${RES}:"
		echo -e "https://github.com/SecorD0/utils/blob/main/python_installer.sh - script URL"
		echo -e "https://t.me/letskynode — node Community"
		echo
		return 0
		;;
	-v*|--version*)
		if ! grep -q "=" <<< "$1"; then shift; fi
		python_version=`option_value "$1"`
		shift
		;;
	*|--)
		break
		;;
	esac
done
# Actions
if ! python3 --version | grep -q "3.8.10"; then
	echo -e "${C_LGn}Installing Python...${RES}"
	sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev -y
	wget "https://www.python.org/ftp/python/${python_version}/Python-${python_version}.tgz"
	sudo rm -rf /usr/local/python
	sudo tar -C /usr/local -xzf "Python-${python_version}.tgz"
	rm "Python-${python_version}.tgz"
	sudo mv "/usr/local/Python-${python_version}" /usr/local/python
	cd /usr/local/python
	./configure --enable-optimizations
	make
	sudo make altinstall
	sudo apt install python3-pip -y 
	cd
fi
echo -e "${C_LGn}Done!${RES}"