#############################################################
# Dockerfile para instalar ansible y ejecutar menú LDT
# Basado en Ubuntu
#############################################################

FROM ubuntu:latest

MAINTAINER JuanAFernandez juanantc mortega87 rubenadrados JA-Gonz

#Instalar ansible

RUN apt-get update
RUN apt-get install -y ansible

#Ejecutar menú LDT
ADD ./LDT.sh /LDT.sh
CMD ["/bin/bash", "/LDT.sh"]
