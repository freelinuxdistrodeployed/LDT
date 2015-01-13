import netifaces as ni
ni.ifaddresses('lo')
ip = ni.ifaddresses('lo')[2][0]['addr']
print ip
