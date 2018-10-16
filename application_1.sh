#! /bin/bash


#La majorité

echo "Quel est ton age ?"
#lit l'age 
read age
an="ans"
#verifit si singulier
if [ $age -le 1 ];then
	an="an"
fi
#verifit si mineur ou majeur

if [ $age -gt 18 ]
then
	echo "$age $an donc tu es majeur !"
else 
	echo "$age $an donc tu es mineurs !"
fi
