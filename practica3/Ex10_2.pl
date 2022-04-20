fractal_ex :-
 new(D, window('Fractal')),
 send(D, size, size(1000, 500)),
 drawTree_ex(D, 100, 150, 900, 150, 0, 4),
 send(D, open).

drawTree_ex(_D, _X1, _Y1, _X5, _Y5, _Angle, Depth) :- Depth < 1, false.

drawTree_ex(D, X1, Y1, X5, Y5, Angle, 1) :- % base case, we print lines here.
 Len is (sqrt((X5 - X1)^2 + (Y5 - Y1)^2))/3,
 X2 is X1 + cos(Angle * pi / 180.0) * Len,
 Y2 is Y1 + sin(Angle * pi / 180.0) * Len,
 X4 is X2 + cos(Angle * pi / 180.0) * Len,
 Y4 is Y2 + sin(Angle * pi / 180.0) * Len,
 A1 is Angle + 60,
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


drawTree_ex(D, X1, Y1, X5, Y5, Angle, Depth) :- Depth > 1,
 Len is (sqrt((X5 - X1)^2 + (Y5 - Y1)^2))/3,
 X2 is X1 + cos(Angle * pi / 180.0) * Len,
 Y2 is Y1 + sin(Angle * pi / 180.0) * Len,
 X4 is X2 + cos(Angle * pi / 180.0) * Len,
 Y4 is Y2 + sin(Angle * pi / 180.0) * Len,
 A1 is Angle + 60,
 A2 is Angle - 60,
 X3 is X2 + cos(A1 * pi / 180.0) * Len,
 Y3 is Y2 + sin(A1 * pi / 180.0) * Len,
 N is Depth - 1,
 drawTree_ex(D, X1, Y1, X2, Y2, Angle, N),
 drawTree_ex(D, X2, Y2, X3, Y3, A1, N),
 drawTree_ex(D, X3, Y3, X4, Y4, A2, N),
 drawTree_ex(D, X4, Y4, X5, Y5, Angle, N).





