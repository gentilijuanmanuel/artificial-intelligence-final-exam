/* Pr�ctica Dada una BD con los siguientes hechos
orden(nro_orden, fecha, cliente).
producto(codigo, descripcion, cant_en_stock).
orden_producto(nro_orden, codigo, cantidad_solicitada).

1) Se ingresa una lista [] de codigos de producto. Determinar a trav�s de una nueva lista [] de todos ellos cuales no tienen suficiente stock para cubrir los pedidos presentes en las �rdenes.
2)Mostrar en una lista todos aquellos productos que hayan sido solicitado en 5 o m�s �rdenes.
3) Para un cliente (dato de entrada), determinar si posee dos o m�s �rdenes en un mismo mes y a�o.*/

:- dynamic(orden/3).
:- dynamic(producto/3).
:- dynamic(orden_producto/3).

inicio_ejercicio_1 :-
    abrir_base,
    writeln("Ingrese una lista de productos: "),
    leer(ListaProductos),
    buscar_productos_stock(ListaProductos, ListaProdStock),
    writeln("Los prod que no tienen suficiente stock son:"),
    write(ListaProdStock).

abrir_base :-
    retractall(orden(_, _, _)),
    retractall(producto(_, _, _)),
    retractall(orden_producto(_, _, _)),
    consult("C:/Users/juanmanuelgentili/final_productos.txt").

leer([H|T]) :- read(H), H\=[], leer(T).
leer([]).

buscar_productos_stock([CodProd|T], [CodProd|K]) :-
    producto(CodProd, _, CantStock),
    calcular_pedidos(CodProd, Cant),
    CantStock < Cant,
    retract(producto(CodProd, _, CantStock)),
    buscar_productos_stock(T, K).

buscar_productos_stock([_|T], K) :-
    buscar_productos_stock(T, K).

buscar_productos_stock([], _).

calcular_pedidos(CodProd, Cant) :-
    orden_producto(NroOrden, CodProd, Cantidad),
    retract(orden_producto(NroOrden, CodProd, Cantidad)),
    calcular_pedido(CodProd, CantComp),
    Cant is Cantidad + CantComp.

calcular_pedidos(_, 0).

inicio_ejercicio_2 :-
    buscar_productos_solicitados(ListaProdSolicitados),
    write(ListaProdSolicitados).

buscar_productos_solicitados([CodProd|T]) :-
    calcular_cant_ordenes(CodProd, Cant),
    Cant >= 5,
    buscar_productos_solicitados(T).

%A Mica le faltó esta línea:
buscar_productos_solicitados([_|T]) :-
    buscar_productos_solicitados(T).

buscar_productos_solicitados([]).

calcular_cant_ordenes(CodProd, Cant) :-
    orden_producto(NroOrden, CodProd, _),
    retract(orden_producto(NroOrden, CodProd, _)),
    calcular_cant_ordenes(CodProd, CantComp),
    Cant is CantComp + 1.

calcular_cant_ordenes(_, 0).

inicio_ejercicio_3 :-
    writeln("Ingrese el nombre del cliente: "),
    read(Cliente),
    buscar_ordenes(Cliente).

buscar_ordenes(Cliente) :-
    cant_ordenes(Cliente, _, Cant),
    Cant > 2,
    writeln("El cliente posee más de dos órdenes con mes y año igual").

buscar_ordenes(_) :-
    writeln("El cliente no posee más de dor órdenes con mes y año iguales.").

cant_ordenes(Cliente, MesAnio, Cant) :-
    orden(NroOrden, FechaOrden, Cliente),
    sub_atom(FechaOrden, _, 7, 0, MesAnio),
    retract(orden(NroOrden, FechaOrden, Cliente)),
    cant_ordenes(Cliente, MesAnio, CantComp),
    CantComp is Cant + 1.

cant_ordenes(_, _, 0).
