#!/bin/bash

#Actualización Kernel necesaria para poder ejecutar Docker

apt-get --assume-yes install linux-image-generic-lts-raring linux-headers-generic-lts-raring 

sudo cp InstalarDocker-2.sh /etc/init.d/

reboot
