sublista(L, X, Y, C, L2) :- slice(L, X, Y, L2), en_lista(L2, C).
slice(_, X, _, _) :- X < 1,
    print("ERROR 3.2 Indices."), false.
slice(_, X, Y, _) :- Y < X,
    print("ERROR 3.2 Indices."), false.
slice([], _, _, _) :-
    print("ERROR 3.2 Indices."), false.
slice([X|_], 1, 1, [X]).
slice([X|Xs], 1, K, [X|Ys]) :- K >= 1, K > 1, 
   K1 is K - 1, slice(Xs, 1, K1, Ys).
slice([_|Xs], I, K, Ys) :- I >= 1, K >= I, I > 1, 
   I1 is I - 1, K1 is K - 1, slice(Xs, I1, K1, Ys).
en_lista([], _) :-
    print("ERROR 3.1 Elemento."), false.
en_lista([X|_], C) :- X = C, true.
en_lista([_|Y], C) :- en_lista(Y, C).