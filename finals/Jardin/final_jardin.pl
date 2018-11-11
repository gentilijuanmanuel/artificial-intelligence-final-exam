/*
Final jardines.

jardin(CodigoJ, datoqnoserv, [Tipos de Sala]
salas(CodigoJ, datosqenoserv, tipo_de_sala, [Dni Asistentes])
1 - Dada una Lista [] de Dni, y un Codigo de Jardin Devolver una Lista [] con aquellos Dni que asisten realmente al Jardin.
2 - Dada una Lista [] de Jardines, y una Lista [] de Tipos de Sala, devolver una Lista [] con los Jardines que tengan todos los tipos de sala.
*/

:- dynamic(jardin/2).
:- dynamic(sala/3).

menu :-
    abrirBase,
    writeln("Ingrese una opción: "),
    writeln("1. Ejercicio 1."),
    writeln("2. Ejercicio 2."),
    writeln("3. Salir."),
    read(Opcion),
    Opcion \= 3,
    ejercicio(Opcion).

menu :- writeln("Hasta luego! :)").

abrirBase :-
    retractall(jardin(_, _)),
    retractall(sala(_, _, _)),
    consult("C:/Users/juanmanuelgentili/final_jardines.txt").

ejercicio(1) :-
    writeln("Ingrese una lista de DNI's: "),
    leer(DniIngresados),
    writeln("Ingrese un código de jardín: "),
    read(CodJardin),
    buscarAsistentes(CodJardin, DniIngresados, ListaAsistentes),
    writeln(ListaAsistentes).

leer([H|T]) :-
    read(H),
    H \= [],
    leer(T).

leer([]).

buscarAsistentes(CodJardin, DniIngresados, [H|T]) :-
    sala(CodJardin, TipoSala, DnisSala),
    chequearPertenencia(DniIngresados, DnisSala, H),
    retract(sala(CodJardin, TipoSala, DnisSala)),
    buscarAsistentes(CodJardin, DniIngresados, T).

buscarAsistentes(_, _, []).

chequearPertenencia([], _, []).

chequearPertenencia([Dni|T], DnisSala, [Dni|J]) :-
    pertenece(Dni, DnisSala),
    chequearPertenencia(T, DnisSala, J).

chequearPertenencia([_|T], DnisSala, Lista) :-
    chequearPertenencia(T, DnisSala, Lista).

pertenece(E, [E|_]).

pertenece(E, [_|T]) :- pertenece(E, T).

ejercicio(2) :-
    writeln("Ingrese una lista de jardines: "),
    leer(ListaJardines),
    writeln("Ingrese una lista de tipos de sala: "),
    leer(ListaTiposSala),
    buscarJardines(ListaJardines, ListaTiposSala, JardinesSeleccionados),
    writeln(JardinesSeleccionados).

buscarJardines([], _, []).

buscarJardines([CodJardin|T], ListaTiposSala, [CodJardin|J]) :-
    jardin(CodJardin, TiposSalaJardin),
    contiene(TiposSalaJardin, ListaTiposSala),
    retract(jardin(CodJardin, TiposSalaJardin)),
    buscarJardines(T, ListaTiposSala, J).

buscarJardines([_|T], ListaTiposSala, Lista) :-
    buscarJardines(T, ListaTiposSala, Lista).

contiene(_, []).

contiene(TiposSalaJardin, [CodTipoSala|T]) :-
    pertenece(CodTipoSala, TiposSalaJardin),
    contiene(TiposSalaJardin, T).
