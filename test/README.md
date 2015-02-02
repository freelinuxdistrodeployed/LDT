#Testing

![](test.jpg)

El test previo al despliegue del sistema es fundamental para verificar las prestaciones y posibles errores del sistema antes de su uso final. En el directorio test se dispone del entorno completo de instalación que nos desplegará mediante Docker dos contenedores donde uno hará las funciones de servidor de control (LDT) y otro de equipo de usuario.

Estos scripts nos facilitan las herramientas para la instalación previa, y la ejecución del testing, siguiendo los siguientes pasos:

###Instalación previa:

Dentro de la carpeta Scripts, debemos de ejecutar el script "ActualizarKernel.sh", ya que Docker no funcionará si el kernel no está en la versión requerida. Después de reiniciar el sistema, se ejecutará automáticamente el script "Instalar&EjecutarPruebasServer-clie.sh".

###Ejecución del test:

El test se realiza automáticamente tras reiniciar (ya que abre el script Instalar&EjecutarPruebasServer-clie.sh). Para probar el entorno, se abre dicho script, aunque también se proporcionan dos scripts adicionales para el cliente y el servidor respectivamente (probar.cliente.sh y probar-servidor.sh).
