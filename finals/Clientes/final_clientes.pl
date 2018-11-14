/*
Cliente(dni,nombre,obrasocial).

Practica(cod,medico,fecha,dnicliente,asistio).


Ingresar un dni y buscar si el cliente, entre todas sus practicas, falto mas de un 80% y asi escribir si es posible que falte o no.
Si no hay practicas registradas para ese cliente informar que no hay datos suficientes para saberlo.
*/

:- dynamic(cliente/3).
:- dynamic(practica/5).

menu :-
    abrirBase,
    writeln("Ingrese una opción: "),
    writeln("1. Ejercicio 1."),
    writeln("2. Salir."),
    read(Opcion),
    Opcion \= 2,
    ejercicio(Opcion),
    menu.

menu :- writeln("Hasta luego! :)").

abrirBase :-
    retractall(cliente(_, _, _)),
    retractall(practica(_, _, _, _, _)),
    consult("C:/Users/juanmanuelgentili/final_clientes.txt").

ejercicio(1) :-
    writeln("Ingrese un cliente: "),
    read(Dni),
    /* en caso de que pidan validar si el DNI se encuentra en la BD, busco, sino paja. */
    contarPracticas(Dni, CantPracticas),
    CantPracticas > 0,
    abrirBase,
    predecirAsistencia(Dni, CantPracticas).

ejercicio(1) :-
    writeln("No se poseen los datos suficientes para predecir").

contarPracticas(Dni, Cantidad) :-
    practica(Cod, _, _, Dni, _),
    retract(practica(Cod, _, _, Dni, _)),
    contarPracticas(Dni, C),
    Cantidad is C + 1.

contarPracticas(_, 0).

predecirAsistencia(Dni, CantPracticas) :-
    contarFaltas(Dni, CantFaltas),
    (CantFaltas / CantPracticas) >= 0.8,
    writeln("No asistirá!").

predecirAsistencia(_, _) :- writeln("Asistirá!").

contarFaltas(Dni, Cantidad) :-
    practica(Cod, _, _, Dni, 'no'),
    retract(practica(Cod, _, _, Dni, 'no')),
    contarFaltas(Dni, C),
    Cantidad is C + 1.

contarFaltas(_, 0).
