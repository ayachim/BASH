#!/usr/bin/sh
#ce script prend les adresse mac trouve releve sur le switch
#puis les comapre a un fichier nmap 10.41.0.0

echo "MAC; port; vlan;ip;info;fqdn " >resultat_sw01.csv
while read MAC
do
        vlan=$(echo $MAC |cut -d";" -f1)
        port=$(echo $MAC |cut -d";" -f3)
        mac=$(echo $MAC |cut -d";" -f2)
        var1=$(cat rm_mac2 |grep -i $mac)
        if [ -z "$var1" ]
        then
        continue
        else
        echo $port
        desc_eth=$(sshpass -p '&' ssh swpfs-5410-01 show interface description \| incl $port)
        echo $desc_eth


                host_ip=$(host $(echo $var1 |cut -d";" -f1))

                tofile="$mac; $port;$vlan; $(echo $var1 |cut -d";" -f1);$(echo $var1 |cut -d";" -f2); ${host_ip}"
                echo "${tofile}" >> resultat_sw01.csv

        fi

done < mac_cisco


