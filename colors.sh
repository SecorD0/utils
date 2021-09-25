# Reset
RES='\033[0m'       # Reset format

# Base Characters
C_Bk='\033[0;30m'   # Black
C_R='\033[0;31m'    # Red
C_Gn='\033[0;32m'   # Green
C_Y='\033[0;33m'    # Yellow
C_Be='\033[0;34m'   # Blue
C_P='\033[0;35m'    # Purple
C_C='\033[0;36m'    # Cyan
C_Gy='\033[1;37m'   # Gray

# Light Characters
C_LR='\033[1;31m'   # Light Red
C_LGn='\033[1;32m'  # Light Green
C_LY='\033[1;33m'   # Light Yellow
C_LBe='\033[1;34m'  # Light Blue
C_LP='\033[1;35m'   # Light Purple
C_LC='\033[1;36m'   # Light Cyan
C_LGy='\033[0;37m'  # Light Gray

# Dark Characters
C_DBk='\033[2;30m'  # Dark Black
C_DR='\033[2;31m'   # Dark Red
C_DGn='\033[2;32m'  # Dark Green
C_DY='\033[2;33m'   # Dark Yellow
C_DBe='\033[2;34m'  # Dark Blue
C_DP='\033[2;35m'   # Dark Purple
C_DC='\033[2;36m'   # Dark Cyan
C_DGy='\033[2;37m'  # Dark Gray

# Underline Characters
U_Bk='\033[4;30m'   # Black
U_R='\033[4;31m'    # Red
U_Gn='\033[4;32m'   # Green
U_Y='\033[4;33m'    # Yellow
U_Be='\033[4;34m'   # Blue
U_P='\033[4;35m'    # Purple
U_C='\033[4;36m'    # Cyan
U_Gy='\033[4;37m'   # Gray

# Blinking Characters
Bl_Bk='\033[5;30m'  # Black
Bl_R='\033[5;31m'   # Red
Bl_Gn='\033[5;32m'  # Green
Bl_Y='\033[5;33m'   # Yellow
Bl_Be='\033[5;34m'  # Blue
Bl_P='\033[5;35m'   # Purple
Bl_C='\033[5;36m'   # Cyan
Bl_Gy='\033[5;37m'  # Gray

# Background
Ba_Bk='\033[40m'     # Black
Ba_R='\033[41m'      # Red
Ba_Gn='\033[42m'     # Green
Ba_Y='\033[43m'      # Yellow
Ba_Be='\033[44m'     # Blue
Ba_P='\033[45m'      # Purple
Ba_C='\033[46m'      # Cyan
Ba_Gy='\033[47m'     # Gray

# Options
option_value(){ echo $1 | sed -e 's%^--[^=]*=%%g; s%^-[^=]*=%%g'; }

while test $# -gt 0; do
	case "$1" in
	-h|--help)
		if [[ "${BASH_SOURCE[0]}" == "${BASH_SOURCE[-1]}" ]]; then
			. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/logo.sh)
			echo
			echo -e "${C_LGn}Functionality${RES}: the script assigns variables with colors to be used in the texts (e.g. in the 'echo' and 'printf' commands)"
			echo
			echo -e "${C_LGn}Usage${RES}: script ${C_LGn}[OPTIONS]${RES}"
			echo
			echo -e "${C_LGn}Options${RES}:"
			echo -e "  -h, --help  show help page"
			echo
			echo -e "${C_LGn}Colors${RES}:"
			echo -e "Reset - \${RES}"
			echo -e "┌─────────────────────────────┐  ┌─────────────────────────────┐"
			echo -e "│       Base Characters       │  │     Underline Characters    │"
			echo -e "├────────┬─────────┬──────────┤  ├────────┬─────────┬──────────┤"
			echo -e "│ Color  │ Example │ Variable │  │ Color  │ Example │ Variable │"
			echo -e "├────────┼─────────┼──────────┤  ├────────┼─────────┼──────────┤"
			echo -e "│ Black  │ ${C_Bk}Example${RES} │ \${C_Bk}  │  │ Black  │ ${U_Bk}Example${RES} │ \${U_Bk}  │"
			echo -e "│ Red    │ ${C_R}Example${RES} │ \${C_R}   │  │ Red    │ ${U_R}Example${RES} │ \${U_R}   │"
			echo -e "│ Green  │ ${C_Gn}Example${RES} │ \${C_Gn}  │  │ Green  │ ${U_Gn}Example${RES} │ \${U_Gn}  │"
			echo -e "│ Yellow │ ${C_Y}Example${RES} │ \${C_Y}   │  │ Yellow │ ${U_Y}Example${RES} │ \${U_Y}   │"
			echo -e "│ Blue   │ ${C_Be}Example${RES} │ \${C_Be}  │  │ Blue   │ ${U_Be}Example${RES} │ \${U_Be}  │"
			echo -e "│ Purple │ ${C_P}Example${RES} │ \${C_P}   │  │ Purple │ ${U_P}Example${RES} │ \${U_P}   │"
			echo -e "│ Cyan   │ ${C_C}Example${RES} │ \${C_C}   │  │ Cyan   │ ${U_C}Example${RES} │ \${U_C}   │"
			echo -e "│ Gray   │ ${C_Gy}Example${RES} │ \${C_Gy}  │  │ Gray   │ ${U_Gy}Example${RES} │ \${U_Gy}  │"
			echo -e "└────────┴─────────┴──────────┘  └────────┴─────────┴──────────┘"
			echo
			echo -e "┌─────────────────────────────┐  ┌─────────────────────────────┐"
			echo -e "│       Light Characters      │  │     Blinking Characters     │"
			echo -e "├────────┬─────────┬──────────┤  ├────────┬─────────┬──────────┤"
			echo -e "│ Color  │ Example │ Variable │  │ Color  │ Example │ Variable │"
			echo -e "├────────┼─────────┼──────────┤  ├────────┼─────────┼──────────┤"
			echo -e "│        │         │          │  │ Black  │ ${Bl_Bk}Example${RES} │ \${Bl_Bk} │"
			echo -e "│ Red    │ ${C_LR}Example${RES} │ \${C_LR}  │  │ Red    │ ${Bl_R}Example${RES} │ \${Bl_R}  │"
			echo -e "│ Green  │ ${C_LGn}Example${RES} │ \${C_LGn} │  │ Green  │ ${Bl_Gn}Example${RES} │ \${Bl_Gn} │"
			echo -e "│ Yellow │ ${C_LY}Example${RES} │ \${C_LY}  │  │ Yellow │ ${Bl_Y}Example${RES} │ \${Bl_Y}  │"
			echo -e "│ Blue   │ ${C_LBe}Example${RES} │ \${C_LBe} │  │ Blue   │ ${Bl_Be}Example${RES} │ \${Bl_Be} │"
			echo -e "│ Purple │ ${C_LP}Example${RES} │ \${C_LP}  │  │ Purple │ ${Bl_P}Example${RES} │ \${Bl_P}  │"
			echo -e "│ Cyan   │ ${C_LC}Example${RES} │ \${C_LC}  │  │ Cyan   │ ${Bl_C}Example${RES} │ \${Bl_C}  │"
			echo -e "│ Gray   │ ${C_LGy}Example${RES} │ \${C_LGy} │  │ Gray   │ ${Bl_Gy}Example${RES} │ \${Bl_Gy} │"
			echo -e "└────────┴─────────┴──────────┘  └────────┴─────────┴──────────┘"
			echo
			echo -e "┌─────────────────────────────┐  ┌─────────────────────────────┐"
			echo -e "│       Dark Characters       │  │         Background          │"
			echo -e "├────────┬─────────┬──────────┤  ├────────┬─────────┬──────────┤"
			echo -e "│ Color  │ Example │ Variable │  │ Color  │ Example │ Variable │"
			echo -e "├────────┼─────────┼──────────┤  ├────────┼─────────┼──────────┤"
			echo -e "│ Black  │ ${C_DBk}Example${RES} │ \${C_DBk} │  │ Black  │ ${Ba_Bk}Example${RES} │ \${Ba_Bk} │"
			echo -e "│ Red    │ ${C_DR}Example${RES} │ \${C_DR}  │  │ Red    │ ${Ba_R}Example${RES} │ \${Ba_R}  │"
			echo -e "│ Green  │ ${C_DGn}Example${RES} │ \${C_DGn} │  │ Green  │ ${Ba_Gn}Example${RES} │ \${Ba_Gn} │"
			echo -e "│ Yellow │ ${C_DY}Example${RES} │ \${C_DY}  │  │ Yellow │ ${Ba_Y}Example${RES} │ \${Ba_Y}  │"
			echo -e "│ Blue   │ ${C_DBe}Example${RES} │ \${C_DBe} │  │ Blue   │ ${Ba_Be}Example${RES} │ \${Ba_Be} │"
			echo -e "│ Purple │ ${C_DP}Example${RES} │ \${C_DP}  │  │ Purple │ ${Ba_P}Example${RES} │ \${Ba_P}  │"
			echo -e "│ Cyan   │ ${C_DC}Example${RES} │ \${C_DC}  │  │ Cyan   │ ${Ba_C}Example${RES} │ \${Ba_C}  │"
			echo -e "│ Gray   │ ${C_DGy}Example${RES} │ \${C_DGy} │  │ Gray   │ ${Ba_Gy}Example${RES} │ \${Ba_Gy} │"
			echo -e "└────────┴─────────┴──────────┘  └────────┴─────────┴──────────┘"
			echo
			echo -e "${C_LGn}Useful URLs${RES}:"
			echo -e "https://github.com/SecorD0/utils/blob/main/colors.sh - script URL"
			echo -e "https://t.me/letskynode — node Community"
			echo
		fi
		return 0
		;;
	*)
		break
		;;
	esac
done
