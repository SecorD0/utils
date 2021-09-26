#!/bin/bash
# Default variables
name=""
value=""
type="export"
rename=""
delete="false"
# Options
. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/colors.sh) --
option_value(){ echo "$1" | sed -e 's%^--[^=]*=%%g; s%^-[^=]*=%%g'; }
while test $# -gt 0; do
	case "$1" in
	-h|--help)
		. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/logo.sh)
		echo
		echo -e "${C_LGn}Functionality${RES}: the script inserts variable or alias to ${C_LGn}$HOME/.bash_profile${RES}"
		echo
		echo -e "${C_LGn}Usage${RES}: script ${C_LGn}[OPTIONS]${RES}"
		echo
		echo -e "${C_LGn}Options${RES}:"
		echo -e "  -h, --help           show the help page"
		echo -e "  -n, --name NAME      variable or alias NAME (mandatory)"
		echo -e "  -v, --value VALUE    variable or alias VALUE (leave blank for manual input)"
		echo -e "  -a, --alias          inserting an alias"
		echo -e "  -r, --rename NAME_2  rename NAME_2 to NAME"
		echo -e "  -d, --delete         delete variable or alias by NAME"
		echo
		echo -e "You can use either \"=\" or \" \" as an option and value ${C_LGn}delimiter${RES}"
		echo
		echo -e "${C_LGn}Useful URLs${RES}:"
		echo -e "https://github.com/SecorD0/utils/blob/main/insert_variable.sh - script URL"
		echo -e "https://t.me/letskynode — node Community"
		echo
		return 0
		;;
	-n*|--name*)
		if ! grep -q "=" <<< "$1"; then shift; fi
		name=`option_value "$1"`
		shift
		;;
	-v*|--value*)
		if ! grep -q "=" <<< "$1"; then shift; fi
		value=`option_value "$1"`
		shift
		;;
	-a|--alias)
		type="alias"
		shift
		;;
	-r*|--rename*)
		if ! grep -q "=" <<< "$1"; then shift; fi
		rename=`option_value "$1"`
		shift
		;;
	-d|--delete)
		delete="true"
		shift
		;;
	*|--)
		break
		;;
	esac
done
# Functions
printf_n(){ printf "$1\n" "${@:2}"; }
# Actions
touch $HOME/.bash_profile
. $HOME/.bash_profile
if [ ! -n "$name" ]; then
	printf_n "${C_R}You didn't specify a name via${RES} -n ${C_R}option!${RES}"
	return 1
fi
if [ "${delete}" = "true" ]; then
	sed -i "/ ${name}=/d" $HOME/.bash_profile
	unset "$name"
	unalias "$name" 2>/dev/null
else
	if [ ! -n "${value}" ]; then
		printf "${C_LGn}Enter the value:${RES} "
		read value
	fi
	if [ -n "${rename}" ]; then
		sed -i "s%${rename}%${name}%" $HOME/.bash_profile
		unset "$rename"
		unalias "$rename" 2>/dev/null
	fi
	if ! cat $HOME/.bash_profile | grep -q " ${name}="; then
		echo "${type} ${name}=\"${value}\"" >> $HOME/.bash_profile
	elif ! cat $HOME/.bash_profile | grep -q "${name}=\"${value}\""; then
		sed -i "s%^.*${name}*=.*%${type} ${name}=\"${value}\"%" $HOME/.bash_profile
	fi
	if cat $HOME/.bash_profile | grep -q "${name}=\"${value}\""; then
		sed -i "s%^.*${name}*=.*%${type} ${name}=\"${value}\"%" $HOME/.bash_profile
	fi
fi
. $HOME/.bash_profile
