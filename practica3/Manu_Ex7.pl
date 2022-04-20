divergencia_kl(D1, D2, D) :- dist(D1, C1), dist(D2, C2), error(C1, C2),
    divergencia(D1, D2, D).
dist([], 0).
dist([X|_], _) :- X =< 0, 
    print("ERROR 6.1. Divergencia KL no definida."), false.
dist([X|D], C) :- X > 0, dist(D, C2), C is C2+X.
error(C1, _) :- C1 =\= 1,
    print("ERROR 6.2. Divergencia KL definida solo para distribuciones."), 
    false.
error(_, C2) :- C2 =\= 1,
    print("ERROR 6.2. Divergencia KL definida solo para distribuciones."), 
    false.
error(_, _).
divergencia([], [_], _) :- 
    print("ERROR 6.3. Divergencias de distinto tamaño."),
    false.
divergencia([_], [], _) :- 
    print("ERROR 6.3. Divergencias de distinto tamaño."),
    false.
divergencia([], [], 0).
divergencia([P|D1], [Q|D2], D) :- S is P*log(P/Q), divergencia(D1, D2, E),
    D is E+S.