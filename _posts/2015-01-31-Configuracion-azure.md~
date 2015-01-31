---
layout:     post
title:      "Configuración Azure"
subtitle:   "Como configurar Microsoft Azure en Linux"
date:       2014-11-25 11:40:00
author:     "mortega87"
header-img: "img/post-bg-01.jpg"
---


Para nuestra aplicación, estamos utilizando Microsoft Azure para alojar nuestras máquinas virtuales en las que estamos realizando las pruebas. En este post voy a tratar de explicar como configurar el cliente que va a realizar la instalación de dichas máquinas virtuales.

En primer lugar, tenemos que tener creada la cuenta en Azure, desde la propia web http://azure.microsoft.com/es-es/ podemos crearla.

Una vez creada manualmente, abrimos una terminal en nuestro sistema operativo Linux (en mi caso está probado sobre un Ubuntu 14.04) y ejecutamos los siguientes comandos:

<pre>sudo apt-get install npm</pre>

Este nos va a instalar el paquete npm que es el que se va a encargar de instalar nuestro cliente Azure.

Para tenerlo con todas las funcionalidades instalamos estos dos paquetes:

<pre>sudo apt-get install nodejs-dev</pre>
<pre>sudo apt-get install nodejs-legacy</pre>

Ahora ya esta el sistema preparado para instalar el cliente de Azure, con la siguiente orden:

<pre>sudo npm install azure-cli -g</pre>

Una vez finalizado, ejecutamos el siguiente comando, con el que vamos a descargar un certificado para asociar nuestra cuenta con el sistema operativo.

<pre>azure account download</pre>

Si accedemos al enlace y nos logueamos, se va a descargar automaticamente el fichero que va a ser nuestro certificado.
Ahora ejecutamos lo siguiente para la finalización de la asociación de nuestra cuenta:

<pre>azure account import Certificado_Descargado</pre>



