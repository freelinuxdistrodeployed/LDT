#!/bin/bash
#Script de configuración del host.


#1.Crear un usuario para ansible con permisos de root:
echo -e "\n\e[0;32mCreando usuario ansibleUser \e[0m"
sudo ./añadeUsuario.sh


#2 Ejecutar el script client.py

echo -e "\e[0;32mConectando con el servidor...\e[0m"
python scripts/sockets/client.py

#3.Al enviar mi dirección y usar el nombre de usuario genérico puedo recibir la clave.
