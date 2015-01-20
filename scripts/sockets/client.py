#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Script en python para el envío de información al servidor:
"""

#1.Añadimos las librerias necesarias:
import socket
import sys

#2.Creamos un objeto de tipo socket
s=socket.socket()

#3.Obtenemos nuestro nombre de dominio
miNombre=socket.gethostname();

#3.Especificamos la IP del servidor, de dos maneras posibles:

#3.1.Dándola manualmente
host='137.135.177.253'

#3.2.Consiguiendo la ip del servidor resolviendo su nombre de dominio
try:
   host_ip=socket.gethostbyname('ansibleserver15.cloudapp.net')
except socket.gaierror:
   #Cuando no pueda resover el nombre del server:
   print "No ha sido posible resolver el nombre del server"
   sys.exit();
print "la ip del host sever es",host_ip

#4.Definimos el puerto por el que se hara la conexión:
port=12345

#5.Realizacion de la conexion:
s.connect((host_ip,port))
print "Establecida conexión"


#6.Una vez confirmada la conexion con el mensaje debemos enviar la info del host:
s.send(miNombre);

#7.Cerramos la conexion por parte del cliente:
s.close
