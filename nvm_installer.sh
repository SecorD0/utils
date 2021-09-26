#!/bin/bash
# Default variables
nvm_version="0.38.0"
uninstall="false"
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
		echo -e "${C_LGn}Useful URLs${RES}:"
		echo -e "https://github.com/SecorD0/utils/blob/main/nvm_installer.sh - script URL"
		echo -e "https://t.me/letskynode — node Community"
		echo
		return 0
		;;
	-v*|--version*)
		if ! grep -q "=" <<< "$1"; then shift; fi
		nvm_version=`option_value "$1"`
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
	echo -e "${C_LGn}Uninstalling NVM...${RES}"
	rm -rf $NVM_DIR
	unset nvm
elif ! nvm --version | grep -q $nvm_version; then
	echo -e "${C_LGn}Installing NVM...${RES}"
	sudo apt install wget -y
	cd $HOME
	. <(wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/v${nvm_version}/install.sh")
	export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi
. $HOME/.bashrc
echo -e "${C_LGn}Done!${RES}"