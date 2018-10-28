%Practice 2

%Exercise 1

inicio_ejercicio_1 :-
    write("Ingrese una lista: "),
    leer(Lista),
    write(Lista).

leer([H|T]) :- read(H), H\=[], leer(T).
leer([]).

%Exercise 2

inicio_ejercicio_2 :-
    write("Ingrese una lista: "),
    leer([H|T]),
    write("La cabeza es: "),
    write(H),
    nl,
    write("La cola es: "),
    write(T).

%Exercise 3

inicio_ejercicio_3 :-
    write("Ingrese una lista: "),
    leer([H|_]),
    write("El primer elemento es: "),
    write(H).

%Exercise 4

inicio_ejercicio_4 :-
    write("Ingrese una lista: "),
    leer([H|T]),
    write("El primer elemento es: "),
    write(H),
    nl,
    obtener_segundo_elemento(T).

obtener_segundo_elemento([Y|_]) :-
    write("El segundo elemento es: "),
    write(Y).

%Exercise 5

inicio_ejercicio_5 :-
    write("Ingrese una lista: "),
    leer(Lista),
    obtener_ultimo_elemento(Lista).

obtener_ultimo_elemento([H|T]) :-
    T = [],
    write("El ultimo elemento es: "),
    write(H).

obtener_ultimo_elemento([_|T]) :-
    obtener_ultimo_elemento(T).


%Ejercicio 6

inicio_ejercicio_6 :-
    write("Ingrese una lista: "),
    nl,
    leer([Primero|T]),
    nl,
    calcular_diferencia(Primero, T).

calcular_diferencia(Primero, [H|T]) :-
    T = [],
    write("La diferencia es: "),
    Diferencia is Primero - H,
    write(Diferencia).

calcular_diferencia(Primero, [_|T]) :-
    calcular_diferencia(Primero, T).


