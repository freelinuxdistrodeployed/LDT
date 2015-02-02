#!/bin/bash

#Instalación de Ubuntu
sudo docker pull ubuntu

#Creación de la imagen de pruebas servidor
sudo docker build -t "servidor" - < Dockerfile_servidor

#Ejecución de la imagen de servidor
sudo docker run -i servidor
