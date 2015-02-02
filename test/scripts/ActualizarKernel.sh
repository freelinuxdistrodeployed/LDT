#!/bin/bash

#Actualización Kernel necesaria para poder ejecutar Docker

apt-get --assume-yes install linux-image-generic-lts-raring linux-headers-generic-lts-raring 

#Copiamos el instalador de Docker en la carpeta init.d para que se ejecute con el resto de servicios del sistema
sudo cp Instalar&EjecutarPruebasServer-clie.sh /etc/init.d/

#Lo instalamos
sudo update-rc.d Instalar&EjecutarPruebasServer-clie.sh defaults

reboot
