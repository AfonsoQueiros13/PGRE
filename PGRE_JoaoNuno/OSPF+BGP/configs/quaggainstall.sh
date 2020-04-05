#!/bin/bash

nove="9"
zero="0"
um="1"
dois="2"
tres="3"

while getopts "b:p:" opt; do
    case ${opt} in
	
    b)  bancada="${OPTARG}"
        ;;
    p)  pc="${OPTARG}"
        ;;
    esac
done

echo "pc = "
echo $pc
echo "bancada = "
echo $bancada

gnu1="$bancada$um"
gnu2="$bancada$dois"
gnu3="$bancada$tres"

MACHINE_TYPE=`uname -m`
PACKAGE=quagga_0.99.23.1-1+deb8u5

dpkg --purge quagga



if [ "${MACHINE_TYPE}" = "x86_64" ]; then
	echo "--- SOU DE 64 ---"
	dpkg -i ./${PACKAGE}_amd64.deb 
else
	echo "--- SOU DE 32 ---"
	dpkg -i ./${PACKAGE}_i386.deb 
fi

mv /etc/quagga/daemons /etc/quagga/daemons.backup

echo "zebra=yes
bgpd=yes 
ospfd=yes
spf6d=no 
ripd=no
ipngd=no" > /etc/quagga/daemons

/etc/init.d/quagga restart

echo "! Sample
!
! service integrated-vtysh-config
hostname quagga-router
username root nopassword
!
" > /etc/quagga/vtysh.conf

cp /usr/share/doc/quagga/examples/zebra.conf.sample /etc/quagga/zebra.conf
cp /usr/share/doc/quagga/examples/ospfd.conf.sample /etc/quagga/ospfd.conf 
cp /usr/share/doc/quagga/examples/bgpd.conf.sample /etc/quagga/bgpd.conf 

chown quagga.quaggavty /etc/quagga/*.conf
chmod 640 /etc/quagga/*.conf

/etc/init.d/quagga restart

echo 1 > /proc/sys/net/ipv4/ip_forward

if [ "$pc" = "1" ]
then
	(
		echo "conf t"
		sleep 1
		echo "interface eth0"
		sleep 1
		echo "description link to Cisco router"
		sleep 1
		echo "ip address 172.16.$gnu1.1/24"
		sleep 1
		echo "link-detect"
		sleep 1
		echo "router-id 172.16.$gnu1.1"
		sleep 1
		echo "router ospf"
		sleep 1
		echo "network 172.16.$gnu1.0/24 area 0"
		sleep 1
		echo "exit"
		sleep 1
	) | vtysh
fi

if [ "$pc" = "2" ]; then
(
	echo "configure terminal"
	sleep 1
	echo "interface eth0"
	sleep 1
	echo "description link to Cisco router"
	sleep 1
	echo "ip address 172.16.$gnu1.2/24"
	sleep 1
	echo "link-detect"
	sleep 1
	echo "interface eth1"
	sleep 1
	echo "description link to Cisco router"
	sleep 1
	echo "ip address 172.16.$gnu2.2/24"
	sleep 1
	echo "link-detect"
	sleep 1
	echo "router-id 172.16.51.2"
	sleep 1
	echo "router ospf"
	sleep 1
	echo "network 172.16.$gnu1.0/24 area 0"
	sleep 1
	echo "network 172.16.$gnu2.0/24 area 0"
	sleep 1
	echo "exit"
	sleep 1
) | vtysh
fi

if [ "$pc" = "3" ]; then
(
	echo "conf t"
	sleep 1
	echo "interface eth0"
	sleep 1
	echo "description link to Cisco router"
	sleep 1
	echo "ip address 172.16.$gnu2.3/24"
	sleep 1
	echo "link-detect"
	sleep 1
	echo "outer-id 172.16.$gnu2.3"
	sleep 1
	echo "end"
	sleep 1
	echo "router ospf"
	sleep 1
	echo "network 172.16.$gnu2.0/24 area 0"
	sleep 1
	echo "exit"
	sleep 1
) | vtysh
fi

echo "--------FIM---------"
