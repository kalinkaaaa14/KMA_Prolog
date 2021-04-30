% Перед запуском програм потрібно у SWI Prolog 1 раз ввести fill(9).
fill(9).
fill(-1):-!.
fill(X):-asserta(d(X)),X1 is X-1,fill(X1).


% 1. У тризначному числi, всi цифри якого непаpнi, закpеслили середню цифру. Виявилось, що отpимане двозначне число є дiльником вихiдного числа.Знайдiть всi такi тризначнi числа.
task1(Result) :- d(X),
                 X > 0,
                 d(Y),
                 d(Z),
                 X mod 2 =:= 1,
                 Y mod 2 =:= 1,
                 Z mod 2 =:= 1,
                 Result is 100 * X + 10 * Y + Z,
                 Result mod (10 * X + Z) =:= 0.

% 2. Знайдiть чотиризначне число, яке є точним квадратом, у якого двi першi цифри однаковi та двi останнi також однаковi.
task2(Result) :- d(X),
                 X > 0,
                 d(Y),
                 Result is (1000 * X + 100 * X + 10 * Y + Y),
                 Sqrt is sqrt(Result),
                 round(Sqrt) ** 2 =:= Result. 


% 3. Скiльки iснує цiлих чисел вiд 1 до 1998, якi не дiляться на жодне з чисел 6, 10, 15?
task3(Result) :- task3Helper(1,Result,0), !.
task3Helper(Number,Result,Counter) :- Number > 1998,
                                     Result is Counter;
			             (Number mod 6) =\= 0, 
			             (Number mod 10) =\= 0, 
			             (Number mod 15) =\= 0,
			             NewCounter is Counter + 1,
			             NewNumber is Number + 1, 
			             task3Helper(NewNumber,Result,NewCounter);
			             NewNumber is Number + 1,
                                     task3Helper(NewNumber,Result,Counter).


findSumNext(Number,CurrentSum) :- Number1 is Number**2,                          
                                  Number2 is (Number+1)**2, 
                                  Number3 is (Number+2)**2, 
                                  Number4 is (Number+3)**2, 
                                  Number5 is (Number+4)**2, 
                                  Number6 is (Number+5)**2, 
                                  Number7 is (Number+6)**2, 
                                  Number8 is (Number+7)**2, 
                                  Number9 is (Number+8)**2, 
                                  Number10 is (Number+9)**2, 
                                  Number11 is (Number+10)**2, 
                                  CurrentSum is Number1+Number2+Number3+Number4+Number5+Number6+Number7+Number8+Number9+Number10+Number11.

% 4. Знайти найменше натуральне число M, яке має наступну властивiсть: сума квадратiв одинадцяти послiдовних натуральних чисел, починаючи з M, є точним квадратом?
task4(Result) :- task4Helper(1,Result).
task4Helper(Number, Result) :- findSumNext(Number,CurrentSum),
                               round(sqrt(CurrentSum))**2 =:= CurrentSum,
                               Result is Number, !;
                               NewNumber is Number+1,
                               task4Helper(NewNumber, Result).

% 5. В послiдовностi 1998737... кождна цифра, починаючи з п'ятої, дорiвнює останнiй цифрi суми чотирьох попеpеднiх цифр. Через скiльки цифр знову зустрiнитья початкова комбiнацiя 1998 
%(тобто скiльки цифр в перiодi)?
task5(Result):- task5Helper(Result, 1, 9, 9, 8, 0).
task5Helper(Result, X1, X2, X3, X4, Period) :- Next is (X1+X2+X3+X4) mod 10,
                                               X2 =:= 1,
                                               X3 =:= 9,
                                               X4 =:= 9,
                                               Next =:= 8,
                                               NewPeriod is Period + 1, 
                                               Result is NewPeriod, !;
                                               Next is (X1+X2+X3+X4) mod 10,
                                               NewPeriod is Period + 1, 
                                               task5Helper(Result, X2, X3, X4, Next, NewPeriod).