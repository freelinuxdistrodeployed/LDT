#!/usr/bin/env python
# -*- coding: utf-8 -*-

#Cliente

#1. Aniadimos librerias necesarias:
import socket 
import sys


#2. Creamos un objeto de tipo socket
s=socket.socket()

#Obtenemos nuestro nombre de dominio
#miNombre=socket.gethostname();
miNombre=socket.getfqdn();
#3. Especificamos la IP del servidor, de dos maneras posibles:
#3.1. Dandola manualmente
host='137.135.177.253'

#3.2 .Conseguimos la ip del servidor por su nombre de dominio
try:
   host_ip=socket.gethostbyname('ansibleserver15.cloudapp.net')
except socket.gaierror:
   #Cuando no pueda resover el nombre del server:
   print "No ha sido posible resolver el nombre del server"
   sys.exit();
print "la ip del host sever es",host_ip

#4. Definimos el puerto por el que se hara la conexion:
port=12345

#Realizacion de la conexion:
s.connect((host_ip,port))

print "Establecida conexión"

#Imprimimos el mensaje que confirma la conexion:
#print "Cliente recibe: ",s.recv(1024)

#Una vez confirmada la conexion con el mensaje debemos enviar la info del host:
s.send(miNombre);

#Cerramos la conexion por parte del cliente:
s.close

