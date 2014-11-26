---
layout:     post
title:      "Contenedores LXC"
subtitle:   "Ventajas para el testing"
date:       2014-11-26 12:00:00
author:     "juanAFernandez"
header-img: "img/post-bg-01.jpg"
---

#Contenedores LXC para testing.

Vistas las deficiencias que vimos con las jaulas chroot para el tipo de sistema que queremos testear vamos a probar si los contenedores LXC las suplen.

##Instalación

Antes de comenzar a crear contenedores necesitaremos instalar algunos paquetes:


    apt-get install lxc


Tras esto podemos ver la configuración de LXC:


    Ubuntu> lxc-checkconfig
    Kernel config /proc/config.gz not found, looking in other   places...
    Found kernel config file /boot/config-3.11.0-20-generic
    --- Namespaces ---
    Namespaces: enabled
    Utsname namespace: enabled
    Ipc namespace: enabled
    Pid namespace: enabled
    User namespace: missing
    Network namespace: enabled
    Multiple /dev/pts instances: enabled

    --- Control groups ---
    Cgroup: enabled
    Cgroup clone_children flag: enabled
    Cgroup device: enabled
    Cgroup sched: enabled
    Cgroup cpu account: enabled
    Cgroup memory controller: missing
    Cgroup cpuset: enabled

    --- Misc ---
    Veth pair device: enabled
    Macvlan: enabled
    Vlan: enabled
    File capabilities: enabled

    Note : Before booting a new kernel, you can check its configuration
    usage : CONFIG=/path/to/config /usr/bin/lxc-checkconfig



## Creación de contenedores

Para crear un contenedor hacemos:


    lxc-create -n test-container -t ubuntu

Con esto creamos un nuevo contenedor que contendŕa un ubuntu de nombre **test-container**. La salida de la terminación del proceso es:


    ##
    # The default user is 'ubuntu' with password 'ubuntu'!
    # Use the 'sudo' command to run tasks as root in the container.
    ##

    'ubuntu' template installed
    'test-container' created


Podemos comprobar los contenedores creados con **lxc-list**:


    Ubuntu> sudo lxc-list
      RUNNING

      STOPPED
        test-container



Los contenedores creados se almacenan en **/var/lib/lxc/**


    Ubuntu> ls /var/lib/lxc/
      test-container





##Arranque, estado y detención de contenedores

Para arrancar un contenedor hacemos:

    lxc-start -n <nombre del contenedor>

y para detenerlo:

    lxc-stop -n <nombre del contenedor>

Los principales ficheros de configuración de LXC son:

    /etc/default/lxc

su contenido será algo parecido a esto:

    # MIRROR to be used by ubuntu template at container creation:
    # Leaving it undefined is fine
    #MIRROR="http://archive.ubuntu.com/ubuntu"
    # or
    #MIRROR="http://<host-ip-addr>:3142/archive.ubuntu.com/ubuntu"

    # LXC_AUTO - whether or not to start containers symlinked under
    # /etc/lxc/auto
    LXC_AUTO="true"

    # Leave USE_LXC_BRIDGE as "true" if you want to use lxcbr0 for  your
    # containers.  Set to "false" if you'll use virbr0 or another   existing
    # bridge, or mavlan to your host's NIC.
    USE_LXC_BRIDGE="true"

    # If you change the LXC_BRIDGE to something other than lxcbr0,  then
    # you will also need to update your /etc/lxc/lxc.conf as well as    the
    # configuration (/var/lib/lxc/<container>/config) for any   containers
    # already created using the default config to reflect the new bridge
    # name.
    LXC_BRIDGE="lxcbr0"
    LXC_ADDR="10.0.0.1"
    LXC_NETMASK="255.255.255.0"
    LXC_NETWORK="10.0.3.0/24"
    LXC_DHCP_RANGE="10.0.3.2,10.0.3.254"
    LXC_DHCP_MAX="253"

    LXC_SHUTDOWN_TIMEOUT=120

Otro es

    /etc/lxc/lxc.conf

que contiene algo parecido a:

    lxc.network.type=veth
    lxc.network.link=br0
    lxc.network.flags=up

Y por útlimo el fichero de configuración de cada contenedor que estará en:

    /var/lib/lxc/<nombre-contenedor>/config

y contendrá algo así:

    lxc.network.type=veth
    lxc.network.link=br0
    lxc.network.flags=up
    lxc.network.hwaddr = 00:16:3e:b0:82:87
    lxc.utsname = test-container

    lxc.devttydir = lxc
    lxc.tty = 4
    lxc.pts = 1024
    lxc.rootfs = /var/lib/lxc/test-container/rootfs
    lxc.mount  = /var/lib/lxc/test-container/fstab
    lxc.arch = i686
    lxc.cap.drop = sys_module mac_admin
    # uncomment the next line to run the container unconfined:
    #lxc.aa_profile = unconfined

    lxc.cgroup.devices.deny = a
    #Allow any mknod (but not using the node)
    lxc.cgroup.devices.allow = c *:* m
    lxc.cgroup.devices.allow = b *:* m
    # /dev/null and zero
    lxc.cgroup.devices.allow = c 1:3 rwm
    lxc.cgroup.devices.allow = c 1:5 rwm
    # consoles
    lxc.cgroup.devices.allow = c 5:1 rwm
    lxc.cgroup.devices.allow = c 5:0 rwm
    #lxc.cgroup.devices.allow = c 4:0 rwm
    #lxc.cgroup.devices.allow = c 4:1 rwm
    # /dev/{,u}random
    lxc.cgroup.devices.allow = c 1:9 rwm
    lxc.cgroup.devices.allow = c 1:8 rwm
    lxc.cgroup.devices.allow = c 136:* rwm
    lxc.cgroup.devices.allow = c 5:2 rwm
    # rtc
    lxc.cgroup.devices.allow = c 254:0 rwm
    #fuse
    lxc.cgroup.devices.allow = c 10:229 rwm
    #tun
    lxc.cgroup.devices.allow = c 10:200 rwm
    #full
    lxc.cgroup.devices.allow = c 1:7 rwm
    #hpet
    lxc.cgroup.devices.allow = c 10:228 rwm
    #kvm
    lxc.cgroup.devices.allow = c 10:232 rwm


ahora veremos lo que nos es relevante.



###Configuración de red previa

Es posible que en el proceso de arranque del contenedor nos hayamos encontrado algunos fallos como estos:

    Ubuntu> sudo lxc-start -n test-container
    lxc-start: failed to attach 'veth5yaPuO' to the bridge 'lxcbr0' : No such device
      lxc-start: failed to create netdev
      lxc-start: failed to create the network
      lxc-start: failed to spawn 'test-container'
      lxc-start: No such file or directory - failed to remove cgroup '/sys/fs/cgroup/cpuset//lxc/test-container'

Lo que está ocurriendo es que lxc no encuentra el dispositvo de red para el contendor (lxcbr0) que debería de estar creado previamente. Lo normal es que este se hubiera creado sólo pero de no haberse hecho tendremos que hacerlo nosotros a mano.

Para eso necesitamos instalar [**bridge-utils**](http://www.linuxfoundation.org/collaborate/workgroups/networking/bridge#Downloading) :

    apt-get install bridge-utils


Tras instalarlo configuramos la nueva interfaz de red, para eso haremos uso de [**brctl**](http://linuxcommand.org/man_pages/brctl8.html), una herramienta de linux para configurar puentes ethernet del kernel.

Para añadir una interfaz nueva hacemos **brctl addbr (nombre de la interfaz)**:

    brctl addbr br0






Una vez solucionado el problema del dispositivo de red podremos arrancar el contenedor:


    Ubuntu 12.04.5 LTS test-container console

    test-container login: ubuntu
    Password:
    Welcome to Ubuntu 12.04.5 LTS (GNU/Linux 3.11.0-20-generic i686)

    * Documentation:  https://help.ubuntu.com/

    The programs included with the Ubuntu system are free software;
    the exact distribution terms for each program are described in the
    individual files in /usr/share/doc/*/copyright.

    Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law.

    ubuntu@test-container:~$

##Conexiones entre contenedores y anfitrión


##Objetivo final: testear LDT (Ansible) de forma local


Información interesante:

[DigitalOcean](https://www.digitalocean.com/community/tutorials/getting-started-with-lxc-on-an-ubuntu-13-04-vps)
[BeCodeMyFriend](http://www.becodemyfriend.com/2013/09/entorno-de-programacion-higienico-con-lxc/)


https://wiki.archlinux.org/index.php/Linux_Containers#Testing_Setup
