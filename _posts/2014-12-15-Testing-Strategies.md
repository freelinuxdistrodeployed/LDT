---
layout:     post
title:      "Testing Strategies"
subtitle:   "Introducción  al Testing"
date:       2014-15-12 21:00:00
author:     "rubenadrados"
header-img: "img/post-bg-02.jpg"
---


Mediante la incorporación de un nivel de pruebas (testing) en el flujo de trabajo, habrá menos sorpresas cuando el codigo alcance la fase de producción y, en muchos casos, dichas pruebas evitaran que posibles fallos migren a la aplicación final. También es muy sencillo realizar las pruebas en los servidores de localhost.

##Nivel adecuado de Testing

Los recursos de Ansible son modelos de estado deseado, por lo que no deberia ser necesario comprobar que los servicioes estan ejecutandose, instalados, etc. El sistema Ansible funciona de tal forma que asegura que este tipo de cosas están declaradas, insertandolas en los playbooks.


    tasks:
    - service: name=foo state=running enabled=yes

Si un servicio no se esta ejecutando, exigimos que se ejecute, si falla al ejecutarse, Ansible nos mostrara información referente a dicho fallo.

##Check Mode

Puede ser usado también como una capa de pruebas. Si se ejecuta un playbook contra un sistema ya existente, utilizando la bandera -check con el comando ansible reportara si Ansible piensa que habría tenido que haber realizado cambios para adaptar el sistema a un estado deseado.

De esta forma sabes por adelantado si hay que realizar alguna modificación para el despliegue en el sistema. Normalmente los scripts y comandos no se ejecutan en **check mode**, por lo que si se desea que ciertos pasos se ejecuten siempre en check mode hay que utilizar la bandera **always_run**.

    roles:
    - webserver

    tasks:
    - script: verify.sh
    always_run: True

##Modulos útiles

Hay ciertos modulos bastante útiles para testear. A continuación un ejemplo que asegura que un puerto está abierto:

    tasks:

    - wait_for: host={{ inventory_hostname }} port=22
    delegate_to: localhost

Ejemplo de uso del modulo **URI** que asegura que un servicio web vuelve:

    tasks:

    - action: uri url=http://www.example.com return_content=yes
    register: webpage

    - fail: msg='service is not happy'
    when: "'AWESOME' not in webpage.content"

Ejemplo para comprobar la existencia de archivos que no estan declarados en la configuración de Ansible, usando el modulo **stat**:

    tasks:

    - stat: path=/path/to/something
    register: p

    - assert:
    that:
    - p.stat.exists and p.stat.isdir
