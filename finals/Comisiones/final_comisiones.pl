/*Los ... son datos que no eran relevantes para el desarrollo del ejercicio):

catedra(nombre_catedra,...).
comision(nombre_catedra,comision,ciclo,...,[legajos de inscriptos]).
alumno(legajo,nombre,...).

* Aclaracion: una catedra puede tener muchas comisiones *

Te pedia:
1- Devolver lista [] de las catedras del ciclo 2017 que tengan m�s de 100 inscriptos en sus comisiones.
2- Mostrar las catedras en las que se encuentra inscripto un alumno
(ingresando el legajo) tambien en el ciclo 2017.*/

:- dynamic(catedra/2).
:- dynamic(comision/4).
:- dynamic(alumno/2).

inicio_final_comisiones :-
    writeln("Ingrese una opción: "),
    writeln("1. Cátedras del ciclo 2017 que tengan más de 100 inscriptos."),
    writeln("2. Cátedras en las que se encuentra inscripto un alumno en el ciclo 2017."),
    read(Opcion),
    Opcion < 3,
    menu(Opcion).

inicio_final_comisiones :-
    writeln("Hasta luego!").

menu(1) :-
    abrir_base,
    writeln("La lista de las cátedras del ciclo 2017 que tienen más de 100 inscriptos son: "),
    buscar_catedras(ListaCatedras),
    writeln(ListaCatedras).

menu(2) :-
    abrir_base,
    writeln("Ingrese un legajo: "),
    read(Legajo),
    buscar_catedras_alumno(Legajo, ListaCatedras),
    write(ListaCatedras).

abrir_base :-
    retractall(catedra/2),
    retractall(comision/4),
    retractall(alumno/2),
    consult("C:/Users/juanmanuelgentili/final_comisiones.txt").

buscar_catedras([Catedra|T]) :-
    catedra(Catedra, _),
    calcular_inscriptos(Catedra, CantInscriptos),
    CantInscriptos >= 4,
    retract(catedra(Catedra, _)),
    buscar_catedras(T).

buscar_catedras([]).

calcular_inscriptos(Catedra, CantInscriptos) :-
    comision(Catedra, _, 2017, ListaInscriptos),
    contador_comision(ListaInscriptos, Contador),
    retract(comision(Catedra, _, 2017, ListaInscriptos)),
    calcular_inscriptos(Catedra, CantInscriptosComp),
    CantInscriptos is CantInscriptosComp + Contador.

calcular_inscriptos(_, 0).

contador_comision([_|T], Contador) :-
    contador_comision(T, ContadorComp),
    Contador is ContadorComp + 1.

contador_comision([], 0).

buscar_catedras_alumno(Legajo, [Catedra|T]) :-
    comision(Catedra, Comision, 2017, ListaLegajos),
    pertenece(Legajo, ListaLegajos),
    retract(comision(Catedra, Comision, 2017, ListaLegajos)),
    retract(catedra(Catedra, _)),
    buscar_catedras_alumno(Legajo, T).

buscar_catedras_alumno(_, []).

pertenece(E, [E|_]).

pertenece(E, [_|T]) :- pertenece(E, T).

