---
layout:     post
title:      "Llave publica para instalar Docker"
subtitle:   "Instalacion segura docker"
date:       2014-12-11 12:00:37
author:     "JA-Gonz"
header-img: "img/post-bg-06.jpg"
---


Para instalar Docker en su útlima versión, necesitamos añadir un repositorio a mano, mediante la orden:

sh -c "echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list

Esta orden tieMne un problema: añade dicho repositorio a la lista de repositorios de nuestro equipo correctamente, pero por defecto,
nuestro sistema no podrá verificar la identidad del repositorio.

Esto conlleva dos problemas. Por un lado, no es posible automatizar un script de instalación desatendida, ya que apt-get
no instala desatendidamente paquetes no verificados. Por otro lado, hay que mencionar el lógico problema de seguridad que tendría nuestra aplicación, ya que si optamos por instalar paquetes y programas no verificados, podriamos estar instalando alteraciones malintencionadas de los mismos.

Para corregir estos problemas, nos basta con añadir la clave pública a nuestro sistema que verificará la identidad del repositorio. Para ello,
ejecutaremos la orden:

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D8576A8BA88D21E9

Fuente: http://qiita.com/poad1010/items/c483be84df16ed1459a9M
