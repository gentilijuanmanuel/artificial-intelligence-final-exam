%Final bandas

/*
Dada una BD con:
cantante(nombre_cantante,pais_origen)
album(nombre_album,nombre_cantante,[lista_temas]),fecha_edicion,copias_vendidas)
(El formato del campo fecha es dd/mm/aaaa)
1)Ingrese un álbum y una lista [] de temas y a partir de esto devolver
una lista con aquellos temas de la lista original que correspondan al
álbum ingresado.
2)Informar cuantos álbumes fueron lanzados en un determinado año (dato
de entrada) por cantantes de origen sueco.
3)Ingresar un cantante y devolver una lista con todos los albumes que
haya lanzado a lo largo de su carrera y cuya cantidad de copias supere
el mill�n. De las cosas m�s locas que hab�a en las consignas estaba el
tema de sacar la fecha(dd/mm/aaaa). Para eso hab�a que usar el predicado
sub_atom, sub_atom(fecha_edici�n,6,4,_,A�o). En la primera parte tuve
algunos errores, entre ellos usar mal el backtracking en los puntos 1, 2
y adem�s me olvide la longitud esperada para el corte cuando usaba
sub_atom. Sin embargo pase a la
teor�a, en esta instancia me hizo varias preguntas la profesora.*/

:- dynamic(cantante/2).
:- dynamic(album/5).

inicio_final_bandas :-
    writeln("Ingrese una opción: "),
    writeln("1.Ejercicio 1."),
    writeln("2. Ejercicio 2."),
    writeln("3. Ejercicio 3. "),
    writeln("4. Salir."),
    read(Opcion),
    Opcion \= 4,
    menu(Opcion).

inicio_final_bandas :- writeln("Hasta luego!").

menu(1) :-
    abrir_base,
    writeln("Ingrese un álbum: "),
    read(Album),
    writeln("Ingrese una lista de temas: "),
    leer(ListaIngresada),
    album(Album, _, ListaCanciones, _, _),
    verificar_temas(ListaCanciones, ListaIngresada, TemasCoincidentes),
    write(TemasCoincidentes).

menu(2) :-
    abrir_base,
    writeln("Ingrese un año: "),
    read(Anio),
    contar_albums(Anio, CantAlbums),
    write(CantAlbums).

menu(3) :-
    abrir_base,
    writeln("Ingrese un artista: "),
    read(Cantante),
    valida_albums(Cantante, ListaAlbumsFamosos),
    write(ListaAlbumsFamosos).

abrir_base :-
    retractall(cantante/2),
    retractall(album/5),
    consult("C:/Users/juanmanuelgentili/final_bandas.txt").

leer([H|T]) :- read(H), H \= [], leer(T).
leer([]).

verificar_temas(ListaCanciones, [Tema|T], [Tema|J]) :-
    pertenece(Tema, ListaCanciones),
    verificar_temas(ListaCanciones, T, J).

verificar_temas(ListaCanciones, [_|T], Lista) :-
    verificar_temas(ListaCanciones, T, Lista).

verificar_temas(_, _, []).

pertenece(E, [E|_]).
pertenece(E, [_|T]) :- pertenece(E, T).

contar_albums(Anio, CantAlbums) :-
    album(Nombre, Cantante, _, Fecha, Ventas),
    cantante(Cantante, 'suecia'),
    sub_atom(Fecha, _, 4, 0, Anio),
    retract(album(Nombre, Cantante, _, Fecha, Ventas)),
    contar_albums(Anio, V),
    CantAlbums is Ventas + V.

contar_albums(_, 0).

valida_albums(Cantante, [NombreAlbum|T]) :-
    album(NombreAlbum, Cantante, _, _, Ventas),
    Ventas > 1000,
    retract(album(NombreAlbum, Cantante, _, _, Ventas)),
    valida_albums(Cantante, T).

valida_albums(_, []).