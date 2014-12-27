#SERVIDOR SIMPLE

import socket

#Creamos un objeto de tipo socket
s=socket.socket();

#Obtenemos el nombre de la maquina local:
host=socket.gethostname();
#Establecemos un puerto para la escucha:
port=12345

#Enlazamos los datos al socket creado:
s.bind((host,port));

s.listen(5);
while True:

    #Nos ponemos a la escucha de peticiones:
    c, addr=s.accept();


    print 'Servidor: Recibida conexión desde:',addr

    #Establecida la conexión debemos recibir los datos desde el cliente y escribirlos en hosts:


    c.send('Conexión establecida!')
    c.close() #Cerramos la conexion
