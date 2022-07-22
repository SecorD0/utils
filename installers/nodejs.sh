#!/bin/bash
# Default variables
function="install"
nodejs_version=`wget -qO- https://api.github.com/repos/nodejs/node/releases/latest | jq -r ".tag_name" | sed "s%v%%g"`

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
		echo -e "  -h,  --help             show the help page"
		echo -e "  -v,  --version VERSION  Node.js VERSION to install (default is ${C_LGn}${nodejs_version}${RES})"
		echo -e "  -un, --uninstall        uninstall Node.js"
		echo
		echo -e "You can use either \"=\" or \" \" as an option and value ${C_LGn}delimiter${RES}"
		echo
		echo -e "${C_LGn}Useful URLs${RES}:"
		echo -e "https://github.com/SecorD0/utils/blob/main/installers/nodejs.sh - script URL"
		echo -e "https://t.me/letskynode — node Community"
		echo -e "https://teletype.in/@letskynode — guides and articles"
		echo
		return 0 2>/dev/null; exit 0
		;;
	-v*|--version*)
		if ! grep -q "=" <<< "$1"; then shift; fi
		nodejs_version=`option_value "$1"`
		shift
		;;
	-u|-un|--uninstall)
		function="uninstall"
		shift
		;;
	*|--)
		break
		;;
	esac
done

# Functions
install() {
	echo -e "${C_LGn}Node.js installation...${RES}"
	if ! node --version | grep -q $nodejs_version; then
		. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/installers/nvm.sh)
		nvm install $nodejs_version
		nvm use $nodejs_version
	fi
}
uninstall() {
	echo -e "${C_LGn}Node.js uninstalling...${RES}"
	nvm deactivate
	nvm uninstall $nodejs_version
}

# Actions
$function
echo -e "${C_LGn}Done!${RES}"
