#!/bin/bash
# Default variables
function="install"

# Options
. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/colors.sh) --
option_value(){ echo "$1" | sed -e 's%^--[^=]*=%%g; s%^-[^=]*=%%g'; }
while test $# -gt 0; do
	case "$1" in
	-h|--help)
		. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/logo.sh)
		echo
		echo -e "${C_LGn}Functionality${RES}: the script installs or uninstalls MySQL"
		echo
		echo -e "${C_LGn}Usage${RES}: script ${C_LGn}[OPTIONS]${RES}"
		echo
		echo -e "${C_LGn}Options${RES}:"
		echo -e "  -h, --help       show the help page"
		echo -e "  -u, --uninstall  uninstall MySQL (${C_R}completely delete all databases${RES})"
		echo
		echo -e "${C_LGn}Useful URLs${RES}:"
		echo -e "https://github.com/SecorD0/utils/blob/main/installers/mysql.sh - script URL"
		echo -e "https://t.me/letskynode — node Community"
		echo
		return 0 2>/dev/null; exit 0
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
	echo -e "${C_LGn}MySQL installation...${RES}"
	sudo apt update
	sudo apt upgrade -y
	sudo apt install mysql-server mysql-client -y
	echo -e "
Execute it to continue the installation:
${C_LGn}sudo mysql_secure_installation${RES}
"
}
uninstall() {
	echo -e "${C_LGn}MySQL uninstalling...${RES}"
	sudo systemctl stop mysql
	sudo killall -KILL mysql mysqld_safe mysqld
	sudo apt -y purge mysql-server mysql-client
	sudo apt -y autoremove --purge
	sudo apt autoclean
	deluser --remove-home mysql
	sudo delgroup mysql
	rm -rf /etc/apparmor.d/abstractions/mysql /etc/apparmor.d/cache/usr.sbin.mysqld /etc/mysql /var/lib/mysql /var/log/mysql* /var/log/upstart/mysql.log* /var/run/mysqld
	sudo find / -name .mysql_history -delete
	echo -e "${C_LGn}Done!${RES}"
}

# Actions
$function
