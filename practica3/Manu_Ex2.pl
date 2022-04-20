sum_pot_prod(_, _, N, _) :- N < 1, 
    print("ERROR 1.1 Potencia."), false.
sum_pot_prod([], [_], _, _) :-
    print("ERROR 1.2 Longitud."), false.
sum_pot_prod([_], [], _, _) :-
    print("ERROR 1.2 Longitud."), false.
sum_pot_prod([], [], _, 0).
sum_pot_prod([X1|Y1], [X2|Y2], N, R1) :- N > 0, sum_pot_prod(Y1, Y2, N, R2),
    R1 is R2+(X1*X2)^N.
    