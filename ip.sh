#! /bin/bash

echo "Entrez l'adress ip :"
IFS=. read i1 i2 i3 i4 

echo "Entrez le masque :"
IFS=. read m1 m2 m3 m4 

echo "################"
echo "obase=2; $i1" | bc
echo "obase=2; $i2" | bc
echo "obase=2; $i3" | bc
echo "obase=2; $i4" | bc
echo "################"
echo "obase=2; $m1" | bc
echo "obase=2; $m2" | bc
echo "obase=2; $m3" | bc
echo "obase=2; $m4" | bc
echo "################"

for t in 1 2 3 4; do 

echo ${m$t}

done


