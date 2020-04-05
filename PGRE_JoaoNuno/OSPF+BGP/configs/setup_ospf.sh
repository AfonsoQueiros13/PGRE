#!/usr/bin/expect
echo "--- Ola Mestre ---"
set timeout 20

nove="9"
um="1"
dois="2"
zero="0"

read -p "Qual é a bancada: " bancada

read -p "Primeiro vizinho: " vizinho1
read -p "Segundo vizinho: " vizinho2


router="$bancada$nove"
switch="$bancada$zero"
as="6500$bancada"

vlan1="172.16.$bancada$um.0"
vlan2="172.16.$bancada$dois.0"

as_vizinho_1="6500$vizinho1"
as_vizinho_2="6500$vizinho2"

#vizinhos 
if [ "$bancada" -gt "$vizinho1"  ]; then
    hop_prenumber=$vizinho1$bancada
	hop=$((hop_prenumber*4 + 1)) 
else
	hop_prenumber=$bancada$vizinho1
	hop=$((hop_prenumber*4 + 2))
fi

if [ "$bancada" -gt "$vizinho2" ]; then
    hop_prenumber2=$vizinho2$bancada
	hop2=$((hop_prenumber2*4 + 1))
else
	hop_prenumber2=$bancada$vizinho2
	hop2=$((hop_prenumber2*4 + 2)) 
fi

 


echo "ligacao1 $hop_prenumber  -> 192.168.1.$hop" 
echo "ligacao2 $hop_prenumber2 -> 192.168.1.$hop2"

(
	echo "root"
	sleep 1
	echo "8nortel"
	sleep 1
	echo "conf t"
	sleep 1
	echo "no router ospf 1"
	sleep 1
	echo "router ospf 1"
	sleep 1
	echo "router-id 172.16.2.$router"
	sleep 1		
	echo "end"
	sleep 1
	echo "conf t"
	sleep 1
	echo "! Criar Processo BGP"
	echo "no router bgp $as"
	sleep 1
	echo "router bgp $as"
	sleep 1
	echo "no synchronization"
	sleep 1
	echo "! Adicionar vizinhos"
	echo "neighbor 192.168.1.$hop remote-as $as_vizinho_1"
	sleep 1
	echo "neighbor 192.168.1.$hop2 remote-as $as_vizinho_2"
	echo "network $vlan1 mask 255.255.255.0"
	sleep 1
	echo "network $vlan2 mask 255.255.255.0"
	sleep 1
	echo "end"


) | telnet 172.16.2.$router
echo "--- Adeus Mestre ---"
