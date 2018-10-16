#! /bin/bash

#le plus grand nombre

echo "Entrez 3 nombres, je vous dirais le plus grand des 3"
echo "nombre 1 ?"
read nb 

echo "nombre 2 ?"
read nb2 

echo "nombre 3 ?"
read nb3

if [ $nb -gt $nb3 ] && [ $nb -gt $nb2 ];then
echo "$nb plus grand"
fi

if [ $nb2 -gt $nb ] && [ $nb2 -gt $nb3 ];then
echo "$nb2 plus grand"
fi

if [ $nb3 -gt $nb ] && [ $nb3 -gt $nb2 ];then
echo "$nb3 plus grand"
else 
	echo " ils sont egaux"

fi


