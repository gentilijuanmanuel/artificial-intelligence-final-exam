
/*
08-03-2018
niño(nombre, edad, [vacunas_aplicadas])
vacunas_edad(edad_desde, edad_hasta, [vacunas_a_aplicarse])
vacuna(nombre, [enfermedad_previene])
1. Ingrese el nombre de un niño y segun su edad, mostrar una lista de
las vacunas que faltan aplicarse
2. Ingresar una vacuna y mostrar una lista de las enfermedades que
previene.
*/

:- dynamic(nino/3).
:- dynamic(vacunas_edad/3).
:- dynamic(vacuna/2).

inicio_ejercicio_1 :-
    abrir_base,
    writeln("Ingrese un nombre: "),
    read(Nombre),
    nino(Nombre, Edad, VacunasAplicadas),
    chequear_vacunas(Edad, VacunasAplicadas, VacunasAAplicar),
    writeln(VacunasAAplicar).

abrir_base :-
    retractall(nino(_, _, _)),
    retractall(vacunas_edad(_, _, _)),
    retractall(vacuna(_, _)),
    consult("C:/Users/juanmanuelgentili/final_vacunas.txt").

chequear_vacunas(EdadNino, VacunasAplicadas, VacunasAAplicar) :-
    vacunas_edad(EdadDesde, EdadHasta, VacunasEdad),
    EdadNino >= EdadDesde,
    EdadNino < EdadHasta,
    buscar_vacunas_faltantes(VacunasAplicadas, VacunasAAplicar, VacunasEdad).

buscar_vacunas_faltantes(VacunasAplicadas, [VacunaAAplicar|T], [VacunaAAplicar|K]) :-
    not(pertenece(VacunaAAplicar,VacunasAplicadas)),
    buscar_vacunas_faltantes(VacunasAplicadas, T, K).

buscar_vacunas_faltantes(VacunasAplicadas, T, [_|K]) :-
    buscar_vacunas_faltantes(VacunasAplicadas, T, K).

buscar_vacunas_faltantes(_, [], []).

pertenece(E, [E|_]).
pertenece(E, [_|T]) :- pertenece(E, T).

inicio_ejercicio_2 :-
    abrir_base,
    writeln("Ingresar una vacuna: "),
    read(Vacuna),
    vacuna(Vacuna, Enfermedades),
    writeln(Enfermedades).
