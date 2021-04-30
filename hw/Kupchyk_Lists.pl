% ================================================================================================================= 
revHelper([H|T],A,R) :- revHelper(T,[H|A],R).
revHelper([],A,A).
rev(L,R) :- revHelper(L,[],R).

% Завдання 1: Напишіть предикат, який перетворює вихідний список у список позицій від'ємних елементів.
% 1. task1([-1,2,-3,2,3,-2], X).
% task1(+List,-Result)
% X = [0, 2, 5] 
% 2. task1([-1,-2,-3,-2,-3,-2], X).
% X = [0, 1, 2, 3, 4, 5].
% 3. task1([1,2,3,2,3,2], X).
% X = []
task1(List, Result) :- task1(List, [], 0, Result).
task1([],UnreversedL, _, Result) :- rev(UnreversedL, Result), !.
task1([Elem|Others], UnreversedL, Position, Result) :- Elem >= 0,
                                                       NPosition is Position + 1,
                                                       task1(Others, UnreversedL, NPosition, Result);
                                                       Elem < 0,
                                                       NPosition is Position + 1,
                                                       task1(Others, [Position|UnreversedL], NPosition, Result).
% =================================================================================================================
appen([],L,L).
appen([X|L1],L2,[X|L]):-appen(L1,L2,L).

% Завдання 2: Напишіть предикат, що замінює всі входження заданого елемента на символ change_done.
% task2(+List,+X,-Result).
% 1. task2([x,q,w,e,r,x,x,q,h],x,Result).
% Result = [change_done, q, w, e, r, change_done, change_done, q, h].
% 2. task2([1,2,3,4,5,6],3,Result).
% Result = [1, 2, change_done, 4, 5, 6].
% 3. task2([10,10,11,x,y,10,x],x,Result).
% ?Result = [10, 10, 11, change_done, y, 10, change_done].
% 4. task2([10,10,11,12],1,Result).
% Result = [10, 10, 11, 12].
task2(List, X, Result):-task2(List, X, [], Result), !.
task2([], _, Result, Result) :- !.
task2([Elem|Others], X, TempResult, Result) :- Elem == X, 
                                               appen(TempResult, [change_done], ResAppend), 
                                               task2(Others, X, ResAppend, Result);
                                               appen(TempResult, [Elem], ResAppend),
                                               task2(Others, X, ResAppend, Result).
% =================================================================================================================
toRomanNumbers(Elem, Result) :- toRomanNumbers(Result, Elem,''), !.
toRomanNumbers(Result, 0, TempRes) :- (TempRes='',throw("Number can't be zero")) ; Result=TempRes.
toRomanNumbers(_,Elem,_) :- (Elem < 1; Elem > 50), throw("Number should be between 1 and 50").
toRomanNumbers(Result, Elem, TempRes) :- Elem=50,
                                         NewElem is (Elem-50),
                                         atom_concat(TempRes, 'L', ConcatRes),
                                         toRomanNumbers(Result, NewElem, ConcatRes).
toRomanNumbers(Result, Elem, TempRes) :- Elem >= 40,
                                         NewElem is (Elem-40),
                                         atom_concat(TempRes, 'XL', ConcatRes), 
                                         toRomanNumbers(Result, NewElem, ConcatRes).
toRomanNumbers(Result, Elem, TempRes) :- Elem >= 10,
                                         NewElem is (Elem-10),
                                         atom_concat(TempRes, 'X', ConcatRes),
                                         toRomanNumbers(Result, NewElem, ConcatRes).
toRomanNumbers(Result, Elem, TempRes) :- Elem >= 9,
                                         NewElem is (Elem-9),
                                         atom_concat(TempRes, 'IX', ConcatRes),
                                         toRomanNumbers(Result, NewElem, ConcatRes).
toRomanNumbers(Result, Elem, TempRes) :- Elem >= 5,
                                         NewElem is (Elem-5),
                                         atom_concat(TempRes, 'V', ConcatRes),
                                         toRomanNumbers(Result, NewElem, ConcatRes).
toRomanNumbers(Result, Elem, TempRes) :- Elem >= 4,
                                         NewElem is (Elem-4),
                                         atom_concat(TempRes, 'IV', ConcatRes),
                                         toRomanNumbers(Result, NewElem, ConcatRes).
toRomanNumbers(Result, Elem, TempRes) :- Elem >= 1,
                                         NewElem is (Elem-1),
                                         atom_concat(TempRes, 'I', ConcatRes),
                                         toRomanNumbers(Result, NewElem, ConcatRes).
% Завдання 3: Напишіть предикат, що перетворює будь-який список арабських чисел (від 1 до 50, можна зробити до 90 або без "С"==100) у список відповідних їм римських чисел.
% task3(+List, -Result)
% 1. task3([1,12,15,121,52], Result).
% ERROR: Unhandled exception: "Number should be between 1 and 50"
% 2. task3([10,0,12,15,11,5], Result).
% ERROR: Unhandled exception: "Number can't be zero"
% 3. task3([10,9,8,7,6,1,3,20,30], Result).
% Result = ['X', 'IX', 'VIII', 'VII', 'VI', 'I', 'III', 'XX', 'XXX'].
% 4. task3([31,41,49,39,29,19,9], Result).
% Result = ['XXXI', 'XLI', 'XLIX', 'XXXIX', 'XXIX', 'XIX', 'IX'].
% 5. task3([1,2,3,4,5,6,7,8,9], Result).
% Result = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX'].
task3(List, Result) :- task3(Result,List, []),!.
task3(Result, [], Result).
task3(Result, [Elem|Others], TempRes) :- toRomanNumbers(Elem, Roman),
                                         appen(TempRes,[Roman],AppenRes),
                                         task3(Result, Others, AppenRes).
% ==================================================================================================================
% Завдання 4: Напишіть предикат, що здійснює циклічний зсув елементів списку на один вправо.
% task5(+List,-Result)
% 1. task4([1,-1,2,3,4,5],Result).
% Result = [5, 1, -1, 2, 3, 4]
% 2. task4([1,2],X).
% X = [2, 1]
% 3. task4([1],X).
% X = [1]
% 4. task4([5,4,3,2,1],X).
% X = [1, 5, 4, 3, 2]
task4(List, [Head|Tail]) :- appen(Tail, [Head], List).
% ==================================================================================================================
multiplicate([], [], Result, Result).
multiplicate([RowElement|OtherRElements], [VectorElement|OtherVElements], Result, TempRes) :- NewTempRes is (TempRes + (RowElement * VectorElement)),
                                                                                              multiplicate(OtherRElements, OtherVElements, Result, NewTempRes).
task5([], _, Arr, Result) :- reverse(Arr, Result), !.
task5([RowMatrix|OtherRows], Vector, Arr,Result) :- multiplicate(RowMatrix, Vector, ResultMultiplication,0),
                                                    task5(OtherRows, Vector, [ResultMultiplication|Arr], Result).

% Завдання 5: Напишіть предикат, що реалізує множення матриці (список списків) на вектор.
% task5(+Матриця, +Вектор, -Результат).
% Тести:
% 1. task5([[2, 4, 0],[-2, 1, 3],[-1, 0, 1]],[1, 2, -1], X).
% X = [10, -3, -2].
% 2. task5([[1, 2, -1],[2, 3, 0],[4, -2, 2],[3,3,5]],[2,1,-3], X).
% X = [7, 7, 0, -6].
% 3. task5([[1, 5],[6, 7],[-2,-8]],[5,-5], X).
% X = [-20, -5, 30].
% 4. task5([[5, 2,3,2,4,6],[1,0,-6,-1,-10,-5],[13,5,2,-2,5,13],[1,0,-1,4,-3,1],[0,4,-5,6,11,-6]],[5,-5,6,55,10,11], X).
% X = [249, -241, 135, 200, 324].
task5(Matrix, Vector, Result) :- task5(Matrix, Vector, [],Result).