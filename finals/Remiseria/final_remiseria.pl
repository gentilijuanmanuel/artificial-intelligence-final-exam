/*
Si no recuerdo mal fue de una remiser�a. Era algo as�:
auto(nro_movil, patente, un par de cosas mas)
viaje(nro_movil, costo)
Y te ped�an:
1. Monto total acumulado por cada auto
2. Dada una lista de autos devolver de esa lista cuales tenian al menos
un viaje con costo mayor a 300.
*/

:- dynamic(auto/2).
:- dynamic(viaje/2).

inicio_ejercicio_1 :-
    abrir_base,
    writeln("El monto total acumulado por cada auto es: "),
    calcular_montos.

abrir_base :-
    retractall(auto(_, _)),
    retractall(viaje(_, _)),
    consult("C:/Users/juanmanuelgentili/final_remiseria.txt").

calcular_montos :-
    auto(CodAuto, Patente),
    acumulador(CodAuto, Monto),
    retract(auto(CodAuto, Patente)),
    writeln("Patente: "),
    writeln(Patente),
    writeln("Monto acumulado: "),
    writeln(Monto),
    calcular_montos.

calcular_montos.

acumulador(CodAuto, Monto) :-
    viaje(CodAuto, Costo),
    retract(viaje(CodAuto, Costo)),
    acumulador(CodAuto, MontoComp),
    Monto is MontoComp + Costo.

acumulador(_, 0).

inicio_ejercicio_2 :-
    abrir_base,
    writeln("Ingrese una lista de autos: "),
    leer(ListaAutos),
    buscar_autos_costo(ListaAutos, ListaSeleccionados),
    writeln(ListaSeleccionados).

leer([H|T]) :- read(H), H \= [], leer(T).
leer([]).

buscar_autos_costo([CodAuto|T], [CodAuto|K]) :-
    buscar_viaje_costo(CodAuto),
    buscar_autos_costo(T, K).

buscar_autos_costo([_|T], K) :- buscar_autos_costo(T, K).

buscar_autos_costo([], []).

buscar_viaje_costo(CodAuto) :-
    viaje(CodAuto, Costo),
    retract(viaje(CodAuto, Costo)),
    Costo > 200.



