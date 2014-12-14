---
layout:     post
title:      "Playbooks reading!"
subtitle:   "El núcleo de la automatización"
date:       2014-11-5 12:00:00
author:     "juanAFernandez"
header-img: "img/post-bg-01.jpg"
---

#Playbooks

En un primer contacto implementamos una versión mínima de un playbook como este:


    ---
    - hosts: all
    tasks:
    - name: Instalar el tren
      command: apt-get install sl
      sudo: yes


Conseguimos que se instale el paquete **sl** en todos los host presentes en el fichero host. El resultado de la ejecución del playbook da el siguiente resultado:


    ansible@AnsibleServer:/etc/ansible$ ansible-playbook playbook.yml

    PLAY [all] ********************************************************************

    GATHERING FACTS ***************************************************************
    ok: [Host22014.cloudapp.net]
    ok: [Host32014.cloudapp.net]
    ok: [Host12014.cloudapp.net]

    TASK: [Instalar el tren] ******************************************************
    changed: [Host12014.cloudapp.net]
    changed: [Host32014.cloudapp.net]
    changed: [Host22014.cloudapp.net]

    PLAY RECAP ********************************************************************
    Host12014.cloudapp.net     : ok=2    changed=1    unreachable=0    failed=0
    Host22014.cloudapp.net     : ok=2    changed=1    unreachable=0    failed=0
    Host32014.cloudapp.net     : ok=2    changed=1    unreachable=0    failed=0

El programa se ha instalado en los tres hosts.


Los playbooks pueden tener variables declaradas dentro que nos pueden ayudar a ejecutar de forma más dinámica las tareas.

En este playbook por ejemplo se realiza la copia de un fichero desde el servidor a todos los hosts:

    ---
    - hosts: all
    sudo: true
    tasks:
    - name: Copiar ficheros a los host
    copy: src=../{{fichero}} dest=/home/{{fichero}} owner=root group=root mode=644


Así podemos ejecutarlo con la opción -e de ansible-playbooks que permite pasarle los parámetros que necesita:

    ansible-playbook playbooks/copia.yml -e "fichero=nombreFichero"

Entonces será nombreFichero el fichero que se pase a todos los host, pudiendo ser también una ruta.
