---
layout:     post
title:      "Docker y Ansible"
subtitle:   "Integración entre Docker y Ansible"
date:       2014-12-1 00:00:00
author:     "mortega87"
header-img: "img/post-bg-01.jpg"
---

Docker es la herramienta encargada de realizar contenedores y Ansible es la encargada de manejar esos contenedores.

Podemos usar Docker y Ansible de forma separada pero también podemos combinarlas para beneficiarnos de las propiedades de cada una. En Ansible disponemos de dos módulos que nos permite manejar las imágenes y los contenedores de Docker, estos son docker y docker_image.

En primer lugar, vamos a realizar la instalación de Docker.

Para instalar Docker en Ubuntu, en este caso en 14.04LTS vamos a seguir los siguientes pasos:

En primer lugar, debemos actualizar el kernel a la última versión con la siguiente orden:

<pre>sudo apt-get install linux-image-generic-lts-raring linux-headers-generic-lts-raring </pre>

Reiniciamos el sistema para que tome los cambios:

<pre>sudo reboot</pre>

Comprobamos que está actualizado en la última versión con:

<pre>uname -a</pre>

Ahora agregamos el repositorio Docker:

<pre>sudo sh -c "echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"</pre>

Actualizamos la lista de fuentes:

<pre>sudo apt-get update</pre>

Instalamos el paquete Docker:

<pre>sudo apt-get install lxc-docker</pre>

Verificamos que Docker ha sido instalado:

<pre>docker -v</pre>
