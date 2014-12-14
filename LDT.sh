

#!/bin/bash

# -e para que interprete las ordenes especiales de la barra invertida \
echo -e "\n \e[0;32mLDT Linux Deployed Tool Version 1.0 \e[0m"
echo -e "\e[1;35m#####################################\e[0m"

#Muestra el menu general
function _menuPrincipal()
{
    echo -e "\n\e[0;32mLDT\e[0m Menú Principal:"
    echo "1) Admin HOST"
    echo "2) Acciones"
    echo -e "3) \e[1;31mSalir\e[0m"
    echo
    #-n para no hacer el intro al final
    echo -n "Indica una opcion: "
}

function _submenu1()
{
    echo -e "\n\e[0;32mAdministración de hosts\e[0m"
    echo -e "1) Ver host registrados"
    echo "2) Modificar hosts (Añadir/eliminar)"
    echo "3) Probar conectividad hosts"
    echo -e "4) \e[1;31mSalir\e[0m"
    echo 
    echo -n "Indica una opcion: "
}

function _submenu2()
{
    echo -e "\n\e[0;32mAcciones\e[0m"
    echo "1) Consultar hardware de los hosts"
    echo "2) Consultar ocupación de disco"
    echo "3) Crear usuario en todos los hosts"
    echo "4) Consultar usuarios de los hosts"
    echo "5) Eliminar un usuario de los hosts"
    echo -e "6) \e[1;31mSalir\e[0m"
    echo
    echo -n "Indica una opcion: "
}

opc=0
until [ $opc -eq 3 ]
do
    case $opc in

        1) #ADMINISTRACIÓN DE HOSTS
            opc1=0
            until [ $opc1 -eq 4 ]
            do
                case $opc1 in
                    1)
			#Eleccion 1 del submenu1: Ver host registrados
                        echo -e "\e[1;32mHost registrados:\e[0m"
			cat hosts
			echo ""
			_submenu1
                        ;;
                    2)
			#Elección 2 del submenu1: Modificar hosts
                        echo -e "Modificar hosts con \e[1;35mnano\e[0m "
			sleep 2
			nano hosts
			echo fin modificacion
			_submenu1
                        ;;
		    3)
			#Eleccion 3 del submenu1: Probar host
			echo -e "\e[1;32mProbando conectividad con todos los hosts\e[0m"
			ansible -m ping all
			_submenu1
			;;

                    *)
			#En cualquier otro caso (incluido el 0 inicial)
                        _submenu1
                        ;;
                esac
                read opc1
            done
            _menuPrincipal
            ;;

        2) #ACCIONES

           #Variables necesarias para la creación de usuarios
	   
	   

            opc2=0
            until [ $opc2 -eq 6 ]
            do
                case $opc2 in
                    1)  #Elección 1 del submenu2: Consultar hardware de equipos
			. scripts/hardwareHosts.sh 
			_submenu2
                        ;;
                    2)  #Elección 2 del submenu2: Consultar espacio de disco de los equipos
			echo 
                        . scripts/usoDisco.sh
			_submenu2
                        ;;

		    3)  #Elección 3 del submenu2: Creación general de usuario
			echo "Creación de usuario tipo general: "
                        echo -e  "Introduzca \e[1;31mnombre\e[0m de usuario:"
			read -p "--> " nombreUsuario
			echo -e "Introduzca \e[1;31mcontraseña\e[0m para $nombreUsuario"
			read -p "--> " pass
			#Ejecución del playbook
			ansible-playbook playbooks/usuarioAnsibleParametros.yml -e "usuario=$nombreUsuario password=$pass"
			_submenu2
			;;

		    4)  #Lista todos los usuarios de cada uno de los hosts
			ansible all -a "cat /etc/passwd"
			echo
			_submenu2
			;;

		    5) #Elección 5 del submenu 2: Elminación de un usario
		       echo "Nombre del usuario: "
		       read -p "--> " nombreUsuario
                       ansible-playbook playbooks/eliminarUsuarioParametros.yml -e "usuario=$nombreUsuario"
		       echo
                       _submenu2
                       ;;


		   6) #Elección 6 del submenu2: Consulta de red
		      ansible all -a "vnstat"
		      echo
                      _submenu2
		      ;;

                    *)
                        _submenu2
                        ;;
                esac
                read opc2
            done
            _menuPrincipal
            ;;
        *)
            _menuPrincipal
            ;;
    esac
    read opc
done
