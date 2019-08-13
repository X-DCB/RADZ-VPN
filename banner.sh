#!/bin/bash
if [ "$(id -u)" -ne 0 ]; then
	echo -ne "\nPlease execute this script as root.\n"
	exit 1; fi
if [ ! -f /etc/debian* ]; then
	echo -ne "\nFor Debian distro only.\n"
	exit 1; fi
export DEBIAN_FRONTEND=noninteractive

cat > /etc/svrmsg << msg
Radz VPN Server Message
-Dexter Cellona Banawon
msg

chmod a+wr /etc/svrmsg
sed -i 's/#Banner.*/Banner \/etc\/svrmsg/g' /etc/ssh/sshd_config
sed -i 's/DROPBEAR_BANNER.*/DROPBEAR_BANNER="\/etc\/svrmsg"/g' /etc/default/dropbear

systemctl restart {ssh,dropbear}

echo -ne "\nServer message changed.\n
Script by Dexter Cellona Banawon\n"

exit 0