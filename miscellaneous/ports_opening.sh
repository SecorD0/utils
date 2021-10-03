#!/bin/bash
# Options
. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/colors.sh) --
option_value(){ echo "$1" | sed -e 's%^--[^=]*=%%g; s%^-[^=]*=%%g'; }
while test $# -gt 0; do
	case "$1" in
	-h|--help)
		. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/logo.sh)
		echo
		echo -e "${C_LGn}Functionality${RES}: the script opens specified ports"
		echo
		echo -e "${C_LGn}Usage${RES}: script ${C_LGn}[OPTIONS]${RES} ${C_LGn}[ARGUMENTS]${RES}"
		echo
		echo -e "${C_LGn}Options${RES}:"
		echo -e "  -h, --help  show the help page"
		echo
		echo -e "${C_LGn}Arguments${RES} - any ports to open separated by spaces"
		echo
		echo -e "${C_LGn}Useful URLs${RES}:"
		echo -e "https://github.com/SecorD0/utils/blob/main/miscellaneous/ports_opening.sh - script URL"
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
echo -e "${C_LGn}Port(s) opening...${RES}"
if sudo ufw status | grep -q "Status: active"; then
	sudo ufw allow 22
	for port in "$@"; do
		sudo ufw allow "$port"
	done
else
	if ! dpkg --get-selections | grep -qP "(?<=iptables-persistent)([^de]+)(?=install)"; then
		echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
		echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
		sudo apt install iptables-persistent -y
	fi
	for port in "$@"; do
		sudo iptables -I INPUT -p tcp --dport "$port" -j ACCEPT
	done
	sudo netfilter-persistent save
fi
echo -e "${C_LGn}Done!${RES}"
