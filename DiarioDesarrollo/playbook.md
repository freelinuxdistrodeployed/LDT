#Playbooks

En un primer contacto implementamos una versión mínima de un playbook como este:

```sh
---
- hosts: all
  tasks:
  - name: Instalar el tren
    command: apt-get install sl
    sudo: yes

```

Conseguimos que se instale el paquete **sl** en todos los host presentes en el fichero host. El resultado de la ejecución del playbook da el siguiente resultado:

```sh
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
```
El programa se ha instalado en los tres hosts.
