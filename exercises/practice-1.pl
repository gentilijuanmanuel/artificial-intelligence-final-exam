%Practice 1: Basis concepts

%Exercise 1

observa(maria,omar).
observa(laura,omar).
observa(maria,flavio).
observa(gabriela,flavio).
observa(maria,carlos).

%Exercise 2

conoce(franco,ingles).
conoce(renzo,ingles).
conoce(franco,frances).
conoce(renzo,frances).
conoce(franco,italiano).
conoce(marco,ingles).
conoce(omar,ingles).
conoce(maria,frances).

conoce_frances_e_ingles(X) :-
    conoce(X, ingles),
    conoce(X, frances).

%Exercise 3

pertenece(brasil, grupo1).
pertenece(espana, grupo1).
pertenece(jamaica, grupo1).
pertenece(italia, grupo1).
pertenece(argentina, grupo2).
pertenece(nigeria, grupo2).
pertenece(holanda, grupo2).
pertenece(escocia, grupo2).

son_rivales(X, Y) :-
    pertenece(X, Grupo),
    pertenece(Y, Grupo),
    X \= Y.

% Nota: pulsando espacio en vez de enter, se pueden tener todas las
% respuestas.

%Exercise 4

hombre(oscar).
hombre(juan).
hombre(narciso).
hombre(leopoldo).
mujer(victoria).
mujer(ana).
mujer(nelly).
mujer(clotilde).
mujer(isabel).
padres(juan, ana, oscar).
padres(victoria, ana, oscar).
padres(ana, nelly, narciso).
padres(isabel, nelly, narciso).
padres(oscar, clotilde, leopoldo).

hermana(A, B) :-
    mujer(A),
    A \= B,
    padres(A, M, P),
    padres(B, M, P).

nieto(A, B) :-
    hombre(A),
    A \= B,
    padres(A, _, P),
    padres(P, _, B).

nieto(A, B) :-
    hombre(A),
    A \= B,
    padres(A, _, P),
    padres(P, B, _).

nieto(A, B) :-
    hombre(A),
    A \= B,
    padres(A, M, _),
    padres(M, _, B).

nieto(A, B) :-
    hombre(A),
    A \= B,
    padres(A, M, _),
    padres(M, B, _).


abuelo(A, B) :-
    hombre(A),
    A \= B,
    padres(P, _, A),
    padres(B, _, P).

abuelo(A, B) :-
    hombre(A),
    A \= B,
    padres(M, _, A),
    padres(B, M, _).

tia(A, B) :-
    mujer(A),
    padres(B, M, _),
    A \= M,
    padres(M, Y, Z),
    padres(A, Y, Z).

tia(A, B) :-
    mujer(A),
    padres(B, _, P),
    A \= P,
    padres(P, Y, Z),
    padres(A, Y, Z).

%Otra forma de resolver tía de parte de madre: usando la regla hermana.

% Exercise 5

%auto(patente, propietario)
auto(hti687,pedro).
auto(jug144,juan).
auto(gqm758,pedro).
auto(lod445,carlos).
auto(lfz569,miguel).
auto(axk798,maria).

% deuda(patente, monto adeudado)
deuda(lfz569,2000).
deuda(gqm758,15000).
deuda(axk798,1000).

inicio_ejercicio_5 :-
    write("Ingrese un nombre: "),
    nl,
    read(Nombre),
    tiene_deuda(Nombre, Deuda),
    write(Deuda).

tiene_deuda(Nombre, Deuda) :-
    auto(Patente, Nombre),
    deuda(Patente, Deuda).

%Exercise 6

vive(carolina, rosario).
vive(jose, rosario).
vive(miguel, funes).
vive(mariano, rosario).
vive(silvia, funes).
vive(eduardo, roldan).
vive(diego, casilda).
vive(laura, rosario).
vive(mauro, funes).

toca(carolina, guitarra).
toca(jose, guitarra).
toca(miguel, guitarra).
toca(mariano, canto).
toca(silvia, canto).
toca(eduardo, bateria).
toca(diego, bateria).
toca(laura, bateria).
toca(mauro, canto).

hay_banda(Ciudad) :-
    toca(Guitarrista, guitarra),
    vive(Guitarrista, Ciudad),
    toca(Baterista, bateria),
    vive(Baterista, Ciudad),
    toca(Cantante, canto),
    vive(Cantante, Ciudad).

%Exercise 7

inicio_ejercicio_7 :-
    write("Ingrese un numero: "),
    nl,
    read(Numero1),
    nl,
    write("Ingrese otro numero: "),
    nl,
    read(Numero2),
    nl,
    write("Ingrese una opcion: "),
    nl,
    write("1. Suma."),
    nl,
    write("2. Resta."),
    nl,
    write("3. Multiplicacion."),
    nl,
    write("4. Division."),
    nl,
    read(Opcion),
    nl,
    realizar_operacion(Opcion, Numero1, Numero2, Resultado),
    write(Resultado).

realizar_operacion(1, Numero1, Numero2, Resultado) :-
    Resultado is Numero1 + Numero2.

realizar_operacion(2, Numero1, Numero2, Resultado) :-
    Resultado is Numero1 - Numero2.

realizar_operacion(3, Numero1, Numero2, Resultado) :-
    Resultado is Numero1 * Numero2.

realizar_operacion(4, Numero1, Numero2, Resultado) :-
    Resultado is Numero1 / Numero2.

%Exercise 8

horoscopo(acuario, 20, 1, 18, 2).
horoscopo(piscis, 19, 2, 20, 3).
horoscopo(aries, 21, 3, 19, 4).
horoscopo(tauro, 20, 4, 20, 5).
horoscopo(geminis, 21, 5, 20, 6).
horoscopo(cancer, 21, 6, 22, 7).
horoscopo(leo, 23, 7, 22, 8).
horoscopo(virgo, 23, 8, 22, 9).
horoscopo(libra, 23, 9, 22, 10).
horoscopo(escorpio, 23, 10, 21, 11).
horoscopo(sagitario, 22, 11, 21, 12).
horoscopo(capricornio, 22, 12, 19, 1).

%a) y b)

signo(Dia, Mes, Signo) :-
    horoscopo(Signo, DiaInicio, MesInicio, _, _),
    Mes = MesInicio,
    Dia >= DiaInicio.

signo(Dia, Mes, Signo) :-
    horoscopo(Signo, _, _, DiaFin, MesFin),
    Mes = MesFin,
    Dia =< DiaFin.

%Exercise 9

hijo(juan,miguel).
hijo(jose,miguel).
hijo(miguel,roberto).
hijo(julio,roberto).
hijo(roberto,carlos).

descendiente(A, B) :- hijo(A, B).

descendiente(A, B) :- hijo(A, C), descendiente(C, B).

%Exercise 10

es_predecesora(a, c).
es_predecesora(b, d).
es_predecesora(b, f).
es_predecesora(c, d).
es_predecesora(d, e).
es_predecesora(f, g).
es_predecesora(e, h).
es_predecesora(e, i).
es_predecesora(h, j).
es_predecesora(i, j).
es_predecesora(g, j).

requiere_de(X, Y) :- es_predecesora(X, Y).

requiere_de(X, Y) :-
    es_predecesora(H, Y),
    requiere_de(X, H).

%Exercise 11

inicio_ejercicio_11 :-
    write("Ingrese un número: "),
    nl,
    read(Numero),
    factorial(Numero, Factorial),
    write("El factorial es: "),
    write(Factorial).

factorial(0, 1).

factorial(Numero, Factorial) :-
    X is Numero - 1,
    factorial(X, FactorialComp),
    Factorial is Numero * FactorialComp.

%Exercise 12

inicio_ejercicio_12 :-
    write("Ingrese un número: "),
    nl,
    read(Numero),
    sumatoria(Numero, Sumatoria),
    write("La sumatoria es: "),
    write(Sumatoria).

sumatoria(0, 0).

sumatoria(Numero, Sumatoria) :-
    X is Numero - 1,
    sumatoria(X, SumatoriaComp),
    Sumatoria is Numero + SumatoriaComp.

%Ejercicio 13

inicio_ejercicio_13 :-
    write("Ingrese un número: "),
    nl,
    read(Numero),
    sumatoria_pares_impares(Numero, SumPares, SumImpares),
    write("La sumatoria de números pares es: "),
    write(SumPares),
    nl,
    write("La sumatoria de números impares es: "),
    write(SumImpares).

sumatoria_pares_impares(0, 0, 0).

sumatoria_pares_impares(Numero, SumPares, SumImpares) :-
    X is Numero - 1,
    0 is Numero mod 2,
    sumatoria_pares_impares(X, SumParesComp, SumImpares),
    SumPares is Numero + SumParesComp.

sumatoria_pares_impares(Numero, SumPares, SumImpares) :-
    X is Numero - 1,
    sumatoria_pares_impares(X, SumPares, SumImparesComp),
    SumImpares is Numero + SumImparesComp.
