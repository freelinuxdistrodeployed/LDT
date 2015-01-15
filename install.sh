#!/bin/bash
#Script de instalación del sistema LDT y dependencias.

#Instalación de Ansible:

  #Instalación de certificados:
  sudo apt-get install -y software-properties-common

  #Añadiendo los repositorios de ansible:
  sudo apt-add-repository -y ppa:ansible/ansible
  #Actualizando:
  sudo apt-get update
  #Instalando
  sudo apt-get install -y ansible

  ansible --version
