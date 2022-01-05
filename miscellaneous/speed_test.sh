#!/bin/bash
# Default variables
total="false"

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
		echo -e "  -h, --help   show the help page"
		echo
		echo -e "${C_LGn}Arguments${RES} - any commands as strings separated by spaces. For example: \"df\" 'ls -la'"
		echo
		echo -e "${C_LGn}Useful URLs${RES}:"
		echo -e "https://github.com/SecorD0/utils/blob/main/miscellaneous/speed_test.sh - script URL"
		echo -e "https://t.me/letskynode — node Community"
		echo
		return 0 2>/dev/null; exit 0
		;;
	-t|--total)
		total="true"
		shift
		;;
	*|--)
		break
		;;
	esac
done

# Functions
printf_n(){ printf "$1\n" "${@:2}"; }
main() {
	sudo apt install bc -y &>/dev/null
	local commands_l=()
	local runtime_l=()
	for command in "$@"; do
		commands_l+=("$command")
	done
	for command in "$@"; do
		local command_start=$(date +%s.%N)
		eval $command
		. $HOME/.bash_profile
		runtime_l+=(`bc <<< "$(date +%s.%N)-$command_start"`)
	done
	printf_n "\n\n${C_LGn}Time taken (s)${RES}\t|  Command\n------------------------------------"
	local sum=0.00
	for ((i = 0; i < "${#commands_l[@]}"; i++)); do
		printf_n "${C_LGn}%f${RES}\t|  ${commands_l[$i]}" "${runtime_l[$i]}"
		local sum=`bc <<< "$sum+${runtime_l[$i]}"`
	done
	printf_n "${C_LGn}%f${RES}\t|  Total" "$sum"
}

# Actions
main "$@"