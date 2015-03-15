#encodign:utf-8

def procesaSalidaEquipos(output):

    #Separamos la salida dividiendo por espacios:
    stringSpliteada=output.split(' ')

    #Sacamos el nombre del equipo:
    nombreEquipo=stringSpliteada[0]

    #Sacamos la ip del equipo:
    ipEquipo=stringSpliteada[1]
    split2=ipEquipo.split('=')
    ipEquipo=split2[1]

    #Esto no es demasiado interesante
    usuarioEquipo=stringSpliteada[2]

    listaDatos=[nombreEquipo,ipEquipo]

    return listaDatos
