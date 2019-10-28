#!/usr/bin/bash


fichier="$(cat ~/Documents/nom/nom15lignes)"
echo "" > resolv.txt
echo "" > no_resolv.txt
for i in $fichier;
do
	hostfqdn=$(host $i)
	if  [[ "${hostfqdn:(-1)}" =~ ^[0-9]+$ ]];then
		sav1=$(echo $hostfqdn|cut -d" " -f4) 
		echo "$i;$sav1" >> no_resolv.txt 
	else
		sav2=$(echo $hostfqdn|cut -d" " -f1-4) 
		echo "$i;$sav2" >> resolv.txt


	fi

done

