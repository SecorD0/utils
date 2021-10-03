#!/bin/bash
# Default variables
token_symbol=""
round=""
multiplier=""
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
		echo -e "  -h,  --help                 show the help page"
		echo -e "  -ts, --token-symbol SYMBOL  SYMBOL of token to parse the price. E.g. ${C_LGn}BTC${RES}, ${C_LGn}eth${RES}, ${C_LGn}BnB${RES}"
		echo -e "  -m,  --multiplier NUMBER    NUMBER of tokens to calculate the product. You can separate the digits with the spacebar: ${C_LGn}\"1 000\"${RES}, ${C_LGn}\"100 000\"${RES}"
		echo -e "  -r,  --round NUMBER         round the value to NUMBER decimal places"
		echo
		echo -e "You can use either \"=\" or \" \" as an option and value ${C_LGn}delimiter${RES}"
		echo
		echo -e "${C_LGn}Useful URLs${RES}:"
		echo -e "https://github.com/SecorD0/utils/blob/main/parsers/token_price.sh - script URL"
		echo -e "https://github.com/SecorD0/utils/blob/main/databases/tokens.txt - token database"
		echo -e "https://t.me/letskynode — node Community"
		echo
		return 0 2>/dev/null; exit 0
		;;
	-ts*|--token-symbol*)
		if ! grep -q "=" <<< "$1"; then shift; fi
		token_symbol=`option_value "$1"`
		shift
		;;
	-m*|--multiplier*)
		if ! grep -q "=" <<< "$1"; then shift; fi
		multiplier=`option_value "$1"`
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
if [ ! -n "$token_symbol" ]; then
	printf_n "${C_R}You didn't specify a token symbol via${RES} -ts ${C_R}option!${RES}"
	return 1 2>/dev/null; exit 1
fi
if [ -n "$multiplier" ]; then
	multiplier=`echo "$multiplier" | tr -d ' ' | tr ',' '.'`
	if printf "%f" "$multiplier" &>/dev/null; then
		multiplier=`printf "%f" $multiplier`
	else
		printf_n "${C_R}The specified multiplier is not a number!${RES}"
		return 1 2>/dev/null; exit 1
	fi
fi
if [ -n "$round" ]; then
	if printf "%d" "$round" &>/dev/null; then
		round=`printf "%d" $round`
	else
		printf_n "${C_R}The specified number of decimal places is not a number!${RES}"
		return 1 2>/dev/null; exit 1
	fi
fi
project=`option_value "$(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/databases/tokens.txt | grep -P "\t${token_symbol^^}\t" | tr -d '\r' | awk -F "\t" '{print $4}')"`
if [ -n "$project" ]; then
	price=`. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/parsers/xpath.sh) -x "/html/body/script[1]/text()" -u "https://coinmarketcap.com/currencies/${project}/" | sed "s%<\!\[CDATA\[%%g; s%]]>%%g" | jq ".props.initialProps.pageProps.info.statistics.price"`
else
	price=`. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/parsers/xpath.sh) -x "/html/body/script[1]/text()" -u "https://coinmarketcap.com/currencies/${token_symbol}/" | sed "s%<\!\[CDATA\[%%g; s%]]>%%g" | jq ".props.initialProps.pageProps.info.statistics.price"`
fi
if [ -n "$price" ]; then
	if [ -n "$multiplier" ]; then
		sudo apt install bc -y &>/dev/null
		result=`bc -l <<< "$price*$multiplier"`
	else
		result="$price"
	fi
	if [ -n "$round" ]; then
		printf_n "%.${round}f" "$result"
	else
		printf_n "%f" "$result"
	fi
else
	printf_n "${C_R}There is no such token!${RES}"
	return 1 2>/dev/null; exit 1
fi
