/*
1- un usuario quiere saber las habitaciones dispoinibles segun una lista
de caracteristicas que ingresa(Codigos), donde se debe mostrar de
habitacion dispoonible, Descripcion y Precio por dia. Una habitacion
puede tener mas caracteristicas que las ingresadas por el usuario.
2- el gerente del hotel quiere regalarles un champan a cada habitacion
premium que se encuentre ocupada en ese momento. genere dicho informe.*/

:- dynamic(habitacion/5).
:- dynamic(caracteristica/2).

abrir_base:- retractall(caracteristica(,)), retractall(habitacion(,,,,_)), consult('C:/Users/juanmanuelgentili/final_habitaciones.txt').

menu:-abrir_base, write('1- ejercicio 1 , 2- ejercicio 2, 3-salir'), read(Op), Op\=3, ejercicio(Op), menu.
menu.

ejercicio(1):-write('Ingrese lista de caracteristicas'), leer(ListaIngresada), buscaHabitaciones2(ListaIngresada).
ejercicio(2):-writeln('Regalar champagne a las habitaciones: '), muestraPremium(ListaPremiums), write(ListaPremiums).

/*
buscaHabitaciones2(ListaIngresada):-habitacion(Nro, Desc, ListaCaract, Pre, 'disponible'), buscaCaract(ListaIngresada, ListaCaract), writeln(Desc), writeln(Pre), retract(habitacion(Nro, Desc, ListaCaract, Pre, 'disponible')), buscaHabitaciones(ListaIngresada).
buscaHabitaciones2(_).*/


buscaHabitaciones(ListaIngresada):-
	habitacion(Nro, Desc, ListaCaract, Pre, 'disponible'),
	buscaCaract(ListaIngresada, ListaCaract),
	writeln(Nro), writeln(Desc), writeln(Pre),
	fail.
buscaHabitaciones(_).

buscaCaract([H|T], Lista):-
	pertenece(H,Lista),
	buscaCaract(T, Lista).
buscaCaract([],_).


muestraHab:-habitacion(Nro,'premium', ,, 'ocupada'), writeln(Nro), fail.
muestraHab.



pertenece(E,[E|_]).
pertenece(E,[_|T]):-pertenece(E,T).

leer([H|T]):- read(H), H\=[], leer(T).
leer([]).

muestraPremium([CodHab|T]) :-
	habitacion(CodHab, _, _, Precio, 'ocupada'),
	Precio > 1000,
	retract(habitacion(CodHab, _, _, _, 'ocupada')),
	muestraPremium(T).

muestraPremium([]).
