__init__.py
Un archivo requerido para que Python trate a ese directorio como un paquete.

manage.py
Utilidad para interactuar con el proyecto de Django de varias formas.

setting.py
Opciones/configuraciones para este proyecto de Django.

urls.py
La declaración de las URL del proyecto, com ouna tabla de contenidos
del sitio hecho con Django.


Ficheros estáticos no relativos a Django.

Static Files

Django distingue entre ficheros estáticos y de "media". Los ficheros estáticos son recursos que incluimos con nuestro
proyecto o aplicación. Los ficheros "media" son archivos subidos por usuarios y almacenados en la máquina.
Django incluye la aplicación contrib (django.contrib.staticfiles) para manegar ficheros estáticos y lo más importante,
generar las URLs para ellos.

Django soporta añadir ficheros estáticos a nivel de aplicación y proyecto.

Ficheros estáticos deben guardarse dentro de un directorio llamado static dentro de la aplicación.
Django solo mirará en los directorios que tenga listados en sus ajusten en la sección STATICFILES_DIRS setting.
