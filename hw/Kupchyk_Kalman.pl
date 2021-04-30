%Функції, елементарні за Кальманом. За допомогою 0-функції та функції слідування s(x)=x+1 можна визначати інші арифметичні функції.
%Функція слідування
s(X,Y):-Y is X+1.

%Визначення функції dec1(x)=x-1
dec1(X,Y):-s(0,T1),dd(X,0,T1,Y).
dd(X,Y,Z,Y):-X=Z,!.
dd(X,Y,Z,V):-s(Y,Y1),s(Z,Z1),dd(X,Y1,Z1,V).

%Визначення функції обчислення суми двох чисел
summa(X,0,X):-!.
summa(X,Y,Z):-s(X,X1),dec1(Y,Y1),summa(X1,Y1,Z).

%Різниця двох чисел
minus(X,Y,0):-X=<Y,!.
minus(X,Y,Z):-mn(X,Y,0,Z).
mn(X,Y,Z,Z):-summa(Y,Z,X1),X1=X,!.
mn(X,Y,Z,V):-s(Z,Z1),mn(X,Y,Z1,V).

%Множення
mult(_,0,0):-!.
mult(0,_,0):-!.
mult(X,Y,Z):-ml(X,X,Y,Z).
ml(_,Y,Z,Y):-s(0,Z1),Z1=Z,!.
ml(X,Y,Z,V):-dec1(Z,Z1),summa(X,Y,Y1),ml(X,Y1,Z1,V).

% Завдання 1: Ціла частина та остача від ділення
division(_, 0, _,_) :- throw('You can not divide by zero!').
division(Divided, _, _,_) :- Divided < 0 , throw('Divided can not be negative').
division(_, Divider, _,_) :- Divider < 0 , throw('Divider can not be negative').
division(X,Y,D,M) :- divisionHelper(X,Y,D,M,0).
divisionHelper(X,Y,C,X,C) :- X < Y,!.
divisionHelper(X,Y,D,M,C) :- minus(X,Y,X1), 
                             s(C,C1),
                             divisionHelper(X1,Y,D,M,C1).

% Завдання 2: Піднесення до степеню
pow(_,0,1) :- !.
pow(X,Y,Result) :- minus(Y,1,Y1),pow(X,Y1,Result1), mult(Result1,X,Result).

% Завдання 3:Ціла частина квадратного кореня
sqrtN(Num,Res) :- findWhole(Num,0,1,1,R),
                 ((mult(R,R,Re), Re\= Num ,dec1(R,Res)), !;Res=R, !).

findWhole(Num,Sqrt,Odd,Sum,Ans) :- Sum =< Num, 
                                   s(Sqrt,Sqrt1),
                                   summa(Odd,2,Odd1),
                                   summa(Sum,Odd,Sum1),
                                   findWhole(Num,Sqrt1,Odd1,Sum1,Ans).

findWhole(N,Sqrt,_,Sum,Sqrt) :- Sum > N.
