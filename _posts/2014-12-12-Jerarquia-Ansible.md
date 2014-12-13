---
layout:     post
title:      "Jerarquía en Ansible"
subtitle:   "Roles, perfiles de instalación y módulos"
date:       2014-12-12 18:30:00
author:     "juanAFernandez"
header-img: "img/post-bg-02.jpg"
---

Cuando comenzamos a usar Ansible empezamos con un sólo fichero **.yml** pero pronto vemos que no es suficiente si queremos administrar varios perfiles de instalación.
Podemos jerarquizar la estructura de ficheros de nuestro proyecto en Ansible de la siguiente manera por ejemplo:

    ├── hosts
    ├── roles
    │   ├── admin
    │   │   └── tasks
    │   │       └── main.yml
    │   └── common
    │       └── tasks
    │           └── main.yml
    └── site.yml

donde tenemos dentro de la carpeta **roles** dos de ellos, admin (hosts de asministración) y common (configuración común a todos los equipos) y dentro de ellos en la carpeta tasks tenemos los main también en .yml donde especificamos las tareas de cada perfil. Por ejemplo, las tareas del perfil común, que se aplicará a todos los hosts son:


    ---
    #Este playbook contiene las instalaciones comunes a ejecutar en todos los hosts:

    - name: Instalación del paquete ofimatico
    apt: pkg=libreoffice state=latest

    - name: Instalar navegador
    apt: pkg=chromium-browser state=latest

Además dentro del fichero hosts donde se definen los equipos se realizan asignaciones de grupos, de forma que podemos dentro del site.yml principal aplicar a grupos de hosts perfiles distintos.


    ---
    #Despliegue de configuración de todos los equipos:

    - name: Aplicación de la configuración general
    sudo: true
    hosts: all
    remote_user: root

    roles:
    - common

    #Específico a los equipos de administración

    - name: Aplicación de configuracion a los host de administracion
    sudo: true
    hosts: admin
    remote_user: root

    roles:
    - admin


Esta modularización, en la que se puede profundizar mucho, del código permite mucha más flexibilidad a la hora de su modificación y uso.

La forma de ejecutar el playbook **site.yml** sigue siendo el mismo:

    AnsibleServer> ansible-playbook -i hosts site.yml
