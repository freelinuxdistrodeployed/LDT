---
layout:     post
title:      "Hola Server !"
subtitle:   "Saludo al servidor y primera comunicación. Despliegue efectivo de LDt"
date:       2015-01-12 10:00:00
author:     "juanAFernandez"
header-img: "img/post-bg-02.jpg"
---


A la hora de usar LDT contamos con que ya disponemos de la información de los hosts, principalmente ip y nombre de host. Entonces surge el siguiente problema: Cuando un nuevo equipo se conecte, ¿debemos de apuntar a mano su ip (teniendo en cuenta que puede estar tras un DHCP y a mucha distancia fisicamente) y nombre y llevarlos e introducirlos al servidor a mano? Obviamente debemos de poder automatizar esto, deberíamos tener algún mecanismo, un socket (Java) o algo parecido que esté escuchando en el servidor para así desde cualquier host conociendo la ip del servidor poder enviarle la información y que sea el servidor el que se encargue de escribir los datos en el fichero host, hacer una prueba de ping y enviar el resultado de vuelta al host.

En el proceso de instalación de los equipos el mismo instalador que contiene la clave del servidor para habilitar el acceso al equipo debe de enviar los datos del host donde se instala.


Así el proceso de despliegue funcional quedaría sistematizado en los siguientes pasos:

**Pasos de despliegue:**

* **1.** Instalación del paquete LDT, ejecución del fichero install.sh que realiza la instalación de todas las herramientas que se necesitan en el servidor.


![imagen LDT](/img/serverLDT.png)

* **2.** Registro de los host que controlará LDT.

 2.1 Añadiendolos a mano (desfasada).

 **2.2** Usando un socket y activando la comunicación entre los equipos.

 ![imagen2](/img/serverLDT2.png)

 Activando un socket en el servidor al hacer la instalación de LDT conseguimos una forma de que el servidor pueda escuchar los mensajes de todos los equipos que quieran hablarle por ese canal. Así cuando se haga la instalación del paquete necesario en los clientes estos no solo creará un usuario especial para que LDT actúe en ellos de forma controlada, además añadirá la clave SSH del sevidor para que este pueda conectarse sin problema y además enviarán al servidor su IP y nombre (última información que será registrada en *hosts* y que será necesaria para la comunicación final).


 * **3.** Ejecución de LDT.sh.

  Ya podremos ejecutar cualquier acción del programa.
