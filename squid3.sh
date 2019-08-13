#!/bin/bash
if [ "$(id -u)" -ne 0 ]; then
	echo -ne "\nPlease execute this script as root.\n"
	exit 1; fi
if [ ! -f /etc/debian* ]; then
	echo -ne "\nFor Debian distro only.\n"
	exit 1; fi
export DEBIAN_FRONTEND=noninteractive

if [[ ! `type -P docker` ]]; then
apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common -y
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - 
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt update
apt-cache policy docker-ce
apt install docker-ce -y
apt clean; fi

export sqx=n
[ `type -P dcomp` ] || wget "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -qO /sbin/dcomp
chmod +x /sbin/dcomp || return

yml="https://github.com/X-DCB/RADZ-VPN/raw/master/squid3.yaml"
wget $yml -qO- | dcomp -f - down
mkdir /etc/squid3 2> /dev/null
wget https://raw.githubusercontent.com/X-DCB/SmartDNS-one/master/squid.conf -qO /etc/squid3/squid.conf
wget $yml -qO- | dcomp -f - up -d

echo -ne "\nSquid 3.1.23 installed.\n
Script by Dexter Cellona Banawon\n"

exit 0