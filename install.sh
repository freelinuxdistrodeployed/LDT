#!/bin/bash
#Script de instalación del sistema LDT y dependencias.
#Debe de ejecutarse como superusuario.

echo -e "\n\e[0;32mLDT Linux Deployed Tool Version 1.0 \e[0m"
echo -e "\n\e[0;32mInstalando...\e[0m"

#1. Instalación de python

echo -e "\n\e[0;32mInstalando python \e[0m"
sudo apt-get install -y python

#2. Instalación de Ansible:

echo -e "\n\e[0;32mInstalando certificados\e[0m"
#Instalación de certificados:
sudo apt-get install -y software-properties-common

#Añadiendo los repositorios de ansible:
echo -e "\n\e[0;32mActualizando repositorios\e[0m"
sudo apt-add-repository -y ppa:ansible/ansible
#Actualizando:
echo -e "\n\e[0;32mUpdating\e[0m"
sudo apt-get update
#Instalando
echo -e "\n\e[0;32mInstalando ANsible\e[0m"
sudo apt-get install -y ansible
#Mensajito con la versión de ansible instalada
echo -e "\n\e[0;32mVersión de Ansible instalada\e[0m"
ansible --version

#3. Apertura del socket de escucha de peticiones de conexión de clientes:

#Ejecutamos el script que abre el socket, en segundo plano.
echo -e "\n\e[0;32mAbriendo socket de escucha en segundo plano\e[0m"
sudo python scripts/sockets/server.py &
