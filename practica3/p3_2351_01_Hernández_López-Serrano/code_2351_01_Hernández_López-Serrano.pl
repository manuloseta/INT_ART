write_log(S) :- open('error_logs.txt', append, Out), write(Out, S), write(Out, '\n'), close(Out).

/***************
* Useful functions used in the exercises.
****************/

lowest([X1|[]], X1).
lowest([X3|X], X1) :- lowest(X, X2), X1 is min(X2,X3).

index1(L, X1, I) :- index(L, X1, I, 1).
index([], _, _, _).
index([X3|_], X1, I, C) :- X1 == X3, I is C.
index([X3|X], X1, I, C) :- X1 \= X3, D is C+1, index(X, X1, I, D).

/***************
* EJERCICIO 2. sum_pot_prod/4
*
*	ENTRADA:
*		X: Vector de entrada de numeros de valor real.
*		Y: Vector de entrada de numeros de valor real.
*		Potencia: Numero de valor entero, potencia.
*	SALIDA:
*		Resultado: Numero de valor real resultado de la operacion sum_pot_* prod.
*
****************/

sum_pot_prod(_X, _Y, Potencia, _Resultado) :- Potencia < 1,
    write_log("ERROR 1.1 Potencia."), false.
sum_pot_prod([], [_], _Potencia, _Resultado) :-
    write_log("ERROR 1.2 Longitud."), false.
sum_pot_prod([_], [], _Potencia, _Resultado) :-
    write_log("ERROR 1.2 Longitud."), false.
sum_pot_prod([], [], _Potencia, 0).
sum_pot_prod([X1|X], [Y1|Y], Potencia, Resultado) :- Potencia > 0,
    sum_pot_prod(X, Y, Potencia, R2), Resultado is R2+(X1*Y1)^Potencia.

/***************
* EJERCICIO 3. segundo_penultimo/3
*
*       ENTRADA:
*               L: Lista de entrada de numeros de valor real.
*       SALIDA:
*               X : Numero de valor real. Segundo elemento.
*		Y : Numero de valor real. Penultimo elemento.
*
****************/

segundo_penultimo([], _X, _Y) :-
    write_log("ERROR 2.1 Longitud."), false.
segundo_penultimo([_|[]], _X, _Y) :-
    write_log("ERROR 2.1 Longitud."), false.
segundo_penultimo(L, X, Y) :- segundo(L, X), penultimo(L, Y).
segundo([_|[X|_]], X).
penultimo([Y|[_|[]]], Y).
penultimo([_|L], Y) :- penultimo(L, Y).

/***************
* EJERCICIO 4. sublista/5
*
*       ENTRADA:
*		L: Lista de entrada de cadenas de texto.
*		Menor: Numero de valor entero, indice inferior.
*		Mayor: Numero de valor entero, indice superior.
*		E: Elemento, cadena de texto.
*       SALIDA:
*		Sublista: Sublista de salida de cadenas de texto.
*
****************/

sublista(L, Menor, Mayor, E, Sublista) :- slice(L, Menor, Mayor, Sublista),
    en_lista(Sublista, E).

slice(_L, Menor, _Mayor, _Sublista) :- Menor < 1,
    write_log("ERROR 3.2 Indices."), false.
slice(_L, Menor, Mayor, _Sublista) :- Mayor < Menor,
    write_log("ERROR 3.2 Indices."), false.
slice([], _Menor, _Mayor, _Sublista) :-
    write_log("ERROR 3.2 Indices."), false.
slice([X|_], 1, 1, [X]).
slice([X|Xs], 1, K, [X|Ys]) :- K >= 1, K > 1,
   K1 is K - 1, slice(Xs, 1, K1, Ys).
slice([_|Xs], I, K, Ys) :- I >= 1, K >= I, I > 1,
   I1 is I - 1, K1 is K - 1, slice(Xs, I1, K1, Ys).

en_lista([], _E) :-
    write_log("ERROR 3.1 Elemento."), false.
en_lista([X|_], E) :- X = E, true.
en_lista([_|L], E) :- en_lista(L, E).

/***************
* EJERCICIO 5. espacio_lineal/4
*
*       ENTRADA:
*               Menor: Numero de valor entero, valor inferior del intervalo.
*               Mayor: Numero de valor entero, valor superior del intervalo.
*               Numero_elementos: Numero de valor entero, numero de valores de la rejilla.
*       SALIDA:
*               Rejilla: Vector de numeros de valor real resultante con la rejilla.
*
****************/

espacio_lineal(Menor, Mayor, _Numero_elementos, _Rejilla) :- Menor >= Mayor,
    write_log("ERROR 4.1 Indices."), false.
espacio_lineal(Menor, Mayor, 0, []) :- Menor < Mayor.
espacio_lineal(Menor, Mayor, Numero_elementos, [Menor|Rejilla]) :-
    Numero_elementos > 0, Menor < Mayor, N is Numero_elementos - 1,
    R is (Mayor - Menor) / N, rejilla(R, Menor, Mayor, Rejilla, N).

rejilla(_R, _X, Y, [Y], 1).
rejilla(R, X, Y, [Z|L], N) :- N > 1, Z is X+R, N2 is N-1, rejilla(R, Z, Y, L, N2).

/***************
* EJERCICIO 6. normalizar/2
*
*       ENTRADA:
*		Distribucion_sin_normalizar: Vector de numeros reales de entrada. Distribucion sin normalizar.
*       SALIDA:
*		Distribucion: Vector de numeros reales de salida. Distribucion normalizada.
*
****************/

normalizar(Distribucion_sin_normalizar, Distribucion) :-
    constant(Distribucion_sin_normalizar, C),
    divide(C, Distribucion_sin_normalizar, Distribucion).
constant([], 0).
constant([X|_], _C) :- X < 0,
    write_log("ERROR 5.1. Negativos."), false.
constant([X|L], C) :- X >= 0, constant(L, C2), C is C2+X.
divide(_C, [], []).
divide(C, [X|L], [R|L2]) :- R is X/C, divide(C, L, L2).

/***************
* EJERCICIO 7. divergencia_kl/3
*
*       ENTRADA:
*		D1: Vector de numeros de valor real. Distribucion.
*		D2: Vector de numeros de valor real. Distribucion.
*       SALIDA:
*		KL: Numero de valor real. Divergencia KL.
*
****************/

divergencia_kl(D1, D2, KL) :- dist(D1, C1), dist(D2, C2), error(C1, C2),
    divergencia(D1, D2, KL).
dist([], 0).
dist([X|_], _C) :- X =< 0,
    write_log("ERROR 6.1. Divergencia KL no definida."), false.
dist([X|D], C) :- X > 0, dist(D, C2), C is C2+X.
error(C1, _C2) :- C1 =\= 1,
    write_log("ERROR 6.2. Divergencia KL definida solo para distribuciones."),
    false.
error(_C1, C2) :- C2 =\= 1,
    write_log("ERROR 6.2. Divergencia KL definida solo para distribuciones."),
    false.
error(C1, C2) :- C1 == 1.0, C2 == 1.0.
divergencia([], [_], _KL) :-
    write_log("ERROR 6.3. Divergencias de distinto tama�o."),
    false.
divergencia([_], [], _KL) :-
    write_log("ERROR 6.3. Divergencias de distinto tama�o."),
    false.
divergencia([], [], 0).
divergencia([P|D1], [Q|D2], KL) :- S is P*log(P/Q), divergencia(D1, D2, KL2),
    KL is KL2+S.

/***************
* EJERCICIO 8. producto_kronecker/3
*
*       ENTRADA:
*		Matriz_A: Matriz de numeros de valor real.
*		Matriz_B: Matriz de numeros de valor real.
*       SALIDA:
*		Matriz_bloques: Matriz de bloques (matriz de matrices) de numeros reales.
*
****************/

producto_kronecker(Matriz_A, Matriz_B, Matriz_bloques) :-
    matrizA(Matriz_A, Matriz_B, Matriz_bloques).
matrizA([], _Matriz_B, []).
matrizA([X|A], B, [D|C]) :- matrizA(A, B, C), filaA(X, B, D).
filaA([], _B, []).
filaA([X1|X], B, [D|C]) :- filaA(X, B, C), matrizB(X1, B, D).
matrizB(X1, _, _) :- X1 < 0,
    write_log("ERROR 7.1. Elemento menor que cero."), false.
matrizB(_X1, [], []).
matrizB(X1, [Y|B], [D|C]) :- X1 >= 0, matrizB(X1, B, C), filaB(X1, Y, D).
filaB(_X1, [], []).
filaB(X1, [Y1|Y], [D|C]) :- multiplication(X1, Y1, D), filaB(X1, Y, C).
multiplication(_, Y1, _) :- Y1 < 0,
    write_log("ERROR 7.1. Elemento menor que cero."), false.
multiplication(X1, Y1, E) :- Y1 >= 0, E is X1*Y1.

/***************
* EJERCICIO 9a. distancia_euclidea/3
*
*       ENTRADA:
*               X1: Vector de numeros de valor real.
*               X2: Vector de numeros de valor real.
*       SALIDA:
*               D: Numero de valor real. Distancia euclidea.
*
****************/

distancia_euclidea(X1, X2, D) :- dist_no_sqrt(X1, X2, D2), D is sqrt(D2).
dist_no_sqrt([], [], 0).
dist_no_sqrt([X1|X], [Y1|Y], D) :- dist_no_sqrt(X, Y, D2), D is D2+((Y1-X1)^2).

/***************
* EJERCICIO 9b. calcular_distancias/3
*
*       ENTRADA:
*               X_entrenamiento: Matriz de numeros de valor real donde cada fila es una instancia representada por un vector.
*               X_test: Matriz de numeros de valor real donde cada fila es una instancia representada por un vector. Instancias sin etiquetar.
*       SALIDA:
*               Matriz_resultados: Matriz de numeros de valor real donde cada fila es un vector con la distancia de un punto de test al conjunto de entrenamiento X_entrenamiento.
*
****************/

calcular_distancias(_X_entrenamiento, [], []).
calcular_distancias(X_entrenamiento, [E|X_test], [M2|M]) :-
    calcular_distancias(X_entrenamiento, X_test, M),
    calcular_test(X_entrenamiento, E, M2).
calcular_test([], _T1, []).
calcular_test([F|X_entrenamiento], E, [M3|M2]) :-
    calcular_test(X_entrenamiento, E, M2), distancia_euclidea(F, E, M3).

/***************
* EJERCICIO 9c. predecir_etiquetas/4
*
*       ENTRADA:
*               Y_entrenamiento: Vector de valores alfanumericos de una distribucion categorica. Cada etiqueta corresponde a una instancia de X_entrenamiento.
*               K: Numero de valor entero.
*               Matriz_resultados: Matriz de numeros de valor real donde cada fila es un vector con la distancia de un punto de test al conjunto de entrenamiento X_entrenamiento.
*       SALIDA:
*               Y_test: Vector de valores alfanumericos de una distribucion categorica. Cada etiqueta corresponde a una instancia de X_test.
*
****************/

predecir_etiquetas(_Y_entrenamiento, _K, [], []).
predecir_etiquetas(Y_entrenamiento, K, [Vec|Matriz_resultados], [Etiqueta|Y_temp]) :-
    predecir_etiquetas(Y_entrenamiento, K, Matriz_resultados, Y_temp),
    predecir_etiqueta(Y_entrenamiento, K, Vec, Etiqueta).

/***************
* EJERCICIO 9d. predecir_etiqueta/4
*
*       ENTRADA:
*               Y_entrenamiento: Vector de valores alfanumericos de una distribucion categorica. Cada etiqueta corresponde a una instancia de X_entrenamiento.
*               K: Numero de valor entero.
*               Vec_distancias: Vector de valores reales correspondiente a una fila de Matriz_resultados.
*       SALIDA:
*               Etiqueta: Elemento de valor alfanumerico.
*
****************/

predecir_etiqueta(Y_entrenamiento, K, Vec_distancias, Etiqueta) :-
    calcular_K_etiquetas_mas_relevantes(Y_entrenamiento, K,
                                        Vec_distancias, Etiquetas),
    calcular_etiqueta_mas_relevante(Etiquetas, Etiqueta).

/***************
* EJERCICIO 9e. calcular_K_etiquetas_mas_relevantes/4
*
*       ENTRADA:
*               Y_entrenamiento: Vector de valores alfanumericos de una distribucion categorica. Cada etiqueta corresponde a una instancia de X_entrenamiento.
*               K: Numero de valor entero.
*               Vec_distancias: Vector de valores reales correspondiente a una fila de Matriz_resultados.
*       SALIDA:
*		K_etiquetas: Vector de valores alfanumericos de una distribucion categorica.
*
****************/

calcular_K_etiquetas_mas_relevantes(_Y_entrenamiento, 0, _Vec_distancias, []).
calcular_K_etiquetas_mas_relevantes(Y_entrenamiento, K, Vec_distancias, [Etiqueta|Temp_etiquetas]) :-
    K2 is K-1, lowest(Vec_distancias, F), index1(Vec_distancias, F, I),
    pop_index(Y_entrenamiento, I, 1, [Etiqueta], New_Y),
    pop_index(Vec_distancias, I, 1, _, New_Vec),
    calcular_K_etiquetas_mas_relevantes(New_Y, K2, New_Vec, Temp_etiquetas).

pop_index([], _, _, [], []).
pop_index([X3|X], I, C, [X3|X2], M) :- I == C, D is C+1,
    pop_index(X, I, D, X2, M).
pop_index([X3|X], I, C, X1, [X3|N]) :- I \= C, D is C+1,
    pop_index(X, I, D, X1, N).

/***************
* EJERCICIO 9f. calcular_etiqueta_mas_relevante/2
*
*       ENTRADA:
*               K_etiquetas: Vector de valores alfanumericos de una distribucion categorica.
*       SALIDA:
*               Etiqueta: Elemento de valor alfanumerico.
*
****************/

calcular_etiqueta_mas_relevante(K_etiquetas, Etiqueta) :-
    calcular_contadores(K_etiquetas, Contadores),
    most_frequent(Contadores, [Etiqueta|_]).

calcular_contadores([], []).
calcular_contadores([X1|X], C) :- calcular_contadores(X, D),
    count(X1, D, C, 0).
count(X, [], [[X|1]], 0).
count(_, [], [], 1).
count(X, [[E|N]|D], [[E|N2]|C2], _) :- X == E, count(X, D, C2, 1), N2 is N + 1.
count(X, [[E|N]|D], [[E|N]|C2], F) :-  X \= E, count(X, D, C2, F).

most_frequent([X1|[]], X1).
most_frequent([X3|X], X1) :- most_frequent(X, X2),
    max_label(X2, X3, X1).

max_label([E1|X1], [_|X2], [E1|X1]) :- X1 > X2.
max_label([_|X1], [E2|X2], [E2|X2]) :- X1 =< X2.

/***************
* EJERCICIO 9g. k_vecinos_proximos/5
*
*       ENTRADA:
*		X_entrenamiento: Matriz de numeros de valor real donde cada fila es una instancia representada por un vector.
*		Y_entrenamiento: Vector de valores alfanumericos de una distribucion categorica. Cada etiqueta corresponde a una instancia de X_entrenamiento.
*		K: Numero de valor entero.
*		X_test: Matriz de numeros de valor real donde cada fila es una instancia representada por un vector. Instancias sin etiquetar.
*       SALIDA:
*		Y_test: Vector de valores alfanumericos de una distribucion categorica. Cada etiqueta corresponde a una instancia de X_test.
*
****************/

k_vecinos_proximos(X_entrenamiento, Y_entrenamiento, K, X_test, Y_test) :-
    calcular_distancias(X_entrenamiento, X_test, Matriz_resultados),
    predecir_etiquetas(Y_entrenamiento, K, Matriz_resultados, Y_test).

/***************
* EJERCICIO 9h. clasifica_patrones/4
*
*       ENTRADA:
*		iris_patrones.csv: Fichero con los patrones a clasificar, disponible en Moodle.
*		iris_etiquetas.csv: Fichero con las etiquetas de los patrones a clasificar, disponible en Moodle.
*		K: Numero de valor entero.
*       SALIDA:
*		tasa_aciertos: Tasa de acierto promediada sobre las iteraciones leave-one-out
*
****************/

clasifica_patrones('iris_patrones.csv','iris_etiquetas.csv',K,Tasa_aciertos) :-
    csv_read_file('iris_patrones.csv',DataX,[functor(table),arity(4)]),
    syntax_conversion(DataX, ListX),
    csv_read_file('iris_etiquetas.csv',DataY, [functor(table)]),
    syntax_conversion(DataY, [ListY]),
    leave_one_out(K, T, ListX, ListY, ListX, 0, Total),
    Tasa_aciertos is T/Total.


syntax_conversion([],[]).
syntax_conversion([T|Table], [L|List]) :- list_conversion(T, L),
    syntax_conversion(Table, List).
list_conversion(T, L) :- T=..[table|L].

leave_one_out(_K, 0, _ListX, _ListY, [], Index, Index).
leave_one_out(K, Tasa_aciertos, ListX, ListY, [_|ListLeft], Index, Total) :-
    I is Index+1,
    leave_one_out(K, T, ListX, ListY, ListLeft, I, Total),
    nth0(Index, ListX, X_test, X_entrenamiento),
    nth0(Index, ListY, Y_answer, Y_entrenamiento),
    k_vecinos_proximos(X_entrenamiento, Y_entrenamiento, K, [X_test], [Y_test]),
    comp(Y_answer, Y_test, Eq), Tasa_aciertos is T+Eq.

comp(A,B,1) :- A==B.
comp(_A,_B,0).



/**************
* EJERCICIO 10. fractal/0
*
* Creates a fractal similar to the one requested in the question.
*
* It uses a sub-predicate called drawTree:
*
*               drawTree/7
*
*               ENTRADA:
*		X1,Y1: coordinates to the start of the line.
*		X5,Y5: coordinates to the end of the line.
*               These two dots form a line, our job is to "grow a spike"
*               from the line.
*               Angle: angle of the triangle/spike. Default is 0.
*               Depth: number of iterations of spikes printed. Has to be
*               larger or equal than 0.
*
*               SALIDA:
*               D: The fractal generated.
*
* ***************/

fractal :-
 new(D, window('Fractal')),
 send(D, size, size(1000, 500)),
 drawTree(D, 100, 350, 900, 350, 0, 5),
 send(D, open).

drawTree(_D, _X1, _Y1, _X5, _Y5, _Angle, Depth) :- Depth < 0, false.

drawTree(D, X1, Y1, X5, Y5, _Angle, 0) :-
 new(Line, line(X1, Y1, X5, Y5, none)),
 send(D, display, Line).

drawTree(D, X1, Y1, X5, Y5, Angle, 1) :- % base case, we print lines here.
 Len is (sqrt((X5 - X1)^2 + (Y5 - Y1)^2))/3,
 X2 is X1 + cos(Angle * pi / 180.0) * Len,
 Y2 is Y1 + sin(Angle * pi / 180.0) * Len,
 X4 is X2 + cos(Angle * pi / 180.0) * Len,
 Y4 is Y2 + sin(Angle * pi / 180.0) * Len,
 A1 is Angle - 60,
 X3 is X2 + cos(A1 * pi / 180.0) * Len,
 Y3 is Y2 + sin(A1 * pi / 180.0) * Len,
 new(Line, line(X1, Y1, X2, Y2, none)),
 send(D, display, Line),
 new(Line2, line(X4, Y4, X5, Y5, none)),
 send(D, display, Line2),
 new(Line3, line(X2, Y2, X3, Y3, none)),
 send(D, display, Line3),
 new(Line4, line(X3, Y3, X4, Y4, none)),
 send(D, display, Line4).


drawTree(D, X1, Y1, X5, Y5, Angle, Depth) :- Depth > 1,
 Len is (sqrt((X5 - X1)^2 + (Y5 - Y1)^2))/3,
 X2 is X1 + cos(Angle * pi / 180.0) * Len,
 Y2 is Y1 + sin(Angle * pi / 180.0) * Len,
 X4 is X2 + cos(Angle * pi / 180.0) * Len,
 Y4 is Y2 + sin(Angle * pi / 180.0) * Len,
 A1 is Angle - 60,
 A2 is Angle + 60,
 X3 is X2 + cos(A1 * pi / 180.0) * Len,
 Y3 is Y2 + sin(A1 * pi / 180.0) * Len,
 N is Depth - 1,
 drawTree(D, X1, Y1, X2, Y2, Angle, N),
 drawTree(D, X2, Y2, X3, Y3, A1, N),
 drawTree(D, X3, Y3, X4, Y4, A2, N),
 drawTree(D, X4, Y4, X5, Y5, Angle, N).












