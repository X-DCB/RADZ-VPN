#!/bin/bash
if [ "$(id -u)" -ne 0 ]; then
	echo -ne "\nPlease execute this script as root.\n"
	exit 1; fi
if [ ! -f /etc/debian* ]; then
	echo -ne "\nFor Debian distro only.\n"
	exit 1; fi
export DEBIAN_FRONTEND=noninteractive

radz="https://github.com/X-DCB/RADZ-VPN/raw/master"
dex="https://github.com/X-DCB/Unix/raw/master"
bash -c "$(wget -qO- $radz/dropbear.sh)"
bash -c "$(wget -qO- $radz/fail2ban.sh)"
bash -c "$(wget -qO- $radz/iptab.sh)"
bash -c "$(wget -qO- $radz/nginx.sh)"
bash -c "$(wget -qO- $radz/ovpn-install)"
bash -c "$(wget -qO- $radz/squid3.sh)"
bash -c "$(wget -qO- $radz/banner.sh)"
bash -c "$(wget -qO- $dex/badvpn.sh)"
bash -c "$(wget -qO- $dex/stunnel.sh)"
bash -c "$(wget -qO- $dex/scripts.sh)"
cp /root/client.ovpn /home/vps/public_html/

echo -ne "\nFinshed setting up components.\n
Script by Dexter Cellona Banawon\n"

echo 'Rebooting VPS...'
shutdown -r now

exit 0