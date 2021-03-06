%Final Vehículos

/*
 * Base de hechos
veh�culo (Cod,...,[Caracter�sticas]).
caracter�sticas puede ser A/C, levanta vidrios,etc
ventas(CodVeh, Fecha....).
Fecha tiene formato dd/mm/aaaa
1)Ingresar una caracter�stica y devolver una lista [] con los c�digos de todos los autos que tengan esa caracter�stica.
2)Ingresar una lista [] de c�digos de auto y un A�o y armar una nueva lista [] con los c�digos de esos autos, que tengan m�s de 10 ventas.
*
*/

:- dynamic(vehiculo/3).
:- dynamic(venta/2).

inicio_final_vehiculos :-
    writeln("Ingrese una opcion: "),
    writeln("1. Autos con una característica."),
    writeln("2. Ventas en un año y de un auto específico."),
    writeln("3. Salir"),
    read(Opcion),
    Opcion \= 3,
    menu(Opcion).

inicio_final_vehiculos :- writeln("Hasta luego!").

menu(1) :-
    abrir_base,
    writeln("Ingrese una característica: "),
    read(Caract),
    buscar_autos(Caract, Autos),
    writeln(Autos).

menu(2) :-
    abrir_base,
    writeln("Ingrese un año: "),
    read(Anio),
    writeln("Ingrese una lista de autos: "),
    leer(ListaBusca),
    iterar_autos(ListaBusca, Anio, ListaVendidos),
    write(ListaVendidos).

abrir_base :-
    retractall(vehiculo/3),
    retractall(venta/2),
    consult("C:/Users/juanmanuelgentili/final_vehiculos.txt").

buscar_autos(Caract, [H|T]) :-
    vehiculo(H, _, ListaCaract),
    pertenece(Caract, ListaCaract),
    retract(vehiculo(H, _, ListaCaract)),
    buscar_autos(Caract, T).

buscar_autos(_, []).

pertenece(E, [E|_]).
pertenece(E, [_|T]) :- pertenece(E, T).

leer([H|T]) :- read(H), H \= [], leer(T).
leer([]).

iterar_autos([Cod|T], Anio, [Cod|K]) :-
    contar_ventas(Cod, Anio, Cant),
    Cant > 4,
    iterar_autos(T, Anio, K).

iterar_autos([_|T], Anio, Lista) :- iterar_autos(T, Anio, Lista).

iterar_autos(_, _, []).

contar_ventas(Cod, Anio, Cant) :-
    venta(Cod, Fecha),
    sub_atom(Fecha, _, 4, 0, Anio),
    retract(venta(Cod, Fecha)),
    contar_ventas(Cod, Anio, CantComp),
    Cant is CantComp + 1.

contar_ventas(_, _, 0).

