#!/bin/bash
#Script de instalación de LibreOffice en todos los host.

#Mostramos el uso de disco en los equipos antes de la instalación.
echo "Antes de la instalación"
./scripts/usoDisco.sh

#Realizamos la instalación con un playbook
ansible-playbook /etc/ansible/playbooks/playbookGimp.yml

#Comprobamos la versiónd del software instalado
echo "Instalado: "
ansible all -a "gimp --version"

#Volvemos a obtener los datos de ocupación
echo "Después de la instalción"
./scripts/usoDisco.sh

