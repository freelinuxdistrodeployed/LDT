#Inventario

En el fichero **host** registramos los equipos que controlamos.

Podemos definir equipos de esta forma tan explícita:

```sh
Host12014.cloudapp.net ansible_ssh_host=137.135.177.209 ansible_ssh_user=usuario
Host22014.cloudapp.net ansible_ssh_host=23.102.31.130 ansible_ssh_user=usuario
Host32014.cloudapp.net ansible_ssh_host=23.102.24.224 ansible_ssh_user=usuario
```
También podemos hacer grupos para ejecutar órdenes y más adelante playbooks a grupos de usuarios

```sh
Host12014.cloudapp.net ansible_ssh_host=137.135.177.209 ansible_ssh_user=usuario
Host22014.cloudapp.net ansible_ssh_host=23.102.31.130 ansible_ssh_user=usuario
Host32014.cloudapp.net ansible_ssh_host=23.102.24.224 ansible_ssh_user=usuario

[grupo1]
Host12014.cloudapp.net

[grupo2]
Host22014.cloudapp.net
Host32014.cloudapp.net
```

Así podemos ejecutar:

	ansible@AnsibleServer:/etc/ansible$ ansible grupo2 -m ping
