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

{% highlight bash %}
---
- hosts: all
  tasks:
  - name: Instalar el tren
    command: apt-get install sl
    sudo: yes
{% endhighlight %}

Conseguimos que se instale el paquete **sl** en todos los host presentes en el fichero host. El resultado de la ejecución del playbook da el siguiente resultado:

{% highlight bash %}
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
{% endhighlight %}

El programa se ha instalado en los tres hosts.
