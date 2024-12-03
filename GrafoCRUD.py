import mysql.connector
mydb = mysql.connector.connect(user="root", password="", port=3306,
                        host="localhost", database="grafos", 
                                   auth_plugin = "mysql_native_password")
Cursor = mydb.cursor()
    
def menu():
    print("Seleccione una opción:")
    print("1. Insertar Ciudad")
    print("2. Insertar Conexión")
    print("3. Consultar Ciudades")
    print("4. Consultar Conexiones de Ciudad")
    print("5. Actualizar Ciudad")
    print("6. Actualizar Conexión")
    print("7. Eliminar Ciudad")
    print("8. Eliminar Conexión")
    print("0. Salir")

    opcion = input("Opción: ")

    if opcion == "1":
        nombre = input("Ingrese el nombre de la ciudad: ")
        InsertarCiudad(nombre)
    elif opcion == "2":
        origen = input("Ingrese la ciudad de origen: ")
        destino = input("Ingrese la ciudad de destino: ")
        InsertarConexion(origen, destino)
    elif opcion == "3":
        ConsultarCiudades()
    elif opcion == "4":
        ciudad = input("Ingrese el nombre de la ciudad: ")
        ConsultarConexionesCiudad(ciudad)
    elif opcion == "5":
        id_ciudad = int(input("Ingrese el ID de la ciudad a actualizar: "))
        nuevo_nombre = input("Ingrese el nuevo nombre de la ciudad: ")
        ActualizarCiudad(id_ciudad, nuevo_nombre)
    elif opcion == "6":
        id_conexion = int(input("Ingrese el ID de la conexión a actualizar: "))
        origen = input("Ingrese la ciudad de origen: ")
        destino = input("Ingrese la ciudad de destino: ")
        ActualizarConexion(id_conexion, origen, destino)
    elif opcion == "7":
        id_ciudad = int(input("Ingrese el ID de la ciudad a eliminar: "))
        EliminarCiudad(id_ciudad)
    elif opcion == "8":
        id_conexion = int(input("Ingrese el ID de la conexión a eliminar: "))
        EliminarConexion(id_conexion)
    elif opcion == "0":
        print("Saliendo...")
        exit()

def InsertarCiudad(nombre):
    Cursor.callproc("InsertarCiudad", (nombre,))
    mydb.commit()
    print(f"Ciudad '{nombre}' insertada con éxito.")
    Cursor.close()
    mydb.close()

def InsertarConexion(origen, destino):
    Cursor.callproc("InsertarConexion", (origen, destino))
    mydb.commit()
    print(f"Conexión entre '{origen}' y '{destino}' insertada con éxito.")
    Cursor.close()
    mydb.close()

def ConsultarCiudades():
    Cursor.callproc("ConsultarCiudades")
    for result in Cursor.stored_results():
        for fila in result.fetchall():
            print(f"Ciudad: {fila[0]}")
    Cursor.close()
    mydb.close()

def ConsultarConexionesCiudad(ciudad):
    Cursor.callproc("ConsultarConexionesCiudad", (ciudad,))
    for result in Cursor.stored_results():
        for fila in result.fetchall():
            print(f"Conexión: {fila[0]} -> {fila[1]}")
    Cursor.close()
    mydb.close()

def ActualizarCiudad(id_ciudad, nuevo_nombre):
    Cursor.callproc("ActualizarCiudad", (id_ciudad, nuevo_nombre))
    mydb.commit()
    print(f"Ciudad con ID {id_ciudad} actualizada a '{nuevo_nombre}'.")
    Cursor.close()
    mydb.close()

def ActualizarConexion(id_conexion, origen, destino):
    Cursor.callproc("ActualizarConexion", (id_conexion, origen, destino))
    mydb.commit()
    print(f"Conexión con ID {id_conexion} actualizada a: '{origen}' -> '{destino}'.")
    Cursor.close()
    mydb.close()

def EliminarCiudad(id_ciudad):
    Cursor.callproc("EliminarCiudad", (id_ciudad,))
    mydb.commit()
    print(f"Ciudad con ID {id_ciudad} eliminada.")
    Cursor.close()
    mydb.close()

def EliminarConexion(id_conexion):
    Cursor.callproc("EliminarConexion", (id_conexion,))
    mydb.commit()
    print(f"Conexión con ID {id_conexion} eliminada.")
    Cursor.close()
    mydb.close()