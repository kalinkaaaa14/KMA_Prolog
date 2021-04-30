% ³��������-�����: ��������(��� ���������, �����, ������, �������, ������� ����).
% ��������(��� ���������, �����, �� �������, �������, ������� ����).
% ������ (��� ���������, ��� ���������, ����, ���, ������� �� �����).

cinema(cd1, 'Wizzard', address(kyiv, street(hryshevskyi, 23)), '0985033774', 100). 
cinema(cd2, 'Cinema City', address(kyiv, street(franko, 43)), '0551234567', 80). 
cinema(cd3, 'Start Cinema', address(kyiv, street(hryhorenko, 67)), '0444567890', 150). 
cinema(cd4, 'STAR', address(kyiv, street(holosiivska, 1)), '0509871234', 100). 
cinema(cd5, 'Watch It Cinema', address(kyiv, street(demiivska, 68)), '0973022675', 140). 

film(flm1, 'You', 2019, producer(silver,tri), 4). 
film(flm2, 'Mask', 1990, producer(chak, rassel), 1). 
film(flm3, 'Money Heist', 2020, producer(alex,pina), 81). 
film(flm4, 'Pride and Prejudice', 1997, producer(chak, rassel), 1). 
film(flm5, 'Last Christmas', 2021, producer(pol,fig), 1).

shows(cd1, flm1, date(1,january,21), time(13,00), 1000).
shows(cd1, flm3, date(1,january,21), time(10,30), 900).
shows(cd2, flm1, date(14,february,21), time(23,00), 0).
shows(cd2, flm3, date(30,december,20), time(20,00), 1600).
shows(cd3, flm2, date(6,january,21), time(17,30), 650).
shows(cd3, flm1, date(14,february,21), time(23,00), 0).
shows(cd3, flm3, date(30,december,20), time(20,00), 1600).
shows(cd4, flm4, date(7, january,21), time(19,00), 1700).
shows(cd4, flm1, date(14,february,21), time(23,00), 0).
shows(cd4, flm3, date(30,december,20), time(20,00), 1600).
shows(cd5, flm4, date(15,december,20), time(10,00), 1000).
%shows(cd5, flm5, date(17,december,20), time(10,00), 1000).
%shows(cd5, flm1, date(14,february,21), time(23,00), 0).
%shows(cd5, flm3, date(30,february,20), time(20,00), 1600).
shows(cd5, flm2, date(28,february,20), time(20,00), 1600).


% �������� 1: ������� � ����� ���������, �� ������ �������� �����; 
task1(Film,Cinema,Phone) :- shows(CodeC, CodeF, _, _, _),
                                    film(CodeF, Film, _, _, _),
                                    cinema(CodeC,Cinema, _,Phone, _).

% �������� 2: ʳ�������� � ���� ����� ������ �������� ��������(���� � 1); 
findIdCinemaByDirector(Producer,Cinema) :-  film(CodeF, _, _, Producer, _),
                                          cinema(Cinema, _, _, _, _),
                                          shows(Cinema, CodeF, _, _, _).

findCinemaName(Producer, Result) :- findIdCinemaByDirector(Producer,Cinema), cinema(Cinema, Result,_,_,_).

% ��� ������� ��������       
task2(Producer,Result) :- setof(Cin, findCinemaName(Producer,Cin), Result).

% �������� 3: ������ ��������� � ���� ����� Ҳ���� ������ �������� �������� 
% ʳ��������, � ���� ��������� ���� � 1 ����� �������� �������� - ����� ���������(���������, �� ��������� ���� � 1 ����� �� ����� ��������)

badFilms(Producer, Film) :- film(Film,_,_,_,_),
                           not(film(Film,_,_,Producer,_)).

badCinemas(Producer,Res) :-cinema(Res,_,_,_,_),
                            shows(Res,Film,_,_,_),
                            badFilms(Producer, Film).
 
findSet(Producer, Res) :- findIdCinemaByDirector(Producer,CinemaId),
                        not(badCinemas(Producer, CinemaId)),
                        cinema(CinemaId,Res,_,_,_). 

task3(Producer,Res) :- setof(Cin, findSet(Producer,Cin),Res).

% �������� 4: ������ ������, �� ����� � ��� ����������

% ������, �� �� ����� ���� � � 1 ��������
badFilmsAllCinema(Result) :- film(Result,_,_,_,_),
                             cinema(CodeC,_,_,_,_),
                             not(shows(CodeC,Result,_,_,_)).

task4(Result) :- film(Code,Result,_,_,_),
                 not(badFilmsAllCinema(Code)).
 
% �������� 5: ������ �� ������, �� ����� � ��������� �������� ��������� ��� � �������� ��� 
task5(Film,Cinema,Day,Time) :- shows(CodeC,CodeF,Day,Time,_),
                               cinema(CodeC,Cinema,_,_,_),
                               film(CodeF,Film,_,_,_).


% �������� 6: ������ ��������� �����(����� � ��������� ����� �������)
% �������������� ������, ��� ����� ���� ����������� ������� ���

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
