#!/usr/bin/bash

fichier="$(cat ~/Documents/ip/ip15lignes)"
echo "" > resolv.txt
echo "" > no_resolv.txt
for i in $fichier;
do

dig_result=$(dig -x $i +short)

	if [ -z $dig_result ];then

		echo "not_resolv;$i" >>  ~/Documents/ip/no_resolv.txt


	else 

		echo "${dig_result:0:-1};$i" >>  ~/Documents/ip/resolv.txt

	fi	

done

echo "fin"
