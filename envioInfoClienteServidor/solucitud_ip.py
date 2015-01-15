import netifaces as ni
ni.ifaddresses('lo') #especificar tanto aqui como en la siguietne linea la interfaz a consultar
ip = ni.ifaddresses('lo')[2][0]['addr']
print ip
