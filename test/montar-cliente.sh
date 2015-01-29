#!/bin/bash

#Script de montaje de entorno de pruebas para la herramienta LDT
#Este script monta un contenedor con Docker que actue como cliente y otro contenedor que actue como servidor
#La prueba consistirá en la ejecución de los scripts Python usados para comunicarse el cliente con el servidor.

#Instalación de Ubuntu
sudo docker pull ubuntu

#Creación de la imagen de pruebas cliente
sudo docker build -t "cliente" - < Dockerfile_cliente

#Ejecución de la imagen de pruebas
sudo docker run -i cliente
