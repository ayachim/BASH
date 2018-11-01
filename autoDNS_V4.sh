
#!/bin/bash

#automatiser creation de zone dns

###############################
#read -p "nom de domaine" nom_dom
#read -p "l'adresse ip machine" ipm

nom_dom=$1
ipm=$2
nom_domSlave=$3
ipmSlave=$4

ip4=$(echo $ipm |cut -d"." -f4)
ip3=$(echo $ipm |cut -d"." -f3)
ip2=$(echo $ipm |cut -d"." -f2)
ip1=$(echo $ipm |cut -d"." -f1)


ips4=$(echo $ipmSlave |cut -d"." -f4)
ips3=$(echo $ipmSlave |cut -d"." -f3)
ips2=$(echo $ipmSlave |cut -d"." -f2)
ips1=$(echo $ipmSlave |cut -d"." -f1)

nm=/etc/bind/db.$nom_dom
ipinv=$ip3.$ip2.$ip1
ipinvSlave=$ips3.$ips2.$ips1
###############################

if     [ -f $nm  ]  ;then
	echo "Les fichiers existent"

else
	
	echo "n'existent pas, creation de zone DNS..."	
	
	#config du host
	echo "# The \"order\" line is only used by old versions of the C library.
		order hosts,bind
		multi on">/etc/host.conf
	##############################
	echo "
	
	zone \"$nom_dom\" { 	
	type master; 			
	file \"/etc/bind/db.$nom_dom\"; 
	allow-transfer { $ipmSlave; };
	};

	zone \"$ipinv.in-addr.arpa\" {
	type master;
	file \"/etc/bind/db.$ipinv\";
	notify no;
	allow-transfer { $ipmSlave};
	};
	
	">>/etc/bind/named.conf.local
	
	#########################################
	echo "
	;
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


	####################### Slave ##################"
	if [ -f $nom_domSlave -a -f $ipmSlave ];then
	
	echo "Les parametres d'esclave absents, creation de zone esclave..."
	else
	
	
	echo "
	
	zone \"$nom_domSlave\" { 	
	type slave; 			
	file \"/var/cache/bind/db.$nom_domSlave\"; 
	masters { $ipmSlave; };
		
	};

	//zone \"$ipinvSlave.in-addr.arpa\" {
	//type slave;
	//file \"/var/cache/bind/db.$nom_domSlave\"; 
	//masters { $ipmSlave; };
	//};
	
	">>/etc/bind/named.conf.local
	
		echo "creation esclave"
	
fi

	fi
	
echo "redemarrage bind9"

service bind9 restart

#named-checkzone mous.fr /etc/bind/db.mous.fr
#named-checkconf /etc/bind/named.conf.local


#vérifier si bind9 lancé :
bind9=$(service --status-all |grep bind |cut -d" " -f3)
echo $bind9
if [ $bind9 == "-" ];then
        echo " service OFF"
else
        echo "service ON"
fi










