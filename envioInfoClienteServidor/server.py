#SERVIDOR SIMPLE

import socket


#Para escribir en un fichero debemos de abrirlo:
#ficheroHosts=open("file","w")

#ficheroHosts.write("hola holita vecinito")
#ficheroHosts.write("\n")



#Creamos un objeto de tipo socket
s=socket.socket()
print "Socket creado con exito"

#Obtenemos el nombre de la maquina local:
host=socket.gethostname()

#Establecemos un puerto para la escucha:
port=12345

#Enlazamos los datos al socket creado:
s.bind(('',port))

s.listen(5);
while True:

    #Nos ponemos a la escucha de peticiones:
    c, addr=s.accept();


    print 'Servidor: Recibida conexion desde:',addr

#    ficheroHosts.write(addr)
#    ficheroHosts.write("\n")


    #Establecida la conexion debemos recibir los datos desde el cliente y escribirlos en hosts:

    c.send('Conexion establecida!')
    c.close() #Cerramos la conexion


#Cerramos el fichero Hosts
ficheroHosts.close()


#Referencias:
#https://docs.python.org/2/howto/sockets.html
