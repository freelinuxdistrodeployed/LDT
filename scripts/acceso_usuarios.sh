#!/bin/bash
#Script para conocer usuarios creados en el sistema y ultimo acceso

ansible all -a "lastlog" > salida.txt

numHost=`wc -l /etc/ansible/hosts`
numHost=${numHost:0:1}

echo -e "Usuarios en hosts:\n"

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


