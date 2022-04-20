append(X, L, [X|L]).
producto_kronecker(A, B, C) :- matrizA(A, B, C).
matrizA([], _B, []).
matrizA([X|A], B, C) :- matrizA(A, B, D), filaA(X, B, E),
    append(E, D, C).
filaA([], _B, []).
filaA([X1|X], B, C) :- filaA(X, B, D), matrizB(X1, B, E),
    append(E, D, C).
matrizB(X1, _, _) :- X1 < 0,
    print("ERROR 7.1. Elemento menor que cero."), false.
matrizB(_X1, [], []).
matrizB(X1, [Y|B], C) :- X1 >= 0, matrizB(X1, B, D), filaB(X1, Y, E), 
    append(E, D, C).
filaB(_X1, [], []).
filaB(X1, [Y1|Y], C) :- multiplication(X1, Y1, E), filaB(X1, Y, D),  
    append(E, D, C).
multiplication(_, Y1, _) :- Y1 < 0,
    print("ERROR 7.1. Elemento menor que cero."), false.
multiplication(X1, Y1, E) :- Y1 >= 0, E is X1*Y1.