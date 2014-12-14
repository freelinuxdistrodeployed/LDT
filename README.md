#[LDT](http://freelinuxdistrodeployed.github.io/freelinuxdistrodeployed/) (Linux Deployed Tool)]

![](img/linux-console.jpg)

Sistema de control y mantenimiento remoto de equipos con S.O. Linux.

###Versión: 1.0


###Instalación:

Para realizar la instalación de LDT sólo es necesario hacer clone de este repositorio así:

    git clone https://github.com/freelinuxdistrodeployed/freelinuxdistrodeployed.git

Después ejecutar el script **install.sh** que realizará la instalación de todos los paquetes necesarios para el funcionamiento de LDT.


###Uso:

LDT funciona (en su primera versión) a través de una interfaz en terminal que da acceso a todas las acciones que poderemos realizar con el software. Tras la ejecución de LDT.sh podemos ver el menú con estas:

    > . LDT.sh

    LDT Linux Deployed Tool Version 1.0
    #####################################

    LDT Menú Principal:
    1) Admin HOST
    2) Acciones
    3) Carga de perfiles
    4) Salir


En la sección de administración de host encontramos:


    Administración de hosts
    1) Ver host registrados
    2) Modificar hosts (añadir/eliminar)
    3) Probar conectividad hosts

Después de definir los host podremos pasar a realizar tareas sobre ellos:

    Acciones
    1) Consultar hardware de los hosts
    2) Consultar ocupación de disco
    3) Crear usuario en todos los hosts
    4) Consultar usuarios de los hosts
    5) Eliminar un usuario de los hosts
    6) Consultar consumo de red


Además tenemos el núcleo del programa, la carga de perfiles en una lista de hosts:

    Despliegue de perfiles
    1) Ver grupos de host
    2) Despliegue del perfil de administracion
    3) Despliegue del perfil ...
    4) Salir


###Desarrollo:

Para saber más sobre el estado, característica, integrantes y evolución del proyecto puedes visitar nuestra [**web de desarrollo.**](http://freelinuxdistrodeployed.github.io/freelinuxdistrodeployed/)
