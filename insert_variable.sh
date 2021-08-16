if [ -n "$3" ]; then
	is_command="alias"
else
	is_command="export"
fi
. ~/.bash_profile
if ! cat ~/.bash_profile | grep -q "$1"; then
	echo "$is_command $1=\"$2\"" >> ~/.bash_profile
elif ! cat ~/.bash_profile | grep -q "$1=\"$2\""; then
	sed -i "s/$is_command $1*=.*/$is_command $1=\"$2\"/" ~/.bash_profile
fi
. ~/.bash_profile
