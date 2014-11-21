#!/bin/bash
#Script para consultar los paquetes instalados en los hosts
ansible all -a "dpkg --get-selections" > salida.txt

numHost=`wc -l /etc/ansible/hosts`
numHost=${numHost:0:1}

echo -e "Paquete en hosts:\n"

for((i=1; i<=numHost;i++))
do
        nombreHostn=`cat salida.txt | grep -m${i} ".cloudapp" | tail -n1`
        nombreHostn=${nombreHostn:0:5}
        echo -e ${nombreHostn}"\n"

        while read linea;
        do
                echo $linea | grep libreoffice
        done < salida.txt
        echo -e "\n"
done
rm salida.txt

