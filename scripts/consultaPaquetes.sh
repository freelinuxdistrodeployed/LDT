#!/bin/bash
#Script para consultar paquete instalado en host, modo de ejecucion:
#./consultaPaquetes.sh <nombre_paquete>
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
                echo $linea | grep $1
        done < salida.txt
        echo -e "\n"
done
rm salida.txt

