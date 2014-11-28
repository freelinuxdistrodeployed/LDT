---
layout:     post
title:      "Consideraciones sobre SSH"
subtitle:   "Las decisiones previas"
date:       2014-11-3 12:00:00
author:     "JuanAFernandez"
header-img: "img/post-bg-06.jpg"
---

#Decisiones de Seguridad con SSH

##1. Puerto por defecto
SSH usa el puerto 22 por defecto. Aunque no es una medida de seguridad alta, sería recomendable cambiarlo por otro para al menos dificultar un poco más la tarea a un posible intruso.

##2. Clave pública
Hemos generado la clave pública del servidor de forma genérica, pero hay otras posibilidades que mejoran la seguridad.