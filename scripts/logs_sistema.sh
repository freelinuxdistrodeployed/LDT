#!/bin/bash
#Script para conocer usuarios del sistema y ultima vez que accedieron al host
#./acceso_usuarios.sh
ansible all -a "cat /var/log/syslog" > salida.txt

numHost=`wc -l /etc/ansible/hosts`
numHost=${numHost:0:1}

echo -e "LOGS EN HOST:\n"

for((i=1; i<numHost;i++))
do
        nombreHOSTn=`cat salida.txt | grep -m${i} ".cloudapp" | tail -n1`
        nombreHOSTn=${nombreHOSTn:0:5}
        echo -e ${nombreHOSTn}"\n"

        while read linea;
        do
                echo $linea
	done < salida.txt
        echo -e "\n"
done 

rm salida.txt


