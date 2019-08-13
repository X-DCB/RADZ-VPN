#!/bin/bash
if [ "$(id -u)" -ne 0 ]; then
	echo -ne "\nPlease execute this script as root.\n"
	exit 1; fi
if [ ! -f /etc/debian* ]; then
	echo -ne "\nFor Debian distro only.\n"
	exit 1; fi
export DEBIAN_FRONTEND=noninteractive

apt install -y nginx
web="https://github.com/X-DCB/Unix/raw/master/openvpn"
wget $web/nginx.conf -qO /etc/nginx/nginx.conf
wget $web/vps.conf -qO- | sed -e 's/\/var\/www\/html/\/home\/vps\/public_html/g' > /etc/nginx/conf.d/vps.conf
mkdir -p /home/vps/public_html
echo "<pre>Setup by Dexter Cellona Banawon @ Radz VPN Community</pre>" > /home/vps/public_html/index.html

systemctl restart nginx

echo -ne "\nStunnel installed.\n
Script by Dexter Cellona Banawon\n"

exit 0