#!/bin/bash
if [ "$(id -u)" -ne 0 ]; then
	echo -ne "\nPlease execute this script as root.\n"
	exit 1; fi
if [ ! -f /etc/debian* ]; then
	echo -ne "\nFor Debian distro only.\n"
	exit 1; fi
export DEBIAN_FRONTEND=noninteractive

apt-get -y install ruby
gem install lolcat
apt-get -y install fail2ban
service fail2ban restart

echo -ne "\nFail2Ban installed.\n
Script by Dexter Cellona Banawon\n"

exit 0