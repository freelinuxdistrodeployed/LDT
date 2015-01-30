---
layout:     post
title:      "Acciones desatendidas"
subtitle:   "Uso de SSHPass y echo para evitar interacción con el usuario"
date:       2015-30-1 20:00:00
author:     "juanantc"
header-img: "img/post-bg-02.jpg"
---
Para poder automatizar diferentes tareas en las que se requiere interacción con el usuario hemos necesitado hacer uso de algunas herramientas:

###SSHPass

SSHPass es una utilidad que permite evitarnos los diálogos interactivos de SSH en los que se nos pide la password del usuario de la máquina a la que nos vamos a conectar.

      sudo apt-get install sshpass


En nuestro caso, se ha hecho uso de ella para copiar la clave pública a cada host:

    sshpass -pPASSWORD ssh-copy-id -i ~/.ssh/id_rsa.pub -o USUARIO@IP

###Otros

A la hora de generar el par de claves en el servidor, hay algunos pasos en los que se requiere interacción por parte del usuario. Para evitarlo añadimos algunos parametros a ssh-keygen:

      ssh-keygen -f ~/.ssh/id_dsa -t dsa -q -N
