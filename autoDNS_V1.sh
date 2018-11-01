
#!/bin/bash

#automatiser creation de zone dns

###############################
#read -p "nom de domaine" nom_dom
#read -p "l'adresse ip machine" ipm
nom_dom=$1
ipm=$$2

ip4=$(echo $ipm |cut -d"." -f4)
ip3=$(echo $ipm |cut -d"." -f3)
ip2=$(echo $ipm |cut -d"." -f2)
ip1=$(echo $ipm |cut -d"." -f1)
nm=/etc/bind/db.$nom_dom
ip=$ip1.$ip2.$ip3.$ip4
ipinv=$ip3.$ip2.$ip1
###############################
if     [ -f !$nm  ]  ;then
	echo "Les fichiers existent"

else
	echo "n'existent pas"	
	echo "zone \"$nom_dom\" IN {
	type master;
	file \"/etc/bind/db.$nom_dom\";
	};">>/etc/bind/named.conf.local

	echo "zone \"$ipinv.in-addr.arpa\" {
		type master;
		notify no;
		file \"/etc/bind/db.$ipinv\";
	};">>/etc/bind/named.conf.local

	echo ";
; BIND data file for local loopback interface
;
\$TTL	604800
@	IN	SOA	ns.$nom_dom. admin.$nom_dom. (
			      2		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
;
@	IN	NS	ns.$nom_dom.
NS	IN	A	$ipm
www	IN	A	$ipm
">/etc/bind/db.$nom_dom
#########" inverse ##############
        echo ";
; BIND data file for local loopback interface
;
\$TTL   604800
@       IN      SOA     ns.$nom_dom. admin.$nom_dom. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ns.$nom_dom.
$ip4    IN      PTR     $nom_dom.
">/etc/bind/db.$ipinv


fi

service bind9 restart
named-checkzone mous.fr /etc/bind/db.mous.fr
named-checkconf /etc/bind/named.conf.local


#vérifier si bind9 lancé :
bind9=$(service --status-all |grep bind |cut -d" " -f3)
echo $bind9
if [ $bind9 == "-" ];then
        echo " service OFF"
else
        echo "service ON"
fi










