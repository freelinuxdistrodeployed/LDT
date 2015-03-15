from django.conf.urls.defaults import patterns, include, url
from django.conf import settings
#Importamos la funcion que hemos definido en el fichero views.py
from prueba.views import *

# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()

'''
Lo principal es la variable urlpatterns, Django espera encontrar en el modulo ROOT_URLCONFIG. Esta variable define el
mapeo entre las URLs y el codigo que maneja esas URLs. Todo lo que esta en URLconf esta comentado, la apliacion DJango es
una pizarra en blanco.
'''

urlpatterns = patterns('',

    (r'^index/$', index),
    (r'^funciones/$', funciones),
    (r'^mostrarEquiposConectados/$', mostrarEquiposConectados),
    (r'^mostrarOcupacionDisco/$', mostrarOcupacionDisco),
    (r'^ping/$', ping),
    # Examples:
    # url(r'^$', 'prueba.views.home', name='home'),
    # url(r'^prueba/', include('prueba.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    # url(r'^admin/', include(admin.site.urls)),
)
