#!/bin/bash
echo " #script pour tester la validité des ips et fqdn #par rapport ce qui est référencé sur DALI"
echo " "
val="$(cat test_ping3)"
echo "">fqdn.nok
echo "">ip.nok
echo "$(date)"
for i in $val;
do
	IFS=';' read -ra ADDR <<< "$i"
	
	
fqdn="${ADDR[0]}"
ip="${ADDR[1]}"
pingfqdn="$(ping -q  -W 1 -c  1 $fqdn )"
pingip="$(ping -q  -W 1 -c  1 $ip )"
dig="$(dig -x $ip +short)"	
if [[ -z $dig  ]]; then
echo "dig vide"
else 
dig="${dig:0:-1}"
fi


#fonction de verification d'ip UP
verifIP() {

xip=$(echo "$1" |grep transmitted  |cut -d" " -f4)

if [ "${xip}" != 1 ];then
	return 0
	else 
	return 1
fi
}

if verifIP $pingip ;then
	echo "ecrire dans un fichier que ip est UP"
else 

	echo "ecrire dans un fichier que l ip est down $ip"
	echo "$ip">>ipdown
fi


if verifIP $pingfqdn ;then
	echo  " fqdn up"

		pingfqdn2=$(echo $pingfqdn |grep PING | cut -d" " -f3)

                if [ ${ip} != ${pingfqdn2:1:-1} ];then
                        echo "ip recue ( ${pingfqdn2:1:-1} ) lors du ping ne correspond pas à l'ip enrigstrée dans dali ( $ip )"
                	echo "$ip" >> necorrespondpasIPfqdn
			else
                        echo "ip recue ( ${pingfqdn2:1:-1} ) lors du ping  correspond bien à l'ip enrigstrée dans dali ( $ip )"
			

                fi


else 
	echo " ecrire dans un fichier que l ip est down $fqdn"
fi





: '

"requete ping fqdn:"
echo  "$pingfqdn"
echo " "
echo "requete ping ip:"
echo "$pingip"
echo " requete dig :"
echo "$dig"

echo " ############################ "
'
done
