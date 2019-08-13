#!/bin/bash
if [ "$(id -u)" -ne 0 ]; then
	echo -ne "\nPlease execute this script as root.\n"
	exit 1; fi
if [ ! -f /etc/debian* ]; then
	echo -ne "\nFor Debian distro only.\n"
	exit 1; fi
export DEBIAN_FRONTEND=noninteractive

echo "[Unit]
Description=OpenVPN IP Table
Wants=network.target
After=network.target
DefaultDependencies=no
[Service]
ExecStart=/sbin/iptab
Type=oneshot
RemainAfterExit=yes
[Install]
WantedBy=network.target" > /etc/systemd/system/iptab.service
echo '#!/bin/bash
iptables -F
iptables -X
iptables -F -t nat
iptables -X -t nat
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE
iptables -A INPUT -j ACCEPT
iptables -A FORWARD -j ACCEPT
iptables -A INPUT -p tcp --dport 1194 -j ACCEPT
iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp -m state --state ESTABLISHED --sport 22 -j ACCEPT
iptables -A INPUT -p udp -m state --state ESTABLISHED --sport 53 -j ACCEPT
iptables -A OUTPUT -p udp -m state --state NEW,ESTABLISHED --dport 53 -j ACCEPT
iptables -A INPUT -p tcp -m state --state NEW,ESTABLISHED --dport 22 -j ACCEPT
iptables -t filter -A FORWARD -j REJECT --reject-with icmp-port-unreachable
sysctl -w net.ipv4.ip_forward=1
' > /sbin/iptab
chmod +x {/sbin/iptab,/etc/systemd/system/iptab.service}
systemctl daemon-reload

systemctl restart iptab
systemctl enable iptab

echo -ne "\nIP Tables script added.\n
Script by Dexter Cellona Banawon\n"

exit 0