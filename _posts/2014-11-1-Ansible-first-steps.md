---
layout:     post
title:      "Ansible first steps"
subtitle:   "Primeros pasos con ansible, posibilidades de la herramienta"
date:       2014-11-1 12:00:00
author:     "juanAFernandez"
header-img: "img/post-bg-01.jpg"
---

#Instalación de Ansible y ping a host


##Instalamos Ansible en el servidor:

Como el servidor que estamos usando es Ubuntu podemos instalarnos la última versión del software con apt:

{% highlight bash %}
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
{% endhighlight %}



Instalados los paquetes comprobamos la versión:

{% highlight bash %}
ansible@AnsibleServer:~$ ansible --version
ansible 1.7.2
{% endhighlight %}


> Por las caraterísticas de Ansible mucha gente trabaja siempre con la útlima versión aún en desarrollo, haciendo un clone directamente del repositorio oficial.


## ¿Cómo se conecta Ansible remotamente con las máquinas?

Sabemos que la principal ventaja que tiene Ansible es que se basa prácticamente en conexiones SSH con los equipos finales. Por eso debemos de configurar bien estas conexiones. En el modelo típico cliente-servidor son los clientes los que se conectan al servidor para realizar alguna actividad en el. En nuestro caso será el servidor quien se conecte con las máqiunas para realizar en ellas ciertas acciones.

Siendo así y sabiendo que nuestro servidor se conectará a los host mediante ssh tendremos que evitar la petición de contraseña típica en la conexión y para ello se usan el par de claves SSH, la pública y la privada.

Entonces haremos lo siguiente; generamos las claves pública y privada en el servidor y distribuiremos la pública a todos los host, así todo host que tenga esta será accesible por el servidor sin necesidad de introducir contraseña.

###1. Generamos el par de claves en el servidor

Dentro de la carpeta **~/.ssh** tenemos las claves del servidor, más concretamente las claves del usuario ansible del servidor, si tuvieramos más usuarios estos tendrían otros directorios ssh distintos e independientes. Ahora sólo vemos el fichero **authorized_keys** en el que estarían escritas las claves de los usuarios que podrían conectarse al servidor, obviamente este fichero está en blanco y así debe seguir. Para generar usamos la herramienta **ssh-keygen** que se instala junto a los paquetes ssh:

	ansible@AnsibleServer:~/.ssh$ ssh-keygen

Tras ejecutar la orden se generan id_rsa (la clave privada) e id_rsa.pub (la pública).

###2. Las enviamos a los hosts:

Todos nuestros host deben tener en su **authorized_keys** una copia de la clave pública generada antes y para ello podemos hacer uso de la orden **ssh-copy-id** que escribe directamente la clave que le indiquemos en el authorized_keys del usuario en el equipo que especifiquemos, uno de los casos sería:

	ansible@AnsibleServer:~/.ssh$ ssh-copy-id -i id_rsa.pub usuario@137.135.177.209

Al hacer esto no pedirá la clave para copiar y realizará el copiado.

###3. Probamos la conexión

Ahora podemos probar a conectarnos desde el servidor a uno de los host.

	ansible@AnsibleServer:~/.ssh$ ssh usuario@137.135.177.209

Se conecta sin pedirnos contraseña, como esperábamos.


##### Prueba de la conexión con un pequeño Inventory y la ejecución de un ping

En Ansible la especificación de los equipos que fomran nuestra infraestructura se hace en **/etc/ansible/hosts**. Allí podemos usar varias nomenclaturas para especificar grupos y hosts, pasa saber más podemos consultar [Inventory](http://docs.ansible.com/intro_inventory.html) de la documentación.

Una de las primeras formas para especificar explícitamente los equipos que se puede usar es:

	Host12014.cloudapp.net ansible_ssh_host=137.135.177.209 ansible_ssh_user=usuario

Donde se especifica el nombre de dominio del equipo, la dirección IP del equipo y el usuario (que en nuestro caso es el mismo en todas los hosts creados).

Configurando nuestros tres hosts el fichero quedaría así:

{% highlight bash %}
ansible@AnsibleServer:~$ cat /etc/ansible/hosts
Host12014.cloudapp.net ansible_ssh_host=137.135.177.209 ansible_ssh_user=usuario
Host22014.cloudapp.net ansible_ssh_host=23.102.31.130 ansible_ssh_user=usuario
Host32014.cloudapp.net ansible_ssh_host=23.102.24.224 ansible_ssh_user=usuario
{% endhighlight %}

A este fichero se le conoce como [Inventario](inventario.md) y posee una nomenclatura específica.

Ya podemos probar la conectividad de Ansible con los hosts mediante un comando especial, **ansible -m ping all** viendo como resultado:

{% highlight bash %}
ansible@AnsibleServer:~$ ansible -m ping all
Host32014.cloudapp.net | success >> {
    "changed": false,
    "ping": "pong"
}
Host22014.cloudapp.net | success >> {
    "changed": false,
    "ping": "pong"
}
Host12014.cloudapp.net | success >> {
    "changed": false,
    "ping": "pong"
}
{% endhighlight %}

Ya tenemos conectividad con los equipos.

Una forma sencilla de ejecutar comandos en los equipos es:

	ansible@AnsibleServer:~$ ansible all -a "df"

Cuya salida nos daría la ocupación de los discos.
