#!/bin/bash
#Script para extraer información del hardware de los hosts

#Ejecución de la orden de ansible y salida en fichero
ansible all -a "cat /proc/cpuinfo" > salida.txt


#Obtenemos el número de host que hay
numHOST=`wc -l /etc/ansible/hosts`
numHOST=${numHOST:0:1}

echo -e "Información del Hardware:\n" 

for((i=1; i<=numHOST; i++))
do
	#Extrae el nombre del host
	nombreHOSTn=`cat salida.txt | grep -m${i} ".cloudapp" | tail -n1 `
	#Recorta el nombre del host
	nombreHOSTn=${nombreHOSTn:0:5}

	#Extrae el modelo, la velocidad y la caché del procesador
	modelHOSTn=`cat salida.txt | grep -m${i} "model name" | tail -n1 `
	cpuHOSTn=`cat salida.txt | grep -m${i} "cpu MHz" | tail -n1 `
	cacheHOSTn=`cat salida.txt | grep -m${i} "cache size" | tail -n1 `

	echo ${nombreHOSTn}
	echo ${modelHOSTn}
	echo ${cpuHOSTn}
	echo -e ${cacheHOSTn}"\n"
done

#Eliminamos el fichero temporal
rm salida.txt
