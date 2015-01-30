#!/bin/bash
#Script de configuración del host.

USERNAME="ansibleUser"
PASSWORD="ldtansible"

#1.Crear un usuario para ansible con permisos de root:
sudo ./añadeUsuario.sh

#2.Contactar con el servidor y enviarle la última información necesaria:

#2.1 Ejecutar el script client.py

echo -e "\e[0;32mConectando con el servidor...\e[0m"
python scripts/sockets/client.py

#3.Al enviar mi dirección y usar el nombre de usuario genérico puedo recibir la clave.
