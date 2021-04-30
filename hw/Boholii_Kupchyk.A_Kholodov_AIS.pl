
% --------------- database ---------------

% exchangeProgram(title, [universities]).
exchangeProgram("Erasmus+", ["KPI","UCU"]).
exchangeProgram("Global UGRAD", ["Stanford"]).
exchangeProgram("AIESEC", ["Oxford"]).
exchangeProgram("Camp Counselor", ["Harvard"]).
exchangeProgram("AIESEC-2", ["KPI","KMA"]).
exchangeProgram("ProCamp", ["Oxford", "UCU","KMA"]).

% regarding(epTitle, branchCode).
regarding("Erasmus+", 122).
regarding("Global UGRAD", 122).
regarding("Global UGRAD", 121).
regarding("AIESEC", 122).
regarding("AIESEC", 123).
regarding("Camp Counselor", 123).
regarding("AIESEC-2",121).
regarding("AIESEC-2",152).
regarding("AIESEC-2",122).
regarding("ProCamp",121).
regarding("ProCamp",122).
regarding("ProCamp",123).
regarding("ProCamp",152).

% branch(code, alterKey(title, degree), facultyId).
branch(122, alterKey("computer science", "bachelor"), 1).
branch(121, alterKey("ipz", "bachelor"), 1).
branch(123, alterKey("applied math", "bachelor"), 1).
branch(152, alterKey("pravo", "bachelor"), 2).

% careerOriented(branchCode, subjectCode).
careerOriented(121, 10001).
careerOriented(121, 10002).
careerOriented(121, 10004).
careerOriented(122, 10001).
careerOriented(122, 10002).
careerOriented(122, 10005).
careerOriented(122, 10004).
careerOriented(123, 10004).
careerOriented(152, 10003).
careerOriented(152, 10002).
careerOriented(152, 10001).

% subject(code, title, yearOfTeach, course, facultyId, normativeFor_branchCode).
subject(10001, "JavaEE", 2020, 3, 1, null).
subject(10000, "JavaEE", 2019, 3, 1, null).
subject(10002, "ASD", 2019, 2, 2, 122).
subject(10003, "MOOP", 2021, 2, 3, 121).
subject(10004, "Logic Programming", 2020, 3, 4, 123).
subject(10005, "Functional Programming", 2020, 3, 1, 122).

% teach(lecturerId, subjectCode).
teach(1, 10002).
teach(1, 10000).
teach(1, 10001).
teach(2, 10000).
teach(2, 10004).
teach(3, 10004).
teach(4, 10000).
teach(4, 10001).
teach(4, 10002).
teach(4, 10003).
teach(4, 10004).

% lecturer(id, name(secondName, firstName, patronymic), phone(1,2,3,4), income).
lecturer(1, name("Ivanenko","Ivan","Ivanovych"), phone("0676543112",null,null,null), 20000).
lecturer(2, name("Malko","Olha","Olgivna"), phone("0677099867","0986044886",null,null), 15000).
lecturer(3, name("Rop","Maryna","Andriivna"), phone("098088667","050855667","0679511211",null), 25000).
lecturer(4, name("Kopin","Mykola","Tarasovych"), phone("0677099867","0986044886","0508889961","0689022777"), 20000).

% lecturerEmail(lecturerId, email). 
lecturerEmail(1, "ivanenko@gmail.com").
lecturerEmail(1, "ivanenko@ukma.edu.ua").
lecturerEmail(2, "malko@gmail.com").
lecturerEmail(3, "rop@ukma.edu.ua").
lecturerEmail(4, "kopin@gmail.com").
lecturerEmail(4, "kopin@ukma.edu.ua").

% faculty(id, title, info).
faculty(1, "FI", "best faculty ever").
faculty(2, "FpVN", "pravo").
faculty(3, "FpRN", "applied").
faculty(4, "FSNST", "social").
faculty(5, "FEN", "economic").
faculty(6, "FGN", "gumanitarni").




% --------------- B ---------------

% b. Мають бути три змістовні запити до БД (на власний розсуд, але не елементарні).

% Так як запити, що входять до розділів нижче, не є елементарними і містять змістовні запити, 
% то також відносяться і до цього пункту.




% --------------- C ---------------

% c. Має бути запит з сумуванням числових даних по стовпчику таблиці чи її частини  (аналог Group by або після фільтрації where(умова)): 

% 1.	Знайти середню заробітну плату по факультетам.

lectorIsOnFaculty(LCode, FCode) :- lecturer(LCode, _, _, _),
								   teach(LCode, SCode),
								   subject(SCode, _, _, _, FCode, _).

wagesOnFaculty([], 0).
wagesOnFaculty([LCode|Other], Sum) :- lecturer(LCode, _, _, Wage),
									  wagesOnFaculty(Other, NextSum),
									  Sum is Wage + NextSum.

queryC1(FacultyName, MeanWage) :- faculty(FCode, FacultyName, _),
								  setof(Lector, lectorIsOnFaculty(Lector, FCode), LectorsOnFaculty),
								  wagesOnFaculty(LectorsOnFaculty, TotalSum),
								  length(LectorsOnFaculty, TotalCount),
								  MeanWage is TotalSum / TotalCount.

% queryC1(-Faculty, -MeanWage).
% ?- queryC1(Faculty, MeanWage).
% Faculty = "FI",
% MeanWage = 18333.333333333332 ;
% Faculty = "FpVN",
% MeanWage = 20000 ;
% Faculty = "FpRN",
% MeanWage = 20000 ;
% Faculty = "FSNST",
% MeanWage = 20000 ;

% ПРИПУСТИМІ ВАРІАНТИ АРГУМЕНТІВ

% Знайти середню заробітну плату викладачів, що викладають на певному факультеті.
% queryC1(+Faculty, -MeanWage).
% ?- queryC1("FI", MeanWage).
% MeanWage = 18333.333333333332.

% Знайти факультет з певною середньою заробітною платою.
% queryC1(-Faculty, +MeanWage).
% ?- queryC1(Faculty, 20000).
% Faculty = "FpVN" ;
% Faculty = "FpRN" ;
% Faculty = "FSNST" ;


% Для перевірки: певна заробітна плата є середньою на певному факультеті.
% queryC1(+Faculty, +MeanWage).
% ?- queryC1("FpVN", 20000).
% true.




% --------------- D ---------------

% d. Мають бути запити (правила-запити) типу:

% i. «ті» (принаймні один та можливо і інші).
% Знайти ПІБ та емейли лекторів, що ведуть хоча б один предмет, що й лектор Х

% Знаходимо множину предметів, які читає конкретний викладач.
lectorPredmet(Code,Predm) :- teach(Code,Predm).

% Знаходимо код лектора із таблиці lecturer -> 
% Знаходимо, які предмети читає даний лектор -> 
% Робимо тета-з'єднання по Коду лектора таблиць lecturer та lecturerEmail, щоб знайти емейли ->
% З усіх Кодів лекторів відбираємо тих, у яких є  запис у таблиці teach із одним з предметів, які були знайдені  у 2 кроці, не включаючи лектора, по якому шукаємо 

atLeastOneSet(S,Codes,Surname,Mail) :-  lecturer(CodeP,S,_,_),
                                 lectorPredmet(CodeP,G),
                                 lecturer(Codes,Surname,_,_),
                                 lecturerEmail(Codes,Mail),
                                 teach(Codes,G),
                                 Codes \= CodeP.
queryD1(S,Res) :- setof((Code,Surn,Mail),atLeastOneSet(S,Code,Surn,Mail),Res).


% ПРИПУСТИМІ ВАРІАНТИ АРГУМЕНТІВ
% Для кожного викладача знайти  ПІБ та емейли лекторів, що ведуть хоча б один предмет з ним
%  queryD1(-Search,-Result).
% ?- queryD1(Search,Result).
% Search = name("Ivanenko", "Ivan", "Ivanovych"),
% Result = [(2, name("Malko", "Olha", "Olgivna"), "malko@gmail.com"),  (4, name("Kopin", "Mykola", "Tarasovych"), "kopin@gmail.com"),  (4, name("Kopin", "Mykola", "Tarasovych"), "kopin@ukma.edu.ua")] ;
% Search = name("Kopin", "Mykola", "Tarasovych"),
% Result = [(1, name("Ivanenko", "Ivan", "Ivanovych"), "ivanenko@gmail.com"),  (1, name("Ivanenko", "Ivan", "Ivanovych"), "ivanenko@ukma.edu.ua"),  (2, name("Malko", "Olha", "Olgivna"), "malko@gmail.com"),  (3, name("Rop", "Maryna", "Andriivna"), % "rop@ukma.edu.ua")] ;
% Search = name("Malko", "Olha", "Olgivna"),
% Result = [(1, name("Ivanenko", "Ivan", "Ivanovych"), "ivanenko@gmail.com"),  (1, name("Ivanenko", "Ivan", "Ivanovych"), "ivanenko@ukma.edu.ua"),  (3, name("Rop", "Maryna", "Andriivna"), "rop@ukma.edu.ua"),  (4, name("Kopin", "Mykola",  %"Tarasovych"), "kopin@gmail.com"),  (4, name("Kopin", "Mykola", "Tarasovych"), "kopin@ukma.edu.ua")] ;
% Search = name("Rop", "Maryna", "Andriivna"),
% Result = [(2, name("Malko", "Olha", "Olgivna"), "malko@gmail.com"),  (4, name("Kopin", "Mykola", "Tarasovych"), "kopin@gmail.com"),  (4, name("Kopin", "Mykola", "Tarasovych"), "kopin@ukma.edu.ua")].

% queryD1(+Search,-Result).
% Для певного викладача знайти  ПІБ та емейли лекторів, що ведуть хоча б один предмет з ним
% ?- queryD1( name("Ivanenko","Ivan","Ivanovych"),Result).
% Result = [(2, name("Malko", "Olha", "Olgivna"), "malko@gmail.com"),  (4, name("Kopin", "Mykola", "Tarasovych"), "kopin@gmail.com"),  (4, name("Kopin", "Mykola", "Tarasovych"), "kopin@ukma.edu.ua")].

% queryD1(-Search,+Result).
% Знайти ПІБ та емейли лекторів, що ведуть хоча б один предмет з кожним лектором з списку Result
% ?- queryD1( L, [(2, name("Malko", "Olha", "Olgivna"), "malko@gmail.com"),  (4, name("Kopin", "Mykola", "Tarasovych"), "kopin@gmail.com"),  (4, name("Kopin", "Mykola", "Tarasovych"), "kopin@ukma.edu.ua")]).
% L = name("Ivanenko", "Ivan", "Ivanovych") ;
% L = name("Rop", "Maryna", "Andriivna").

% queryD1(+Search,+Result).
% Для перевірки: певний викладач веде хоча б 1 предмет з викладачами з списку Result 
% ?- queryD1( name("Rop", "Maryna", "Andriivna"), [(2, name("Malko", "Olha", "Olgivna"), "malko@gmail.com"),  (4, name("Kopin", "Mykola", "Tarasovych"), "kopin@gmail.com"),  (4, name("Kopin", "Mykola", "Tarasovych"), "kopin@ukma.edu.ua")]).
% true.

% --------------------

% ii. «тільки ті» (хоча б один, а інші ні).
% Знайти прізвище,ім’я та по-батькові лекторів, які читають тільки ті предмети, що й лектор X.

notLectorSubj(Lector,S) :- lecturer(CodeL,Lector,_,_),subject(S,_,_,_,_,_),not(teach(CodeL,S)).
badLectorsOnly(Lector,L) :- lecturer(L,_,_,_),notLectorSubj(Lector,Subj),  teach(L,Subj).
onlyInSubjSet(L, CodeL,Pib) :- atLeastOneSet(L,CodeL,Pib,_), not(badLectorsOnly(L,CodeL)).
queryD2(L,Result) :- setof((Codes,Surname),onlyInSubjSet(L, Codes,Surname),Result).

% ПРИПУСТИМІ ВАРІАНТИ АРГУМЕНТІВ
% Для кожного викладача знайти  ПІБ лекторів, що читають тільки ті предмети, що й він(якщо  у лектора не існує викладачів, які ведуть тільки ті ж предмети, то у результуючий список не заносимо)
% queryD2(-L,-Result).
% ?- queryD2(L,Result).
% L = name("Kopin", "Mykola", "Tarasovych"),
% Result = [(1, name("Ivanenko", "Ivan", "Ivanovych")),  (2, name("Malko", "Olha", "Olgivna")),  (3, name("Rop", "Maryna", "Andriivna"))] ;
% L = name("Malko", "Olha", "Olgivna"),
% Result = [(3, name("Rop", "Maryna", "Andriivna"))].

% queryD1(+Search,-Result).
% Для певного викладача знайти  ПІБ  лекторів,що читають тільки ті предмети, що й він(якщо  у лектора не існує таких викладачів, то відповідь запиту - false).
% ?- queryD2(name("Rop","Maryna","Andriivna"),Result).
% false.
% ?- queryD2(name("Kopin", "Mykola", "Tarasovych"),Result).
% Result = [(1, name("Ivanenko", "Ivan", "Ivanovych")),  (2, name("Malko", "Olha", "Olgivna")),  (3, name("Rop", "Maryna", "Andriivna"))].

% Знайти викладача, предмети якого читають лектори з списку Result( і у них не має 'чужих' предметів)
% ?- queryD2(Search, [(3, name("Rop","Maryna","Andriivna"))]).
% Search = name("Malko", "Olha", "Olgivna").

% queryD2(+Search,+Result).
% Для перевірки: викладачі, які задаються 2 аргументом, читають тільки ті предмети, що й лектор у 1 аргументі. 
% ?- queryD2(name("Kopin", "Mykola", "Tarasovych"), [(1, name("Ivanenko", "Ivan", "Ivanovych")),  (2, name("Malko", "Olha", "Olgivna")),  (3, name("Rop", "Maryna", "Andriivna"))]).
% true.

% --------------------

% iii. «усі ті», можливо і інші.
% Знайти програми обміну, що доступні прийнаймні всім спеціальностям що й програма InEP

% queryD3(?InEP, ?OutEP).
queryD3(InEP, OutEP) :- 
	bagof(SubjCode, regarding(InEP, SubjCode), InSubjCodes),
	exchangeProgram(OutEP, _), OutEP \= InEP,
	bagof(SubjCode, regarding(OutEP, SubjCode), OutSubjCodes), 
	subset(InSubjCodes, OutSubjCodes).

% Знайти програми обміну, що доступні прийнаймні всім спеціальностям що й програма "Erasmus+"
% ?- queryD3("Erasmus+", Res).
% Res = "Global UGRAD" ;
% Res = "AIESEC" ;
% Res = "AIESEC-2" ;
% Res = "ProCamp".

% Знайти програми обміну, що доступні прийнаймні всім спеціальностям що й програма "Camp Counselor"
% ?- queryD3("Camp Counselor", Res).
% Res = "AIESEC" ;
% Res = "ProCamp".

% Знайти програми обміну, для яких множина спеціальностей, яким вони доступні є 
% підмножиною спеціальностей, яким доступна програма "AIESEC".
% ?- queryD3(Res, "AIESEC").
% Res = "Camp Counselor" ;
% Res = "Erasmus+" ;

% --------------------

% iv. «усі ті та тільки ті».
% Знайти всі предмети, які є профорієнтованими для всіх тих і тільки тих спеціальностей, що й предмет Х.

% queryD4(+In, -Out) // queryD4(-In, +Out).

queryD4(InSubj, OutSubj) :- subject(SCodeIn, InSubj, _, _, _, _),
						   subject(SCodeOut, OutSubj, _, _, _, _),
						   setof(BranchCode, careerOriented(BranchCode, SCodeIn), CareerOrientedBranchesForInSubj),
                           setof(BranchCode, careerOriented(BranchCode, SCodeOut), CareerOrientedBranchesForOutSubj),
                           CareerOrientedBranchesForInSubj = CareerOrientedBranchesForOutSubj,
                           SCodeIn \= SCodeOut.


% ?- queryD4("JavaEE", Out).
% Out = "ASD" ;


% ПРИПУСТИМІ ВАРІАНТИ АРГУМЕНТІВ

% Всі предмети, які є профорієнтованими для одних і тих самих (всіх тих і тільки тих) спеціальностей.
% queryD4(-In, -Out).
% ?- queryD4(In, Out).
% In = "JavaEE",
% Out = "ASD" ;
% In = "ASD",
% Out = "JavaEE" ;


% Для перевірки: певні предмети, є профорієнтованими для одних і тих самих (всіх тих і тільки тих) спеціальностей.
% queryD4(+In, +Out).
% ?- queryD4("JavaEE", "ASD").
% true ;
% ?- queryD4("JavaEE", "Functional Programming").
% false.




% --------------- operators ---------------

% 7. Визначити принаймні два оператори

% 1. Лектор викладає дисципліну

:- op(500, yfx, teaches).

% teaches(?(SecondName, FirstName, Patronymic), ?(Subject, YearOfTeach)).
(SecondName, FirstName, Patronymic) teaches (Subject, YearOfTeach) :-
	lecturer(LecturerId, name(SecondName, FirstName, Patronymic), _, _),
	subject(SubjCode, Subject, YearOfTeach, _, _, _),
	teach(LecturerId, SubjCode).

% Знайти предмети які викладав або викладає Ivanenko Ivan Ivanovych.
% ?- ("Ivanenko","Ivan","Ivanovych") teaches Subject.
% Subject =  ("JavaEE", 2020) ;
% Subject =  ("JavaEE", 2019) ;
% Subject =  ("ASD", 2019) ;

% Знайти лекторів, що викладають "JavaEE" у 2020 році.
% ?- Lector teaches ("JavaEE", 2020).
% Lector =  ("Ivanenko", "Ivan", "Ivanovych") ;
% Lector =  ("Kopin", "Mykola", "Tarasovych") ;

% Перевірити чи викладає Kopin Mykola Tarasovych "Logic Programming" у 2020 році.
% ?- ("Kopin", "Mykola", "Tarasovych") teaches ("Logic Programming", 2020).

% --------------------

% 2. Дисципліна професійно орієнтована для спеціальності

:- op(600, yfx, is_career_oriented_for).

% is_career_oriented_for(?(Subject, YearOfTeach), ?(BranchTitle, Degree)).
(Subject, YearOfTeach) is_career_oriented_for (BranchTitle, Degree) :-
	subject(SubjCode, Subject, YearOfTeach, _, _, _), 
	careerOriented(BranchCode, SubjCode), branch(BranchCode, alterKey(BranchTitle, Degree), _).

% Знайти предмети, що професійно орієнтовані для комп'ютерних наук на бакалвраті.
% ?- Subject is_career_oriented_for ("computer science", "bachelor").
% Subject =  ("JavaEE", 2020) ;
% Subject =  ("ASD", 2019) ;
% Subject =  ("Logic Programming", 2020) ;
% Subject =  ("Functional Programming", 2020).

% Знайти для яких спеціальностей "Logic Programming" провесійно орієнтований у 2020 році.
% ?- ("Logic Programming", 2020) is_career_oriented_for Branch.
% Branch =  ("ipz", "bachelor") ;
% Branch =  ("computer science", "bachelor") ;
% Branch =  ("applied math", "bachelor").

% --------------------

:- op(1000, yfx, and).
A and B :- A, B.

:- op(1100, yfx, or).
A or B :- 
	A, B;
	B, not(A); 
	A, not(B).

% Знайти предмети які професійно орієнтовані для комп'ютерних наук на бакалвраті та які викладає Ivanenko Ivan Ivanovych
% ?- Subject is_career_oriented_for ("computer science", "bachelor") and ("Ivanenko", "Ivan", "Ivanovych") teaches Subject.
% Subject =  ("JavaEE", 2020) ;
% Subject =  ("ASD", 2019) ;

% Знайти предмети, які професійно орієнтовані для комп'ютерних наук або які викладає Ivanenko Ivan Ivanovych
% ?- Subject is_career_oriented_for ("computer science", "bachelor") or ("Ivanenko", "Ivan", "Ivanovych") teaches Subject.
% Subject =  ("JavaEE", 2020) ;
% Subject =  ("ASD", 2019) ;
% Subject =  ("JavaEE", 2019) ;
% Subject =  ("Logic Programming", 2020) ;
% Subject =  ("Functional Programming", 2020).
