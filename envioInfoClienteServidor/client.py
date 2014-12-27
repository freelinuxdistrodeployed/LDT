#Cliente
import socket

s=socket.socket()
host=socket.gethostname()
port=12345

#Realización de la noexión:
s.connect((host,port))

#Imprimimos el mensaje que confirma la conexión:
print "Cliente:",s.recv(1024)

#Una vez confirmada la conexión con el mensaje debemos enviar la info del host:



#Cerramos la conexión por parte del cliente:
s.close
