#!/bin/bash
# Default variables
go_version="1.16.5"
uninstall="false"
# Options
. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/colors.sh) --
option_value(){ echo "$1" | sed -e 's%^--[^=]*=%%g; s%^-[^=]*=%%g'; }
while test $# -gt 0; do
	case "$1" in
	-h|--help)
		. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/logo.sh)
		echo
		echo -e "${C_LGn}Functionality${RES}: the script installs or uninstalls GO"
		echo
		echo -e "${C_LGn}Usage${RES}: script ${C_LGn}[OPTIONS]${RES}"
		echo
		echo -e "${C_LGn}Options${RES}:"
		echo -e "  -h, --help             show the help page"
		echo -e "  -v, --version VERSION  GO VERSION to install (default is ${C_LGn}${go_version}${RES})"
		echo -e "  -u, --uninstall        uninstall GO"
		echo
		echo -e "You can use either \"=\" or \" \" as an option and value ${C_LGn}delimiter${RES}"
		echo
		echo -e "${C_LGn}Useful URLs${RES}:"
		echo -e "https://github.com/SecorD0/utils/blob/main/installers/golang.sh - script URL"
		echo -e "https://t.me/letskynode — node Community"
		echo
		return 0
		;;
	-v*|--version*)
		if ! grep -q "=" <<< "$1"; then shift; fi
		go_version=`option_value "$1"`
		shift
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
	echo -e "${C_LGn}Uninstalling GO...${RES}"
	sed -i "s%:`which go | sed 's%/bin/go%%g'`%%g" $HOME/.bash_profile
	rm -rf `which go | sed 's%/bin/go%%g'`
elif ! go version | grep -q $go_version; then
	echo -e "${C_LGn}Installing GO...${RES}"
	sed -i "s%:`which go | sed 's%/bin/go%%g'`%%g" $HOME/.bash_profile
	rm -rf `which go | sed 's%/bin/go%%g'`
	sudo apt install tar wget -y
	cd $HOME
	wget "https://golang.org/dl/go${go_version}.linux-amd64.tar.gz"
	sudo rm -rf /usr/local/go
	sudo tar -C /usr/local -xzf "go${go_version}.linux-amd64.tar.gz"
	rm "go${go_version}.linux-amd64.tar.gz"
	. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/miscellaneous/insert_variable.sh) -n "PATH" -v "$PATH:/usr/local/go/bin:$HOME/go/bin"
fi
. $HOME/.bash_profile
echo -e "${C_LGn}Done!${RES}"
