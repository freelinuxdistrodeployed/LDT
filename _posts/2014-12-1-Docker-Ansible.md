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

Usando tareas de ansible podemos automatizar el arranque del servicio de docker, la construcción de las imágenes con los Dokerfile y el inicio o parada de los contenedores de docker.

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

Vamos a crear nuestro primer contenedor con Docker, en este caso va a ser una imagen Ubuntu.

Para empezar, una vez instalado, tenemos que lanzar el servicio Docker:

<pre>sudo docker -d &</pre>

Y ahora procedemos a la instalación de nuestra primera imagen:

<pre>sudo docker pull ubuntu</pre>

Al finalizar la instalación veremos lo siguiente:

```sh
ubuntu:latest: The image you are pulling has been verified

511136ea3c5a: Pull complete
5bc37dc2dfba: Pull complete
61cb619d86bc: Pull complete
3f45ca85fedc: Pull complete
78e82ee876a2: Pull complete
dc07507cef42: Pull complete
86ce37374f40: Pull complete
Status: Downloaded newer image for ubuntu:latest

```

Ahora si queremos listar nuestros contenedores instalados:

<pre>sudo docker ps -a</pre>

```sh
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                        PORTS               NAMES
f11355edfe16        ubuntu:latest       "/bin/bash"         5 minutes ago
```
Si queremos acceder a el:

<pre>sudo docker run -i -t ubuntu</pre>

O en caso de que queramos ejecutarlo:

<pre>sudo docker start -a f11355edfe16</pre>
