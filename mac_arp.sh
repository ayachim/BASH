#!/usr/bin/sh
#ce script prend les adresse mac trouve releve sur le switch
#puis les comapre a un fichier nmap 10.41.0.0


echo "" > resultat_mac
while read MAC
do
	mac_cisco="${MAC:0:12}"
	var1=$(cat arp_total |grep -i $mac_cisco)
	if [ -z "${var1}" ]
	then
	continue
	else

		grepnmap=$(cat arp_total |grep -i $mac_cisco)
		tofile="${grepnmap} : ${MAC}"

		echo "${tofile}" >> resultat_mac

	fi
       echo ""  >>resultat_mac
	var1=$(cat testt |grep -i $mac_cisco)
        if [ -z "$var1" ]
        then
        continue
        else

                grepnmap=$(cat testt |grep -i -B 1  $mac_cisco)
                tofile="${grepnmap:0:95}: ${MAC}"

                echo "${tofile}" >>resultat_mac

        fi

       echo ""  >>resultat_mac
done < mac_cisco2

