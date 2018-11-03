/*
2018 Promocion
1. Ingresar un usuario, y devolver una lista de todos los NO amigos del
usuario ingresado, que sean de la misma ciudad y tengan mas de 42 años
2. Ingresar una LISTA de usuarios, y devolver otra LISTA de usuarios que
tengan como amigos a todos los usuarios de la lista INGRESADA.
Tip: Suma puntos extra si creas una funcion propia llamada no_pertenece
Tambien se podria usar not(pertenece).
*/

:-dynamic(usuario/4).

inicio_ejercicio_1 :-
    abrir_base,
    writeln("Ingrese un usuario: "),
    read(Usuario),
    usuario(Usuario, _, Ciudad, ListaAmigos),
    buscar_no_amigos(ListaAmigos, ListaNoAmigos, Ciudad, Usuario),
    writeln(ListaNoAmigos).

abrir_base :-
    retractall(usuario(_, _, _, _)),
    consult("C:/Users/juanmanuelgentili/final_usuarios.txt").

buscar_no_amigos(ListaAmigos, [CodUsuario|K], CiudadUsuario, CodUsuarioComp) :-
    usuario(CodUsuario, Edad, CiudadUsuario, _),
    CodUsuario \= CodUsuarioComp,
    Edad > 42,
    not(pertenece(CodUsuario, ListaAmigos)),
    retract(usuario(CodUsuario, Edad, CiudadUsuario, _)),
    buscar_no_amigos(ListaAmigos, K, CiudadUsuario, CodUsuarioComp).

buscar_no_amigos(_, [], _, _).

pertenece(E, [E|_]).
pertenece(E, [_|T]) :- pertenece(E, T).

no_pertenece(_, []).
no_pertenece(E, [H|T]) :- E\=H, pertenece(E, T).

inicio_ejercicio_2 :-
    abrir_base,
    writeln("Ingrese una lista de usuarios: "),
    leer(UsuariosIngresados),
    buscar_usuarios(UsuariosIngresados, UsuariosConAmigos),
    writeln(UsuariosConAmigos).

leer([H|T]) :- read(H), H\=[], leer(T).
leer([]).

buscar_usuarios(UsuariosIngresados, [UsuarioConAmigos|K]) :-
    usuario(UsuarioConAmigos, _, _, ListaAmigos),
    pertenece_lista(UsuariosIngresados, ListaAmigos),
    retract(usuario(UsuarioConAmigos, _, _, ListaAmigos)),
    buscar_usuarios(UsuariosIngresados, K).

buscar_usuarios(_, []).

pertenece_lista([CodUsuario|T], ListaAmigos) :-
    pertenece(CodUsuario, ListaAmigos),
    pertenece_lista(T, ListaAmigos).

pertenece_lista([], _).





