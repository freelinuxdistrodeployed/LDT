#Cliente
import socket

s=socket.socket()
host=socket.gethostname()
port=12345

#Realizacion de la conexion:
s.connect((host,port))

#Imprimimos el mensaje que confirma la conexion:
print "Cliente:",s.recv(1024)

#Una vez confirmada la conexion con el mensaje debemos enviar la info del host:
s.send("hello");

#Cerramos la conexion por parte del cliente:
s.close
