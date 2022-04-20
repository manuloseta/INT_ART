segundo_penultimo([_|[]], _, _) :- 
    print("ERROR 2.1 Longitud."), false.
segundo_penultimo(L, X, Y) :- segundo(L, X), penultimo(L, Y).
segundo([_|[X|_]], X).
penultimo([Y|[_|[]]], Y).
penultimo([_|L1], Y) :- penultimo(L1, Y).
