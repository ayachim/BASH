#!/usr/bin/sh
#ce script prend les adresse mac trouve releve sur le switch
#puis les comapre a un fichier nmap 10.41.0.0


echo "" > grep_corespond_ok
while read MAC
do
	mac_cisco="${MAC:0:12}"
	var1=$(cat rm_mac |grep -i $mac_cisco)
	if [ -z "$var1" ]
	then
	continue
	else

		var1=$(cat rm_mac |grep -i $mac_cisco)
		#tofile="Mac & port ;${MAC};Mac & Ip & vendor;${var1}"

		host_ip=$(host $(echo $var1 |cut -d";" -f1))

		tofile="MAC :${MAC:0:12} port : ${MAC:13:50} ip: $(echo $var1 |cut -d";" -f1) mac : $(echo $var1 |cut -d";" -f2) ${host_ip}"
		echo "${tofile}" >> grep_corespond_ok

	fi

done < mac_cisco2


