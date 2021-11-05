#!/bin/bash
# Default variables
function="install"
nvm_version="0.38.0"

# Options
. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/colors.sh) --
option_value(){ echo "$1" | sed -e 's%^--[^=]*=%%g; s%^-[^=]*=%%g'; }
while test $# -gt 0; do
	case "$1" in
	-h|--help)
		. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/logo.sh)
		echo
		echo -e "${C_LGn}Functionality${RES}: the script installs or uninstalls NVM"
		echo
		echo -e "${C_LGn}Usage${RES}: script ${C_LGn}[OPTIONS]${RES}"
		echo
		echo -e "${C_LGn}Options${RES}:"
		echo -e "  -h, --help             show the help page"
		echo -e "  -v, --version VERSION  NVM VERSION to install (default is ${C_LGn}${nvm_version}${RES})"
		echo -e "  -u, --uninstall        uninstall NVM"
		echo
		echo -e "You can use either \"=\" or \" \" as an option and value ${C_LGn}delimiter${RES}"
		echo
		echo -e "${C_LGn}Useful URLs${RES}:"
		echo -e "https://github.com/SecorD0/utils/blob/main/installers/nvm.sh - script URL"
		echo -e "https://t.me/letskynode — node Community"
		echo
		return 0 2>/dev/null; exit 0
		;;
	-v*|--version*)
		if ! grep -q "=" <<< "$1"; then shift; fi
		nvm_version=`option_value "$1"`
		shift
		;;
	-u|--uninstall)
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
	echo -e "${C_LGn}NVM installation...${RES}"
	if ! nvm --version | grep -q $nvm_version; then
		sudo apt install wget -y
		cd $HOME
		. <(wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/v${nvm_version}/install.sh")
		export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
		[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
	fi
}
uninstall() {
	echo -e "${C_LGn}Uninstalling NVM...${RES}"
	rm -rf $NVM_DIR
	sed -i "/NVM_DIR/d" $HOME/.bashrc
	unset nvm
}

# Actions
$function
. $HOME/.bashrc
echo -e "${C_LGn}Done!${RES}"
