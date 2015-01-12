---
layout:     post
title:      "Llave publica para instalar Docker"
subtitle:   "Instalacion segura docker"
date:       2014-12-11 12:40:10
author:     "JA-Gonz"
header-img: "img/post-bg-06.jpg"
---

A veces es necesario que el contenedor tenga ciertos recursos (como scripts, u otros archivos) que tienen que ser proporcionados desde la máquina anfitrión, o desde una URL.

Estos archivos podemos añadirlos mediante la opción ADD, mediante la sintaxis:

ADD (ruta_fichero_anfitrion)/fichero (ruta_fichero_contenedor)/fichero

Por ejemplo:

ADD ./fichero ./etc/fichero

Copiaria el fichero situado en el directorio de trabajo actual de la máquina anfitrión en la carpeta /etc del contenedor.

Para lanzar el contenedor ejecutando estos recursos, introducimos la orden:

docker build -t "NOMBRE_CONTENEDOR" - < RECURSO

Donde "NOMBRE_CONTENEDOR" es el nombre que va a tener dicho contenedor, y RECURSO es el fichero que el contenedor va a ejecutar. El guión que hay en la orden es para especificar que el recurso será introducido mediante STDIN. Esto tiene un problema: mediante STDIN, sólo se pueden introducir instrucciones ADD basadas en URL, y no de ficheros reales en el sistema anfitrión. Para solucionar este problema, debemos introducir todos los recursos comprimidos en un fichero .tar.gz. Dicho archivo comprimido, además de todos los recursos, debe contener el archivo Dockerfile.

Por ejemplo:

docker build -t "pruebas" - < recursos.tar.gz

Crea el contenedor llamado "pruebas", pasando los recursos que hay en el archivo comprimido recursos.tar.gz. Dentro de este archivo, se encuentra el Dockerfile con todas las instrucciones que el contenedor tiene que ejecutar, además de todos los recursos (siguiendo el primer ejemplo, se debe situar "fichero" dentro de este archivo comprimido)
