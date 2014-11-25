---
layout:     post
title:      "Jaulas Chroot"
subtitle:   "Las posibilidades del testing en Jaulas"
date:       2014-11-25 12:00:00
author:     "José Antonio González"
header-img: "img/post-bg-01.jpg"
---

# Jaulas en nuestro sistema

Las jaulas, por definición, aislan solamente el sistema de ficheros entre los distintos usuarios. Es decir, un usuario "enjaulado" solamente es capaz de ver y trabajar sobre los ficheros que están dentro de la jaula, y todos los ficheros que haya fuera de ella, no será capaz de verlos.

A fin de cuentas, esta jaula se monta a partir de una carpeta, (/pruebas/jaula) en la cuál un usuario verá como raíz todo lo que cuelgue de /pruebas/jaula. No tendría (en teoría) forma de acceder a /etc por ejemplo, ya que para el usuario enjaulado, su "/etc" en realidad es /pruebas/jaula/etc.

Esto tiene muchas utilidades, como por ejemplo, poder hacer pruebas sin afectar al sistema. Pero en concreto a nosotros, en nuestro proyecto, no nos sirve para hacer las pruebas. La razón es que al hacer las pruebas en local, no existe una forma (al menos, no una sencilla) de poder hacer jaulas con direcciones IP distintas cada una, por que recordamos, la jaula solo afecta al sistema de ficheros; los recursos siguen siendo todos iguales. Al no poder hacer esto, nuesta única opción para hacer pruebas en local, es levantar varias máquinas virtuales (en las cuáles cada una si que tiene su IP distinta, tal y como queremos), pero a partir de este punto, es absurdo pensar en jaulas. En caso de que una prueba afecte negativamente a una máquina virtual, tan solo tenemos que restaurar la copia de seguridad.
