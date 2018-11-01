#! /bin/bash

		#demande de note

read -p "Donnez votre note de BTS" note

		#test condition si plus grand que 16
if 	[ $note -ge	16 ] ; then
		echo "Mention trés bien !"

		#sinon tester si plus grand que 14
elif  	[ $note -ge 14 ]; then 
		echo "Mention bien !"

		#sinon tester si plus grand que 12
elif [ $note -ge 12 ];then
		echo "Mention assez bien!"
		#sinon tester si plus grand que 10
elif 	[ $note -ge 10 ]; then
		echo "Mention passable !"

		#sinon recalé
else 
	echo " Recalé !"

fi
#####
