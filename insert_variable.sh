source ~/.bash_profile
if ! cat ~/.bash_profile | grep -q "$1"; then
	echo "export $1=$2" >> ~/.bash_profile && source ~/.bash_profile
elif ! cat ~/.bash_profile | grep -q "$2"; then
	sed -i "s/export $1*=.*/export $1=\"$2\"/" ~/.bash_profile
fi
source ~/.bash_profile
