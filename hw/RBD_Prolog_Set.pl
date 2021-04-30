lector(l1,petrenko,naukma, 0985033774,specialist).
lector(l2,sydorenko,institut_of_cybernetics,0558765412,doctor).
lector(l3,fedorenko,shevchenko_uviversity,0986542234,magistr).
lector(l4,medychenko, naukma,0987896653,doctor).

subject(s1,algebra,lecture,2).
subject(s2,virusology,lecture,4).
subject(s3,moop,lecture,3).
subject(s4,java,lecture,3).
subject(s5,oop,lecture,2).

group(g1,informatics,1,30).
group(g2,informatics,1,30).
group(g3,informatics,2,15).
group(g4,fsnst,1,30).
group(g5,fsnst,2,20).

timetable(l1,s1,g1,monday,202,1).
timetable(l1,s1,g2,monday,202,2).
timetable(l2,s2,g1,tuesday,202,1).
timetable(l3,s4,g1,wednesday,203,1).
timetable(l3,s4,g2,wednesday,203,1).
timetable(l4,s3,g4,wednesday,203,1).


% групи, які не веде петренко
notPGroups(G) :- lector(CodeP,petrenko,_,_,_),group(G,_,_,_),not(timetable(CodeP,_,G,_,_,_)).

% лектори, які ведуть хоч одну групу не Петренка
badLectorsOnly(L) :- lector(L,_,_,_,_),notPGroups(Gr), timetable(L,_,Gr,_,_,_).


lector_group(L,G) :- lector(L,_,_, _,_), 
                     timetable(L,_,G,_,_,_).

%  Завдання 1: хоча б 1 групі Петренка
atLeastOneSet(Codes,Surname) :-  lector(CodeP,petrenko,_,_,_),
                                 lector_group(CodeP,G),
                                 timetable(Codes,_,G,_,_,_),
                                 Codes \= CodeP,
                                 lector(Codes,Surname,_,_,_).
% без повторів
firstTask(Res) :- setof((CodeL,Surn),atLeastOneSet(CodeL,Surn),Res).

% Завдання 2: у всіх групах Петренка
% - лектори які не читають у якійсь із груп Петренка
badLectors(CodeL) :- lector(CodeP,petrenko,_,_,_),
                     lector_group(CodeP,G),
                     lector(CodeL,_,_,_,_),
                     not(timetable(CodeL,_,G,_,_,_)).

secondTask(Lectors,Surname) :- lector(CodeP,petrenko,_,_,_),
                               lector(Lectors,Surname,_,_,_),
                               not(badLectors(Lectors)),
                               CodeP \= Lectors.

% Завдання 3: тільки у групах Петренка (від хоча б одного відняти поганих лекторів)
  
onlyInGroupsSet(Codes,Surname) :- atLeastOneSet(Codes,Surname),
                                  not(badLectorsOnly(Codes)).

thirdTask(Result) :- setof((Codes,Surname),onlyInGroupsSet(Codes,Surname),Result).

% Завдання 4: у тих і тільки тих групах, що викладає Петренко
fourthTask(Codes,Surname) :- secondTask(Codes,Surname), not(badLectorsOnly(Codes)).
