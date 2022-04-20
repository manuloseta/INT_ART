append(X, L, [X|L]).
normalizar(L, L2) :- constant(L, C), divide(C, L, L2).
constant([], 0).
constant([X|_], _) :- X < 0,
    print("ERROR 5.1. Negativos."), false.
constant([X|L], C) :- X >= 0, constant(L, C2), C is C2+X.
divide(_, [], []).
divide(C, [X|L], L2) :- R is X/C, divide(C, L, L3), append(R, L3, L2).
