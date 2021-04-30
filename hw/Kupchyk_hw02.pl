% Завдання 1:
% Ділення з остачею (лише для додатніх цілих чисел)- ціла частина та остача від ділення (не використовувати вбудовані функції!). Використовувати оператори віднімання (-)

firstTask(_, 0, _,_) :- throw('You can not divide by zero!').
firstTask(Divided, _, _,_) :- Divided < 0 , throw('Divided can not be negative').
firstTask(_, Divider, _,_) :- Divider < 0 , throw('Divider can not be negative').
firstTask(Divided, Divider, Whole, Remainder) :- firstTask(Divided, Divider, Whole, Remainder,0).

firstTask(Divided, Divider, Num, Divided ,Num) :- Divided < Divider , !.
firstTask(Divided, Divider, Whole, Remainder,Num) :- NewDivided is Divided-Divider,
                                                     NewNum is Num+1,
                                                     firstTask(NewDivided, Divider, Whole, Remainder ,NewNum).

% Завдання 2 
% Піднесення до степеню (лінійне та логарифмічне)  - (не використовувати вбудовані функції!).  Використовувати оператори (*, +, -, mod)

secondTaskLine(_, 0, 1) :- !.
secondTaskLine(X,Y,Result) :-  NewY is Y-1,
                               secondTaskLine(X,NewY,NewResult),
                               Result is X*NewResult.
secondTaskLog(_, 0, 1) :- !.
secondTaskLog(X, Y, Result) :- firstTask(Y,2,Whole,Remainder),
                              Remainder =:= 1,
                              X1 is X * X,
                              NewY is Whole,
                              secondTaskLog(X1, NewY, Result1),
                              Result is X * Result1, !.
secondTaskLog(X, Y, Result) :- firstTask(Y,2,Whole,Remainder),
                              Remainder =:= 0,
                              X1 is X * X, 
                              NewY is Whole,
                              secondTaskLog(X1, NewY, Result1),
                              Result is Result1, !.

% Завдання 3
% Числа Фібоначчі (рекурсія)

thirdTask(Number, _) :- Number < 0 , throw('Number can not be nagative').
thirdTask(Number, _) :- Number =:= 0 , throw('Number can not be zero').
thirdTask(1, 1) :- !.
thirdTask(2, 1) :- !.
thirdTask(Number, Result) :- Prev is Number-1,
                             PrevPrev is Number-2,
                             thirdTask(Prev, PrevResult),
                             thirdTask(PrevPrev, PrevPrevResult),
                             Result is PrevResult + PrevPrevResult.
% Завдання 4
% Розклад числа на прості множники (виведення всіх простих множників числа)
fourthTask(Number) :- Number < 2, !.
fourthTask(Number) :- checkSimple(Number,Dil,2),
                      write(Dil),
                      write('\n'),
                      firstTask(Number,Dil,Whole,_),
                      fourthTask(Whole).

checkSimple(Number,_,Divider) :- Number < Divider, !.
checkSimple(Number,Mnoz,Divider) :- firstTask(Number,Divider,_,Remainder),
                                    Remainder =:= 0,
                                    Mnoz is Divider,!.
checkSimple(Number,Mnoz,Divider) :- NewDiv is Divider + 1,
                                    checkSimple(Number,Mnoz,NewDiv).

% Завдання 5
% Обрахувати сумму 1/1! + 1/2! + 1/3! + ... 1/n! за допомогою рекурентних співвідношень
fifthTask(Number,_) :- Number < 0, throw("Number can not be negative!").
fifthTask(0,_) :- throw("Number can not be zero!").

fifthTask(Number, Result) :- fifthTask(Number, Result, 1, 1, 1), !.
fifthTask(Number, Result, Sum, _, Y) :- Number is Y,
                                        Result is Sum, !.
fifthTask(Number, Result, Sum, X, Y) :- NewY is Y+1, 
                                        NewX is X/NewY, 
                                        NewSum is Sum + NewX,
                                        fifthTask(Number,Result, NewSum, NewX, NewY).

% Завдання 6
% Алгоритм Евкліда (пошуку НСД).
sixthTask(A, 0, Z) :- Z is A.
sixthTask(A, B, Z) :- B > A, sixthTask(B, A, Z).
sixthTask(A, B, Z) :- firstTask(A,B,_,Remainder), sixthTask(B, Remainder, Z).
sixthTaskEuclid(A, B, Z) :- sixthTask(A, B, Z),!.