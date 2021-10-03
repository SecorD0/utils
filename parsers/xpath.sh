#!/bin/bash
# Default variables
xpath=""
url=""
file=""
is_text="false"
show_warnings="false"
type="HTML"
# Options
. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/colors.sh) --
option_value(){ echo "$1" | sed -e 's%^--[^=]*=%%g; s%^-[^=]*=%%g'; }
while test $# -gt 0; do
	case "$1" in
	-h|--help)
		. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/logo.sh)
		echo
		echo -e "${C_LGn}Functionality${RES}: the script parses HTML/XML pages via XPath"
		echo
		echo -e "${C_LGn}Usage${RES}: script ${C_LGn}[OPTIONS]${RES}"
		echo
		echo -e "${C_LGn}Options${RES}:"
		echo -e "  -h, --help            show the help page"
		echo -e "  -x, --xpath QUERY     XPath QUERY (${C_LGn}mandatory${RES})"
		echo -e "  -u, --url URL         parse the source code from URL"
		echo -e "  -f, --file FILE       parse the source code from FILE"
		echo -e "  -te, --text           parse the source code from \$test variable (${C_LGn}example of the variable is below${RES})"
		echo -e "  -ty, --type TYPE      parser TYPE. TYPE is '${C_LGn}HTML${RES}' (default), '${C_LGn}XML${RES}'"
		echo -e "  -sw, --show-warnings  show parser/validator warnings"
		echo
		echo -e "You can use either \"=\" or \" \" as an option and value ${C_LGn}delimiter${RES}"
		echo
		echo -e "\$test ${C_LGn}example:${RES}"
		echo -e "text=\""
		echo -e "<html>"
		echo -e "  <body>"
		echo -e "    <h1>Example</h1>"
		echo -e "  </body>"
		echo -e "</html>"
		echo -e "\""
		echo
		echo -e "${C_LGn}Useful URLs${RES}:"
		echo -e "https://github.com/SecorD0/utils/blob/main/parsers/xpath.sh - script URL"
		echo -e "https://t.me/letskynode — node Community"
		echo
		return 0
		;;
	-x*|--xpath*)
		if ! grep -q "=" <<< "$1"; then shift; fi
		xpath=`option_value "$1"`
		shift
		;;
	-u*|--url*)
		if ! grep -q "=" <<< "$1"; then shift; fi
		url=`option_value "$1"`
		shift
		;;
	-f*|--file*)
		if ! grep -q "=" <<< "$1"; then shift; fi
		file=`option_value "$1"`
		shift
		;;
	-te|--text)
		is_text="true"
		shift
		;;
	-sw|--show-warnings)
		show_warnings="true"
		shift
		;;
	-ty*|--type*)
		if ! grep -q "=" <<< "$1"; then shift; fi
		type=`option_value "$1"`
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
sudo apt install wget libxml2-utils -y &>/dev/null
if [ ! -n "$xpath" ]; then
	printf_n "${C_R}You didn't specify XPath via${RES} -x ${C_R}option!${RES}"
	return 1
fi
if [ ! -n "$url" ] && [ ! -n "$file" ] && [ "$is_text" = "false" ]; then
	printf_n "${C_R}You didn't specify where to parse the source code from! Use${RES} -h ${C_R}option to view the help page${RES}"
	return 1
fi
command=("xmllint")
[[ "$type" != "XML" ]] && command+=("--html")
command+=("--xpath \"${xpath}\"")
[[ "$show_warnings" = "false" ]] && command+=("--nowarning 2>/dev/null")
if [ -n "$url" ]; then
	source="- <<EOF
`wget -qO- $url`
EOF"
elif [ -n "$file" ]; then
	source="$file"
elif [ "$is_text" = "true" ]; then
	source="- <<EOF
$text
EOF"
fi
eval "${command[@]} ${source}"
unset xpath url file is_text show_warnings type