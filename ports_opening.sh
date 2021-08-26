# $@ - any number of ports with a space
#!/bin/bash
if sudo ufw status | grep -q "Status: active"; then
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