#!/bin/bash

# Ejecución directa: ./LDT2.sh -h


show_help() {
  echo -e "Uso:"
  echo -e "LDT [options]"
  echo -e "\t-h: Imprime esta ayuda"
}
show_version(){
  echo -e "Versión: LDT 0.1 @2015 "
}

show_host(){
  cat /etc/ansible/hosts
}

while getopts "h?version?c?v" opt; do

  #Elección
  case $opt in

    h)#Muestra la ayuda.
      show_help
      exit 0
      ;;
    version)
      echo -e "hola"
      ;;
    c)
      show_host
      ;;
    v)#Muestra la ejecución de las órdenes.
      verbose=1
      ;;

  #Fin del case
  esac

done
