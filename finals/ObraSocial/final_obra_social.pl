:- dynamic(persona/5).
:- dynamic(obraSocial/4).

menu :-
    abrir_base,
    writeln("Ingrese opción: "),
    writeln("1. Ejercicio 1."),
    writeln("2. Ejercicio 2."),
    writeln("3. Salir."),
    read(Opcion),
    Opcion \= 3,
    ejercicio(Opcion),
    menu.

menu :- writeln("Hasta luego! :)").

abrir_base :-
    retractall(persona(_, _, _, _, _)),
    retractall(obraSocial(_, _, _, _)),
    consult("C:/Users/juanmanuelgentili/final_obra_social.txt").

ejercicio(2) :-
    buscarMasDeUnaObra2.

buscarMasDeUnaObra :-
    persona(Dni, Nombre, Edad, Obra, Plan),
    retract(persona(Dni, Nombre, Edad, Obra, Plan)),
    contarCantObras(Dni, Nombre, Edad, Cant),
    Cant > 1,
    writeln(Dni),
    writeln(Nombre),
    writeln(Edad),
    buscarMasDeUnaObra.

buscarMasDeUnaObra.

contarCantObras(Dni, Nombre, Edad, Cant) :-
    persona(Dni, Nombre, Edad, Obra, Plan),
    retract(persona(Dni, Nombre, Edad, Obra, Plan)),
    contarCantObras(Dni, Nombre, Edad, C),
    Cant is C + 1.

contarCantObras(_, _, _, 1).


buscarMasDeUnaObra2 :-
    contarCantObras2(Dni, Nombre, Edad, Cant),
    Cant > 1,
    writeln(Dni),
    writeln(Nombre),
    writeln(Edad),
    buscarMasDeUnaObra2.

buscarMasDeUnaObra2.

contarCantObras2(Dni, Nombre, Edad, Cant) :-
    persona(Dni, Nombre, Edad, Obra, Plan),
    retract(persona(Dni, Nombre, Edad, Obra, Plan)),
    contarCantObras2(Dni, Nombre, Edad, C),
    Cant is C + 1.

contarCantObras2(_, _, _, 0).

