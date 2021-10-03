#!/bin/bash
# Options
. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/colors.sh) --
option_value(){ echo "$1" | sed -e 's%^--[^=]*=%%g; s%^-[^=]*=%%g'; }
while test $# -gt 0; do
	case "$1" in
	-h|--help)
		. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/logo.sh)
		echo
		echo -e "${C_LGn}Functionality${RES}: the script measures commands execution speed"
		echo
		echo -e "${C_LGn}Usage${RES}: script ${C_LGn}[OPTIONS]${RES} ${C_LGn}[ARGUMENTS]${RES}"
		echo
		echo -e "${C_LGn}Options${RES}:"
		echo -e "  -h, --help  show the help page"
		echo
		echo -e "${C_LGn}Arguments${RES} - any commands as strings separated by spaces. For example: \"df\" 'ls -la'"
		echo
		echo -e "${C_LGn}Useful URLs${RES}:"
		echo -e "https://github.com/SecorD0/utils/blob/main/miscellaneous/speed_test.sh - script URL"
		echo -e "https://t.me/letskynode — node Community"
		echo
		return 0
		;;
	*|--)
		break
		;;
	esac
done
# Actions
sudo apt install jq -y &>/dev/null
start=$(date +%s.%N)
for command in "$@"; do
	eval $command
	. $HOME/.bash_profile
	echo -e "The operation lasted ${C_LGn}`jq -n "$(date +%s.%N)-$start"`${RES} seconds\n"
done