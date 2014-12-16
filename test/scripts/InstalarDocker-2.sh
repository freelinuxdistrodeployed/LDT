#!/bin/bash

#Script para instalar Docker

#Añadir repositorio. 
sudo sh -c "echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"

#Añadir la llave pública que verifica el repositorio (el repositorio no está verificado por defecto, omitir este paso
#rompería la instalación desatendida, por no hablar del fallo de seguridad)
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D8576A8BA88D21E9

#Actualizacion de la lista de repositorios
sudo apt-get update

#Instalación de Docker
sudo apt-get --assume-yes install lxc-docker

#Activar demonio de Docker
sudo docker -d &

#Instalación de Ubuntu
sudo docker pull ubuntu

#Creación de la imagen de pruebas
sudo docker build -t "pruebas" - < recurso_pruebas.tar.gz

#Ejecución de la imagen de pruebas
sudo docker run -i pruebas

#Una vez ejecutado lo borramos de la carpeta para que no se ejecute cada vez que se reinicie
sudo rm /etc/init.d/InstalarDocker-2.sh
