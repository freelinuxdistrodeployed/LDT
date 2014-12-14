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
    echo
    echo "1) Submenu2-1"
    echo "2) Submenu2-2"
    echo "3) Salir"
    echo
    echo -n "Indica una opcion: "
}

opc=0
until [ $opc -eq 3 ]
do
    case $opc in
        1)
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
        2)
            opc2=0
            until [ $opc2 -eq 3 ]
            do
                case $opc2 in
                    1)
                        echo "menu 2 submenu 1 Listar hosts"
                        ;;
                    2)
                        echo "menu 2 submenu 2 Añadir hosts"
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
