% Відношення-факти: кінотеатр(код кінотеатру, назва, адреса, телефон, кількість місць).
% кінофільм(код кінофільму, назва, рік випуску, режисер, кількість серій).
% показує (код кінотеатру, код кінофільму, дата, час, виручка за сеанс).

% Запускати запити через task1() - task6()

cinema(cd1, 'Wizzard', 'Kyiv, Hryshevskyi Str, 23', '0985033774', 100). 
cinema(cd2, 'Cinema City', 'Kyiv, Franko Str, 43a', '0551234567', 80). 
cinema(cd3, 'Start Cinema', 'Kyiv, Hryhorenko Prospect, 67', '0444567890', 150). 
cinema(cd4, 'STAR', 'Kyiv, Holosiivska Str, 1', '0509871234', 100). 
cinema(cd5, 'Watch It Cinema', 'Kyiv, Demiivska Str, 68', '0973022675', 140). 

film(flm1, 'You', 2019, 'Silver Tri', 4). 
film(flm2, 'Mask', 1990, 'Chak Rassel', 1). 
film(flm3, 'Money Heist', 2020, 'Alex Pina', 81). 
film(flm4, 'Pride and Prejudice', 1997, 'Chak Rassel', 1). 
film(flm5, 'Last Christmas', 2021, 'Pol Fig', 1).

shows(cd1, flm1, '01.01.21', '13:00', 1000).
shows(cd1, flm3, '01.01.21', '10:30', 900).
shows(cd2, flm1, '14.02.21', '23:00', 0).
shows(cd2, flm3, '30.12.20', '20:00', 1600).
shows(cd3, flm2, '06.01.21', '17:30', 650).
shows(cd3, flm1, '14.02.21', '23:00', 0).
shows(cd3, flm3, '30.12.20', '20:00', 1600).
shows(cd4, flm4, '07.01.21', '19:00', 1700).
shows(cd4, flm1, '14.02.21', '23:00', 0).
shows(cd4, flm3, '30.12.20', '20:00', 1600).
shows(cd5, flm4, '15.12.20', '10:00', 1000).
shows(cd5, flm5, '17.12.20', '10:00', 1000).
shows(cd5, flm1, '14.02.21', '23:00', 0).
shows(cd5, flm3, '30.12.20', '20:00', 1600).

% Завдання 1: Телефон і назва кінотеатру, що показує потрібний фільм; 
task1(Film,Cinema,Phone) :- shows(CodeC, CodeF, _, _, _),
                                    film(CodeF, Film, _, _, _),
                                    cinema(CodeC,Cinema, _,Phone, _).

% Завдання 2: Кінотеатри в яких йдуть фільми заданого режисера(хоча б 1); 
findIdCinemaByDirector(Producer,Cinema) :-  film(CodeF, _, _, Producer, _),
                                          cinema(Cinema, _, _, _, _),
                                          shows(Cinema, CodeF, _, _, _).

findCinemaName(Producer, Result) :- findIdCinemaByDirector(Producer,Cinema), cinema(Cinema, Result,_,_,_).

% щоб забрати дублікати       
task2(Producer,Result) :- setof(Cin, findCinemaName(Producer,Cin), Result).

% Завдання 3: Знайти кінотеатри в яких йдуть ТІЛЬКИ фільми заданого режисера 
% Кінотеатри, в яких показують хоча б 1 фільм заданого режисера - погані кінотеатри(кінотеатри, які показують хоча б 1 фільм не цього режисера)

badFilms(Producer, Film) :- film(Film,_,_,_,_),
                           not(film(Film,_,_,Producer,_)).

badCinemas(Producer,Res) :-cinema(Res,_,_,_,_),
                            shows(Res,Film,_,_,_),
                            badFilms(Producer, Film).
 
findSet(Producer, Res) :- findIdCinemaByDirector(Producer,CinemaId),
                        not(badCinemas(Producer, CinemaId)),
                        cinema(CinemaId,Res,_,_,_). 

task3(Producer,Res) :- setof(Cin, findSet(Producer,Cin),Res).

% Завдання 4: Знайти фільми, які йдуть у всіх кінотеатрах

% фільми, які не йдуть хоча б у 1 кінотеатрі
badFilmsAllCinema(Result) :- film(Result,_,_,_,_),
                             cinema(CodeC,_,_,_,_),
                             not(shows(CodeC,Result,_,_,_)).

task4(Result) :- film(Code,Result,_,_,_),
                 not(badFilmsAllCinema(Code)).
 
% Завдання 5: Знайти усі фільми, які йдуть у потрібному кінотеатрі потрібного дня і потрібний час 
task5(Film,Cinema,Day,Time) :- shows(CodeC,CodeF,Day,Time,_),
                               cinema(CodeC,Cinema,_,_,_),
                               film(CodeF,Film,_,_,_).


% Завдання 6: Знайти найновіший фільм(фільм з найбільшим роком випуску)
% використовуючи списки, щоб легше було відсортувати множину дат

findAllTimes(Times) :- findall(T, film(_,_,T,_,_), Times).

bubble_sort(List,Sorted) :- b_sort(List,[],Sorted).
b_sort([],Acc,Acc).
b_sort([H|T],Acc,Sorted) :- bubble(H,T,NT,Max),b_sort(NT,[Max|Acc],Sorted).   
bubble(X,[],[],X).
bubble(X,[Y|T],[Y|NT],Max) :- X>Y,bubble(X,T,NT,Max).
bubble(X,[Y|T],[X|NT],Max) :- X=<Y,bubble(Y,T,NT,Max).

lastEl([X],X).
lastEl([_|Xs],X) :- lastEl(Xs,X).

task6(Film) :- findAllTimes(Alltimes),
               bubble_sort(Alltimes,Sorted),
               lastEl(Sorted,FinalYear),
               film(_,Film,FinalYear,_,_).
