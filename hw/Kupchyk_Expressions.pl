% der(+функція, +змінна, -похідна)
% тести (вхідні дані => вихідні дані)
% der(sin(2*x+5),x,Res) => 2*cos(2*x+5)
% der(4*sin(cos(x))+2,x,Res) => -4*sin(x)*cos(cos(x))
% der(sin(x/2),x,Res) => cos(x/2)*(1/2)
% der(cos(x),x,Res) => Res = -sin(x).
% der(cos(x^3+x),x,Res) => (-(3*x^2+1))*sin(x^3+x)
% der(exp(3*x^2),x,Res) => 6*x*e^(3*x*x)
% der(exp(3),x,Res) => 0
% der(tg(2*x),x,Res) => 2/(cos(2*x))^2
% der(tg(sin(x)),x,Res) => cos(x) / cos(sin(x))^2
% der(ctg(x),x,Res) =>  -1/sin(x)^2.
% der(ctg(2*x^3+2),x,Res) => -6*x*2*(sin(2*x^3+2))^2

der(X, X, 1) :-!.
der(Const, X, 0) :- Const \= X, atomic(Const).
der(Y+Z, X, R) :- der(Y, X, R1), der(Z, X, R2), simplePlus(R1, R2, R).
der(Y-Z, X, R) :- der(Y, X, R1), der(Z, X, R2), simpleMinus(R1, R2, R).
der(Const*Y, X, R) :- atomic(Const), Const \= X, der(Y, X, R1), simpleMult(Const, R1, R),!.
der(Var*Y, X, R) :- atomic(Y), Y \= X, der(Var, X, R1), simpleMult(Y, R1, R),!.
der(Y*Z, X, R) :- der(Y, X, R1), der(Z, X, R2), simpleMult(Y, R2, Simple1), simpleMult(Z, R1, Simple2), simplePlus(Simple1, Simple2, R).
der(Y/Z, X, R) :- der(Y, X, R1), der(Z, X, R2), simpleMult(R1, Z, Mult1), simpleMult(R2, Y, Mult2), simpleMinus(Mult1, Mult2, MinusR),simpleDiv(MinusR, Z^2, R).
der(Y^Z, X, R) :- Z \= X,atomic(Z), der(Y, X, R1),simpleMult(Z, R1, Mult1), simpleMinus(Z, 1, Minus1),simplePow(Y, Minus1, Pow1),simpleMult(Mult1, Pow1, R),!.
der(Y^Z, X, R) :- der(exp(Z*log(Y)), X, R).
der(exp(Y), X, R) :- der(Y, X, R1), simpleExp(Y, R2), simpleMult(R1, R2, R).
der(log(Y), X, R) :- der(Y, X, R1), simpleDiv(R1, Y, R).
der(sin(Y), X, R) :- der(Y, X, R1), simpleMult(cos(Y), R1, R).
der(cos(Y), X, R) :- der(Y, X, R1), simpleMult(sin(Y), R1, R2), simpleMult(-1, R2, R).
der(tg(Y), X, R) :- der(Y, X, R1), simpleDiv(R1, (cos(Y))^2, R).
der(ctg(Y), X, R) :- der(Y, X, R1), simpleMult(-1, R1, Mult1), simpleDiv(Mult1, (sin(Y))^2, R).

simpleMult(0, _, 0) :- !.
simpleMult(_, 0, 0) :- !.
simpleMult(X, 1, X) :- !.
simpleMult(1, X, X) :- !.
simpleMult(X, -1, -X) :- !.
simpleMult(-1, X, -X) :- !.
simpleMult(X, Y, R) :- number(X), number(Y), R is X * Y, !.
simpleMult(X, Y, X*Y).

simpleDiv(0, _, 0) :- !.
simpleDiv(_, 0, _) :- !, fail.
simpleDiv(X, Y, R) :- number(X), number(Y), R is X / Y, !.
simpleDiv(X, Y, X / Y).

simplePlus(0, X, X) :- !.
simplePlus(X, 0, X) :- !.
simplePlus(X, Y, R) :- number(X), number(Y), R is X + Y, !.
simplePlus(X, Y, X+Y).

simpleMinus(X, 0, X) :- !.
simpleMinus(0, X, X) :- !.
simpleMinus(X, Y, R) :- number(X), number(Y), R is X - Y, !.
simpleMinus(X, Y, X-Y).

simplePow(0, 0, _) :- !, fail.
simplePow(0, X, 0) :- X \= 0, !.
simplePow(X, 0, 1) :- X \= 0, !.
simplePow(X, 1, X) :- !.
simplePow(1, _, 1) :- !.
simplePow(X, Y, R) :- number(X), number(Y), R is X^Y, !.
simplePow(X, Y, X^Y).

simpleExp(X*log(Y), Y^X) :- !.
simpleExp(X, exp(X)).