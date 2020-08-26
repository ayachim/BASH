#!/bin/bash
#script permet de faire la correlation entre le numero de session et l'ip 
r=$(cat /opt/mount/rsyslog/ldap/*.log |grep failure |cut -d" " -f6 |cut -d"=" -f2 |sort |uniq)
for i in $r;do
  h=$(cat /opt/mount/rsyslog/ldap/*.log |grep $i |grep ACCEPT |cut -d" " -f10 |cut -d"=" -f2  |cut -d":" -f1)
  host $h >> /home/mayachi/host_tls_fail
done
