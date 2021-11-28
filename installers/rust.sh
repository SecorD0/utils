#!/bin/bash
# Default variables
function="install"
nightly="false"

# Options
. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/colors.sh) --
option_value(){ echo "$1" | sed -e 's%^--[^=]*=%%g; s%^-[^=]*=%%g'; }
while test $# -gt 0; do
	case "$1" in
	-h|--help)
		. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/logo.sh)
		echo
		echo -e "${C_LGn}Functionality${RES}: the script installs or uninstalls Rust"
		echo
		echo -e "${C_LGn}Usage${RES}: script ${C_LGn}[OPTIONS]${RES}"
		echo
		echo -e "${C_LGn}Options${RES}:"
		echo -e "  -h, --help       show the help page"
		echo -e "  -n, --nightly    install nightly version of Rust"
		echo -e "  -u, --uninstall  uninstall Rust"
		echo
		echo -e "${C_LGn}Useful URLs${RES}:"
		echo -e "https://github.com/SecorD0/utils/blob/main/installers/rust.sh - script URL"
		echo -e "https://t.me/letskynode — node Community"
		echo
		return 0 2>/dev/null; exit 0
		;;
	-n|--nightly)
		nightly="true"
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
	echo -e "${C_LGn}Rust installation...${RES}"
	sudo apt install curl build-essential pkg-config libssl-dev libudev-dev clang make -y
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	echo -e "${C_R}^ Don't do that ^${RES}\n"
	. $HOME/.cargo/env
	if [ "$nightly" = "true" ]; then
		rustup toolchain install nightly
		rustup default nightly
	fi
}
uninstall() {
	echo -e "${C_LGn}Rust uninstalling...${RES}"
	rustup self uninstall -y
}

# Actions
$function
echo -e "${C_LGn}Done!${RES}"
