#encodign:utf-8

# VISTAS !!!!!


from django.template.loader import get_template
from django.template import Context
from django.http import HttpResponse
from django.shortcuts import render_to_response
import datetime
#Para ejecutar ordenes del sistema.
import os
import subprocess
import commands
from funcionesExtra import *

def index(request):
    ahora = datetime.datetime.now()
    t = get_template('index.html')
    #Haciendo Context establezco una variable para que coja los datos la plantilla detail.html
    html = t.render(Context({'fecha_actual': ahora}))
    return HttpResponse(html)


def funciones(request):
    ahora = datetime.datetime.now()
    t = get_template('funciones.html')
    #Haciendo Context establezco una variable para que coja los datos la plantilla detail.html
    html = t.render(Context({'fecha_actual': ahora}))
    return HttpResponse(html)


def mostrarEquiposConectados(request):
    '''
        En esta funcion se llamara al script de ansible que comprueba la conectividad de las maquinas.
    '''
    # -c :> lista hosts
#    output = subprocess.call(['ls', '-l'])
    output=commands.getoutput("/usr/bin/LDT2.sh -c")

    salida=procesaSalidaEquipos(output)

    t = get_template('mostrarEquiposConectados.html')
    #lista es el nombre de la variable y salida la variable real.
    html = t.render(Context({'listaDatos': salida}))
    return HttpResponse(html)



def mostrarOcupacionDisco(request):
    output="85%"
    t = get_template('mostrarOcupacionDisco.html')
    html=t.render(Context({'dato':output}))
    return HttpResponse(html)




#Funcion para realizar el ping!

def ping(request):

    ip = request.GET.get('ip')
    ping="ping "+ip+" -c 2"
    output=commands.getoutput(ping)
    tamCadena=len(output)
    pos=output.find("statistics")
    output=output[pos:tamCadena]

    t=get_template('ping.html')
    html=t.render(Context({'salida':output}))
    return HttpResponse(html)
