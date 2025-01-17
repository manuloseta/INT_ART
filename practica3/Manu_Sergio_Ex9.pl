% 9.1
distancia_euclidea(X, Y, D) :- dist_eu(X, Y, D2), D is sqrt(D2).
dist_eu([], [], 0).
dist_eu([X1|X], [Y1|Y], D) :- dist_eu(X, Y, D2), D is D2+((Y1-X1)^2).

% 9.2
calcular_distancias(_L, [], []).
calcular_distancias(L, [T1|T], P) :- calcular_distancias(L, T, Q),
    calcular_test(L, T1, R), append2(R, Q, P).
calcular_test([], _T1, []).
calcular_test([L1|L], T1, P) :- calcular_test(L, T1, Q),
    distancia_euclidea(L1, T1, R), append2(R, Q, P).

% 9.3.1
calcular_K_etiquetas_mas_relevantes(_, 0, _, []).
calcular_K_etiquetas_mas_relevantes(Y, K, X, E1) :-  K2 is K-1,
    lowest(X, F), index1(X, F, I), pop_index(Y, I, 1, E2, Y2),
    pop_index(X, I, 1, _E4, X2),
    calcular_K_etiquetas_mas_relevantes(Y2, K2, X2, E3), merge2(E2, E3, E1).

pop_index([], _, _, [], []).
pop_index([X3|X], I, C, X1, M) :- I == C, D is C+1,
    pop_index(X, I, D, X2, M), append2(X3, X2, X1).
pop_index([X3|X], I, C, X1, M) :- I \= C, D is C+1,
    pop_index(X, I, D, X1, N), append2(X3, N, M).

% 9.3.2
calcular_etiqueta_mas_relevante(L, E) :- calcular_contadores(L, C),
    most_frequent(C, [E|_]).

calcular_contadores([], []).
calcular_contadores([X1|X], C) :- calcular_contadores(X, D),
    count(X1, D, C, 0).
count(X, [], [[X|1]], 0).
count(_, [], [], 1).
count(X, [[E|N]|D], C, _) :- X == E, count(X, D, C2, 1), N2 is N + 1,
    append2([E|N2], C2, C).
count(X, [[E|N]|D], C, F) :-  X \= E, count(X, D, C2, F),
    append2([E|N], C2, C).

most_frequent([X1|[]], X1).
most_frequent([X3|X], X1) :- most_frequent(X, X2),
    max_label(X2, X3, X1).

max_label([E1|X1], [_|X2], [E1|X1]) :- X1 > X2.
max_label([_|X1], [E2|X2], [E2|X2]) :- X1 =< X2.

% 9.4
predecir_etiqueta(Y_entrenamiento, K, Vec_distancias, Etiqueta) :-
    calcular_K_etiquetas_mas_relevantes(Y_entrenamiento, K,
                                        Vec_distancias, Etiquetas),
    calcular_etiqueta_mas_relevante(Etiquetas, Etiqueta).

predecir_etiquetas(_, _, [], []).
predecir_etiquetas(Y_entrenamiento, K, [V|M], Y_test) :-
    predecir_etiquetas(Y_entrenamiento, K, M, Y),
    predecir_etiqueta(Y_entrenamiento, K, V, E), append2(E, Y, Y_test).

k_vecinos_proximos(X_entrenamiento, Y_entrenamiento, K, X_test, Y_test) :-
    calcular_distancias(X_entrenamiento, X_test, Matriz_resultados),
    predecir_etiquetas(Y_entrenamiento, K, Matriz_resultados, Y_test).

% 9.5


% useful functions
append2(X, L, [X|L]).

merge2([X], L, [X|L]).

lowest([X1|[]], X1).
lowest([X3|X], X1) :- lowest(X, X2), X1 is min(X2,X3).

highest([X1|[]], X1).
highest([X3|X], X1) :- highest(X, X2), X1 is max(X2,X3).

index1(L, X1, I) :- index(L, X1, I, 1).
index([], _, _, _).
index([X3|_], X1, I, C) :- X1 == X3, I is C.
index([X3|X], X1, I, C) :- X1 \= X3, D is C+1, index(X, X1, I, D).






