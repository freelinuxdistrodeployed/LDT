---
layout:     post
title:      "Contenedores LXC"
subtitle:   "Ventajas para el testing"
date:       2014-11-26 12:00:00
author:     "juanAFernandez, juanantc"
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

    brctl addbr lxcbr0

Configuramos su dirección de red y máscara:

    ifconfig lxcbr0 10.0.0.1/24

Vemos el resultado:

    ifconfig lxcbr0


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

Para probar la conexión entre contenedores y anfitrión vamos a proceder a crear tres contenedores que simularán tres hosts (host1, host2, host3).

    sudo lxc-create -t ubuntu -n host<n>

Una vez creados, los lanzamos:

    sudo lxc-start -n host<n>
    
Como ejemplo, vamos a usar SSH para conectarnos al host1. Previamente debemos saber su dirección ip. Esto lo hacemos de la siguiente manera:

    Ubuntu> sudo lxc-info -n host1
    Name:           host1
    State:          RUNNING
    PID:            662
    IP:             10.0.3.xxx
    IP:             192.168.0.1
    CPU use:        1.48 seconds
    BlkIO use:      1.22 MiB
    Memory use:     7.97 MiB
    KMem use:       0 bytes
    Link:           vethRIG4N4
     TX bytes:      8.04 KiB
     RX bytes:      20.50 KiB
     Total bytes:   28.54 KiB

Nos conectarnos:

    Ubuntu> ssh ubuntu@10.0.3.xxx
    ubuntu@10.0.3.xxx's password: 
    Welcome to Ubuntu 14.04.1 LTS (GNU/Linux 3.13.0-37-generic x86_64)
    
     * Documentation:  https://help.ubuntu.com/
    Last login: Fri Nov 28 19:10:41 2014 from 10.0.3.1
    ubuntu@host1:~$ 


##Objetivo final: testear LDT (Ansible) de forma local

Para ello debemos instalar Ansible en nuestra máquina, generar el par de claves de la misma, enviarlas a cada uno de los contenedores y por último, añadir al inventario (/etc/ansible/hosts) las máquinas con las que se va a trabajar. Todo ello está explicado paso a paso en el primer post.

Nota: los contenedores que hemos creado no tienen instalado Python por defecto. Esto nos impide que podamos comunicarnos con ellos a través de Ansible. Por tanto, para realizar una primera prueba con Ansible, previamente tenemos que instalar el paquete de Python en cada uno de ellos. De lo contrario nos lanzará un error de conexión.

Una vez instalado todo y configurado correctamente ya podemos probar la conectividad de Ansible con los hosts:

    Ubuntu> ansible -m ping all
    host2 | success >> {
        "changed": false, 
        "ping": "pong"
    }
    host1 | success >> {
        "changed": false, 
        "ping": "pong"
    }
    host3 | success >> {
        "changed": false, 
        "ping": "pong"
    }

También podemos probar una orden simple que nos muestre la ocupación de los discos para ver que funciona:

    Ubuntu> ansible all -a "df"
    host1 | success | rc=0 >>
    Filesystem                                             1K-blocks     Used Available Use% Mounted on
    /dev/disk/by-uuid/e271f34b-4458-45d8-957c-e124713bfdc5  58218708 39186972  16051284  71% /
    none                                                           4        0         4   0% /sys/fs/cgroup
    none                                                      390948       56    390892   1% /run
    none                                                        5120        0      5120   0% /run/lock
    none                                                     1954732        0   1954732   0% /run/shm
    none                                                      102400        0    102400   0% /run/user
    
    host3 | success | rc=0 >>
    Filesystem                                             1K-blocks     Used Available Use% Mounted on
    /dev/disk/by-uuid/e271f34b-4458-45d8-957c-e124713bfdc5  58218708 39186860  16051396  71% /
    none                                                           4        0         4   0% /sys/fs/cgroup
    none                                                      390948       56    390892   1% /run
    none                                                        5120        0      5120   0% /run/lock
    none                                                     1954732        0   1954732   0% /run/shm
    none                                                      102400        0    102400   0% /run/user
    
    host2 | success | rc=0 >>
    Filesystem                                             1K-blocks     Used Available Use% Mounted on
    /dev/disk/by-uuid/e271f34b-4458-45d8-957c-e124713bfdc5  58218708 39186784  16051472  71% /
    none                                                           4        0         4   0% /sys/fs/cgroup
    none                                                      390948       56    390892   1% /run
    none                                                        5120        0      5120   0% /run/lock
    none                                                     1954732        0   1954732   0% /run/shm
    none                                                      102400        0    102400   0% /run/user
    

Información interesante:

[DigitalOcean](https://www.digitalocean.com/community/tutorials/getting-started-with-lxc-on-an-ubuntu-13-04-vps)
[BeCodeMyFriend](http://www.becodemyfriend.com/2013/09/entorno-de-programacion-higienico-con-lxc/)


https://wiki.archlinux.org/index.php/Linux_Containers#Testing_Setup
