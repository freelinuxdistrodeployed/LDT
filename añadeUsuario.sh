#!/bin/bash
# Script para agregar un usuario al sistema
if [ $(id -u) -eq 0 ]; then
	username="ansibleUser"
	password="1234"

	egrep "^$username" /etc/passwd >/dev/null

	if [ $? -eq 0 ]; then
		echo "$username ya existe!"
		exit 1
	else
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		useradd -m -p $pass $username
		echo "ansibleUser ALL=(ALL) ALL" | cat >> /etc/sudoers 
fi
else
	exit 2
fi 
