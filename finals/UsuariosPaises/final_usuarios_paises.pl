/*
usuario(dni, nombre, ciudad, edad, estado).

provincia(cod_provincia, lista_ciudades).

pais(cod_pais, nombre_pais, lista de provincias).

Contar la cantidad de usuarios activos que pertenecen a un pais con mas de 20 provincias.
Ingresar un nuevos usuario y guardarlo solo si la ciudad es de Argentina y si tiene mas de 18 anios

*/

:- dynamic(usuario/5).
:- dynamic(provincia/2).
:- dynamic(pais/3).

inicio_ejercicio_1 :-
    abrir_base,
    realizar_conteo(ListaCantidades),
    write(ListaCantidades).

realizar_conteo([Cantidad|T]) :-
    pais(CodPais, _, ListaProvincias),
    contar_provincias(ListaProvincias, CantProvincias),
    CantProvincias >= 2,
    contar_usuarios_activos_provincia(ListaProvincias, Cantidad),
    retract(pais(CodPais, _, ListaProvincias)),
    realizar_conteo(T).

realizar_conteo([]).

contar_provincias([_|T], Cantidad) :-
    contar_provincias(T, CantComp),
    Cantidad is CantComp + 1.

contar_provincias([], 0).

contar_usuarios_activos_provincia([CodProvincia|T], Cantidad) :-
    provincia(CodProvincia, ListaCiudades),
    contar_usuarios_activos_ciudades(ListaCiudades, CantidadCiudad),
    retract(provincia(CodProvincia, ListaCiudades)),
    contar_usuarios_activos_provincia(T, CantidadComp),
    Cantidad is CantidadComp + CantidadCiudad.

contar_usuarios_activos_provincia([], 0).

contar_usuarios_activos_ciudades([CodCiudad|T], Cantidad) :-
    contar_usuarios_activos(CodCiudad, CantidadUsuarios),
    contar_usuarios_activos_ciudades(T, CantidadComp),
    Cantidad is CantidadComp + CantidadUsuarios.

contar_usuarios_activos_ciudades([], 0).

contar_usuarios_activos(CodCiudad, Cantidad) :-
    usuario(DniUsuario, _, CodCiudad, _, 'activo'),
    retract(usuario(DniUsuario, _, CodCiudad, _, 'activo')),
    contar_usuarios_activos(CodCiudad, CantidadComp),
    Cantidad is CantidadComp + 1.

contar_usuarios_activos(_, 0).

abrir_base :-
    retractall(usuario(_, _, _, _, _)),
    retractall(provincia(_, _)),
    retractall(pais(_, _, _)),
    consult("C:/Users/juanmanuelgentili/final_usuarios_provincias.txt").

inicio_ejercicio_2 :-
    abrir_base,
    writeln("Ingrese el nombre del usuario: "),
    read(Nombre),
    writeln("Ingrese el DNI del usuario: "),
    read(Dni),
    writeln("Ingrese la edad: "),
    read(Edad),
    writeln("Ingrese el estado: (activo/inactivo)"),
    read(Estado),
    writeln("Ingrese la ciudad del usuario: "),
    read(Ciudad),
    Edad > 18,
    ciudad_pertenece_argentina(Ciudad),
    assert(usuario(Dni, Nombre, Ciudad, Edad, Estado)),
    guardar.

ciudad_pertenece_argentina(CodCiudad) :-
    provincia(CodProvincia, ListaCiudades),
    pertenece(CodCiudad, ListaCiudades),
    pais(_, 'argentina', ListaProvincias),
    pertenece(CodProvincia, ListaProvincias).

guardar :-
    tell('C:/Users/juanmanuelgentili/final_usuarios_provincias.txt'),
    listing(usuario),
    told.




