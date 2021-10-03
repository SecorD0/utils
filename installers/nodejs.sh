#!/bin/bash
# Default variables
nodejs_version="14.17.5"
uninstall="false"
# Options
. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/colors.sh) --
option_value(){ echo "$1" | sed -e 's%^--[^=]*=%%g; s%^-[^=]*=%%g'; }
while test $# -gt 0; do
	case "$1" in
	-h|--help)
		. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/logo.sh)
		echo
		echo -e "${C_LGn}Functionality${RES}: the script installs or uninstalls Node.js"
		echo
		echo -e "${C_LGn}Usage${RES}: script ${C_LGn}[OPTIONS]${RES}"
		echo
		echo -e "${C_LGn}Options${RES}:"
		echo -e "  -h, --help             show the help page"
		echo -e "  -v, --version VERSION  Node.js VERSION to install (default is ${C_LGn}${nodejs_version}${RES})"
		echo -e "  -u, --uninstall        uninstall Node.js"
		echo
		echo -e "You can use either \"=\" or \" \" as an option and value ${C_LGn}delimiter${RES}"
		echo
		echo -e "${C_LGn}Useful URLs${RES}:"
		echo -e "https://github.com/SecorD0/utils/blob/main/installers/nodejs.sh - script URL"
		echo -e "https://t.me/letskynode — node Community"
		echo
		return 0 2>/dev/null; exit 0
		;;
	-v*|--version*)
		if ! grep -q "=" <<< "$1"; then shift; fi
		nodejs_version=`option_value "$1"`
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
	echo -e "${C_LGn}Uninstalling Node.js...${RES}"
	nvm deactivate
	nvm uninstall $nodejs_version
elif ! node --version | grep -q $nodejs_version; then
	echo -e "${C_LGn}Installing Node.js...${RES}"
	. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/installers/nvm_installer.sh)
	nvm install $nodejs_version
	nvm use $nodejs_version
fi
echo -e "${C_LGn}Done!${RES}"
