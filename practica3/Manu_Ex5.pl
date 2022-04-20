append(X, L, [X|L]).
espacio_lineal(X, Y, _, _) :- X >= Y, 
    print("ERROR 4.1 Indices."), false.
espacio_lineal(X, Y, 0, []) :- X < Y.
espacio_lineal(X, Y, N, L) :- N > 0, X < Y, 
    N2 is N-1, R is (Y - X)/N2, rejilla(R, X, Y, L2, N2), append(X, L2, L).
rejilla(_, _, _, [], 0).
rejilla(R, X, Y, L, 1) :- rejilla(R, X, Y, L2, 0), append(Y, L2, L). 
rejilla(R, X, Y, L, N) :- N > 1, Z is X+R, N2 is N-1,
    rejilla(R, Z, Y, L2, N2), append(Z, L2, L).

