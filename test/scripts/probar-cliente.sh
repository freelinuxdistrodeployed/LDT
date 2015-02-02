#!/bin/bash

#Instalación de Ubuntu
sudo docker pull ubuntu

#Creación de la imagen de pruebas cliente
sudo docker build -t "cliente" - < Dockerfile_cliente

#Ejecución de la imagen de pruebas
sudo docker run -i cliente
