if [ -n "$3" ]; then
	var_or_com="alias"
else
	var_or_com="export"
fi
. ~/.bash_profile
if ! cat ~/.bash_profile | grep -q "$1"; then
	echo "$var_or_com $1=\"$2\"" >> ~/.bash_profile
elif ! cat ~/.bash_profile | grep -q "$1=\"$2\""; then
	sed -i "s/$var_or_com $1*=.*/$var_or_com $1=\"$2\"/" ~/.bash_profile
fi
. ~/.bash_profile
