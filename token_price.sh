#!/bin/bash
# Default variables
project=""
round=""
# Options
. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/colors.sh) --
option_value(){ echo "$1" | sed -e 's%^--[^=]*=%%g; s%^-[^=]*=%%g'; }
while test $# -gt 0; do
	case "$1" in
	-h|--help)
		. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/logo.sh)
		echo
		echo -e "${C_LGn}Functionality${RES}: the script parses a token price from CoinMarketCap page"
		echo
		echo -e "${C_LGn}Usage${RES}: script ${C_LGn}[OPTIONS]${RES}"
		echo
		echo -e "${C_LGn}Options${RES}:"
		echo -e "  -h, --help          show the help page"
		echo -e "  -p, --project NAME  NAME of project to parse the token price. E.g. ${C_LGn}bitcoin${RES}, ${C_LGn}streamr${RES}."
		echo -e "                      It's taken from a token page URL:"
		echo -e "                      https://coinmarketcap.com/currencies/${C_LGn}bitcoin${RES}/"
		echo -e "  -r, --round NUMBER  round the value to NUMBER decimal places"
		echo
		echo -e "You can use either \"=\" or \" \" as an option and value ${C_LGn}delimiter${RES}"
		echo
		echo -e "${C_LGn}Useful URLs${RES}:"
		echo -e "https://github.com/SecorD0/Solana/blob/main/token_price.sh - script URL"
		echo -e "https://t.me/letskynode — node Community"
		echo
		return 0 2>/dev/null; exit 0
		;;
	-p*|--project*)
		if ! grep -q "=" <<< "$1"; then shift; fi
		project=`option_value "$1"`
		shift
		;;
	-r*|--round*)
		if ! grep -q "=" <<< "$1"; then shift; fi
		round=`option_value "$1"`
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
sudo apt install wget jq -y &>/dev/null
if [ ! -n "$project" ]; then
	printf_n "${C_R}You didn't specify a project name via${RES} -p ${C_R}option!${RES}"
	return 1 2>/dev/null; exit 1
fi
if [ -n "$round" ]; then
	if printf "%d" "$round" &>/dev/null; then
		round=`printf "%d" $round`
	else
		printf_n "${C_R}The specified number of decimal places is not a number!${RES}"
		return 1 2>/dev/null; exit 1
	fi
fi
price=`. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/xpath.sh) -x "/html/body/script[1]/text()" -u "https://coinmarketcap.com/currencies/${project}/" | sed "s%<\!\[CDATA\[%%g; s%]]>%%g" | jq ".props.initialProps.pageProps.info.statistics.price"`
if [ -n "$price" ]; then
	if [ -n "$round" ]; then
		printf_n "%.${round}f" "$price"
	else
		printf_n "%f" "$price"
	fi
else
	printf_n "${C_R}There is no such project!${RES}"
	return 1 2>/dev/null; exit 1
fi
