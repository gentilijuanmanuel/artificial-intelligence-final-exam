/* Complejejidades observadas en el desarrollo de los finales. */

/* 1. Menú recursivo. */

/* Se puede pedir en todos los finales. Pistili dijo: "si van a hacerlo, háganlo bien. suma." */

menu :-
    abrir_base,
    writeln("Ingrese una opción:").
    writeln("1. Ejercicio 1."),
    writeln("2. Ejercicio 2."),
    writeln("3. Salir."),
    read(Opcion),
    Opcion \= 3,
    ejercicio(Opcion),
    menu.

menu :- writeln("Hasta luego!").

ejercicio(1) :- blabla...

ejercicio(2) :- blabla...

/* 2. Leer lista. */

/* Hay que llenar una lista que al principio viene vacía, por ende la condición de fin debe ir abajo de la que "realiza el trabajo". */

leer([H|T]) :-
    read(H),
    H \= [],
    leer(T).

leer([]).

/* 3. ¿Pertenece un elemento a una lista? */

pertenece(E, [E|_]).
pertenece(E, [_|T]) :-
    pertenece(E, T).

/* 4. ¿No pertenece un elemento a una lista? */

/* Se puede hacer con un not(pertenece(Elemento, Lista)), pero supuestamente suma más el hecho de hacer una nueva regla. */

no_pertenece(_, []).
no_pertenece(E, [H|T]) :-
    E \= H,
    no_pertenece(E, T).

/* 5. Contador: contar elementos que cumplan una determinada condición. */

/* Aparece en muchos finales. Hay dos maneras de hacerlo, contando a la ida o a la vuelta, pero siempre se usa el contador a la vuelta. */

/* Ejemplo: contar autos cuyo precio sea mayor a 500 pesos. */
/* contarAutos(Contador) */
/* Utiliza backtracking y retract: si el auto no cumple con la condición que le pedimos, desinstancia e instancia uno nuevo. */
/* Si el auto cumple con las condiciones lo borramos, para no contarlo de nuevo. */

contarAutos(Contador) :-
    auto(CodAuto, Precio),
    Precio > 500,
    retract(auto(CodAuto, Precio)),
    contarAutos(C),
    Contador is C + 1.

contarautos(0).

/* 6. Acumulador. */

/* Muy muy similar al contador. */

/* Ejemplo: azumular el precio de los autos más caros que 500 pesos. */
/* acumularPrecio(Acumulador) */
/* Utiliza backtracking y retract: si el auto no cumple con la condición que le pedimos, desinstancia e instancia uno nuevo. */
/* Si el auto cumple con las condiciones lo borramos, para no acumularlo de nuevo. */

acumularPrecio(Acumulador) :-
    auto(CodAuto, Precio),
    Precio > 500,
    retract(auto(CodAuto, Precio)),
    acumularPrecio(C),
    Acumulador is C + Precio.

acumularPrecio(0).

/* 7. Llenar una lista con hechos que cumplen una deerminada condición. */

/* La idea es ir llenando una lista (que arranca vacía) con códigos de hechos que cumplen una determinada condición. */
/* Se usa backtracking para los elementos que no cumplen, y se borran los elementos que sí cumplen para no guardarlos de nuevo. */
/* Cuestión importante: la condición de fin debe ir al final, ya que se arranca con una lista vacía. */

/* Ejemplo: guardar los códigos de los autos cuyo precio es mayor a 500. */

llenarListaAutos([CodAuto|T]) :-
    auto(CodAuto, Precio),
    Precio > 500,
    retract(auto(CodAuto, Precio)),
    llenarListaAutos(T).

llenarListaAutos([]).

/* 8. Mostrar elementos de una lista que cumplen una determinada condición. */

/* 8.1. Por medio de otra lista. */

/* Similar al caso anterior, sólo que se tiene una lista ingresada por el usuario y se deben mostrar los elementos que cumplen una condición. */
/* Se va llenando una segunda lista con los elementos seleccionados. */
/* Cuestión importante: la condición de cierre al principio, para hacerlo más performante -> de esta manera el programa se ahorra de pasar por la segunda instancia de la regla y fallar */
/* cuando la lista está vacía. */
/* Cuestión importante 2: en este caso, si falla la condición, no se necesita backtracking, sino ignorar ese auto y pasar al siguiente. */
/* Por esta razón se escribe la tercer instancia de la regla, donde se contempla el caso de que falle la segunda. */

llenarListaAutos([], []).

llenarListaAutos([CodAuto|T1], [CodAuto|T2]) :-
    auto(CodAuto, Precio),
    Precio > 500,
    retract(auto(CodAuto, Precio)),
    llenarListaAutos(T1, T2).

llenarListaAutos([_|T1], ListaSeleccionados) :-
    llenarListaAutos(T1, ListaSeleccionados).

/* 8.2  Mostrando directamente haciedo backtracking y fail. */

/* Mostrar directamente podría utilizarse en el caso de que se quisiera mostrar un atributo distinto del código del auto, por ejemplo el nombre. */
/* Ejemplo: se tienen que mostrar todos los autos (Código y precio) cuyo precio sea mayor a 500. */

mostrarAutos :-
    auto(CodAuto, Precio),
    Precio > 500,
    writeln(CodAuto),
    writeln(Precio),
    fail.

mostrarAutos.

/* 9. Dos Bases de Datos. */

/* Ocurrió en el final de las canciones y los invitados (no está en el repo, lo hice a mano).*/
/* Se tenían estos hechos: cancion(CodCancion, Nombre, Artista, Duracion, Genero) y invitado(Nombre, [lista de códigos de canciones que le gustan]). */
/* Primero se tenía que contar la cantidad total de invitados a la fiesta, y luego mostrar las canciones que le gustaban a más del 80% de los invitados */
/* Claramente, había que hacer un contador total, y luego contadores por cada canción. */
/* El problema era que, al contar la cantidad total de invitados, se debe hacer retract de los mismos, lo que dejaba a la BD sin invitados para cuando había que hacer los contadores de las canciones. */
/* Solución: una BD para canciones, una BD para invitados, con sus respectivos abrir_base_canciones, abrir_base_invitados. */
/* Cuando se tienen que contar los likes de las canciones, se abre de nuevo la base de invitados. */

/* 10. Llenar lista con elementos de una segunda lista que pertenezcan a una tercera. */

/* Esto pasó en el final de las vacunas. Se tenía una lista de vacunas ingresadas, una lista de vacunas obligatorias para le rango de edad del niño */
/* y una lista de vacunas faltantes que había que llenar con las vacunas de la segunda lista que NO estaban en la primera. */
/* Se llamaba a la lista así: buscar_vacunas_faltantes(VacunasAplicadas, VacunasAAplicar, VacunasEdad). Y luego se mostraba VacunasAAplicar. */

buscar_vacunas_faltantes(_, [], []).

buscar_vacunas_faltantes(VacunasAplicadas, [VacunaAAplicar|T], [VacunaAAplicar|K]) :-
    not(pertenece(VacunaAAplicar,VacunasAplicadas)),
    buscar_vacunas_faltantes(VacunasAplicadas, T, K).

buscar_vacunas_faltantes(VacunasAplicadas, T, [_|K]) :-
    buscar_vacunas_faltantes(VacunasAplicadas, T, K).

/* 11. Lista de listas. */

/* Aparece en el final de jardines. Dada una lista de DNI's y un código de jardín, devolver los DNI's que asistan a ese jardín. */
/* Cada jardín tiene muchas salas, las cuales tienen una lista de DNI's. */
/* El programa tiene que buscar en todas las listas de todas las salas de ese jardín. */
/* La dificultad se soluciona mostrando una lista que dentro tenga listas, una por cada sala, con los DNI's de los asistentes que se hayan ingresado. */

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

/* 12. Hacer un assert de un hecho. */

/* Lo tomaron en el último recuperatorio y Pistili aclaró que muchas veces nos centramos en estudiar finales pero no revisamos la práctica, que hay que saberla. */
/* Ejemplo: guardar un usuario cuya edad sea mayor a 18 y la ciudad pertenezca a la Argentina. */

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