#!/bin/bash
#Script para extraer información de ocupación de los discos de los hosts

#Ejecución de la orden de ansible y salida en fichero.
ansible all -a "df -BM" > salida.txt

#Obtenemos el número de host que hay:
numHOST=`wc -l /etc/ansible/hosts`
numHOST=${numHOST:0:1}

echo "Uso de los discos de los host:"

for((i=1; i<=numHOST; i++))
do

	#Extrae el nombre del host
	nombreHOSTn=`cat salida.txt | grep -m${i} ".cloudapp" | tail -n1 `
	#Recorta el nombre del host
	nombreHOSTn=${nombreHOSTn:0:5}


	#Extrae datos de uso del host:
	capacidadHOSTn=`cat salida.txt | grep -m${i} "sda1" | tail -n1 `
	#Recorta datos de uso  del host:
	capacidadHOSTn=${capacidadHOSTn:40:5}

	echo ${nombreHOSTn}${capacidadHOSTn}

done

#Eliminamos el fichero temporal
rm salida.txt
