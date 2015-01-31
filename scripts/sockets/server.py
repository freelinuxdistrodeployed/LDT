#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Script en python para establecer socket de escucha.
Debe ejecutarse como superusuario para que pueda abrirse el fichero de host en /etc.
"""

import socket
import commands
import os



#1.Abrimos el fichero donde se graban los host
#ficheroHosts=open("/etc/ansible/hosts","r+w")

#2.Creamos un objeto de tipo socket
s=socket.socket()

#3.Establecemos un puerto para la escucha:
port=12345
print "Abierto socket con exito en puerto ", port

#4.Enlazamos los datos al socket creado al puerto recibiendo peticiones de cualquier máquina ('')
s.bind(('',port))

#5.Nos ponemos a la escucha
s.listen(5);
linea="";
while True: ##Proceso infinito de escucha##

    #1.Abrimos el fichero donde se graban los host
    ficheroHosts=open("/etc/ansible/hosts","arw")


    #5.1.Aceptamos los mensajes
    c, addr=s.accept();

    print 'Servidor: Recibida conexion desde:',addr
    #En addr ya tenemos la ip del host cliente.

#    ficheroHosts.write(addr)
#    ficheroHosts.write("\n")


    #Establecida la conexion debemos recibir los datos desde el cliente y escribirlos en hosts:

    #c.send('Conexion establecida!')

    #Imprimimos por pantalla lo que nos envia
    nombreHost=c.recv(1024)

    #Introducimos el nombre del host en un string
    linea=nombreHost;
    #Añadimos un espacio en blanco
    linea+=' ';
    #Añadimos una pequeña descripción para Ansible:
    linea+='ansible_ssh_host=';
    #Añadimos la ip recibida y un espacio en blanco:

    #Recortamos sólo lo que nos interesa:
    direccion=str(addr);
    start=direccion.find('(')
    start+=2
    end=direccion.find(',')
    end-=1
    direccion=direccion[start:end]

    linea+=str(direccion);
    linea+=' ';
    #Añadimos el usuario especial creado en el host:
    linea+='ansible_ssh_user=ansibleUser';

    print "Añadido ", linea
    ficheroHosts.write(linea+'\n');

    #Enviamos la clave pública del servidor.
    #orden="sshpass -p"
    #orden+=$CONTRASENIA
    #orden+="ssh-copy-id -i ~/.ssh/id_rsa.pub -o ansibleUser@"

    orden="sshpass -p1234 ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no ansibleUser@"


    #Añadimos la direccion
    orden+=direccion
    os.system(orden)


    #Cerramos el fichero de hosts
    ficheroHosts.close()


    c.close() #Cerramos la conexion

    #Esta conexión se cierra pero el socket queda abierto para repetir el proceso siempre que se quiera.


#Referencias:
#https://docs.python.org/2/howto/sockets.html
