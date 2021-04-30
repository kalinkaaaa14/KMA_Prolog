family( 
      member( tom, fox, date(7,may,1964),nworks),
      member( ann, fox, date(9,may,1981), works(bbc,15200)),
      [member(pat, fox, date(5, may, 1981), works(h, 5000)),
       member(jim, fox, date(3, may, 1973), nworks),
       member(al,fox,date(5,may,1981),nworks)]).

family( 
      member( tom, ras, date(8,june,1953),nworks),
      member( ann, ras, date(8,june,1965),nworks),
      []).

% all Fox in db - family( member(_, fox, _, _), _, _ ).
% families with 2 children - family(_,_, [_,_] ).
% all married women who has at least 2 children - family(_,member(Name, Surname,_,_),[_,_|_]).

husband(X) :- family(X, _,_).
wife(X) :- family(_,X,_).
child(X) :- family(_,_,Children), isMember(X,Children).
isMember(X, [X | _]).
isMember(X, [_ | L]) :- isMember(X, L).
exists(Member) :- husband(Member);
                  wife(Member);
                  child(Member).
birthday(member(_,_,Bday,_), Bday).
income(member(_,_,_,works(_,S)),S).
income(member(_,_,_,nworks),0).

commonIncome([],0).
commonIncome([Person | List], Sum) :- income(Person, S), commonIncome(List, Others), Sum is S + Others.

% common income of the family - family(Husband,Wife,Children), commonIncome([Husband, Wife | Children], Income).
% all people from db - exists(member(Name,Surname,_,_)).

% �������� 4.1
% 1. ��� ����, �� ���������� � 1981 - child(X), birthday(X, date(_,_,1981) ).
% 2. ��� ����, �� �� �������� - wife(member(Name,Surname,_,nworks)).
% 3. ��� �����, �� �� ��������, ��� �� ������� ��������� ���. - exists(member(Name,Surname,date(_,_,Year),nworks)), Year > 1962.
% 4. ��� �����, �� ���������� �� 1961, �� ��� �������� ����� 10000. - exists(Member), birthday(Member, date(_,_,Year)), Year < 1961, income(Member, Inc), Inc < 10000.
% 5. ������� �����, �� ����� ���� � ����� ����. - family(member(_,Surname,_,_),_,[_,_,_|_]).
% 6. ������ ��� ���� - family(member(_,Surname,_,_),_,[]).
% 7. ��� ��������� ���� - child(member(Name,Surname,_,works(_,_))).
% 8. ������, �� ���� ������, � ������ � - family(member(_,Surname,_,nworks), member(_,_, _, works(_,_)),_).
% 9. ��� ����, ��� ���� ������ � ��� �� ������ ����� 15 ����. - family(member(_,_,date(_,_,YearH),_), member(_,_,date(_,_,YearW),_),Children), YearH - YearW >15; family(member(_,_,date(_,_,YearH),_), member(_,_,date(_,_,YearW),_),Children), YearW - YearH >15.

% �������� 4.2
delete(X, [X | Others], Others).
delete(X, [Y | Others], [Y | Others1]) :- delete(X, Others, Others1).

birthdayEqual(member(_,_,Bday,_), member(_,_,Bday,_)).

twins(Child1, Child2) :- family(_,_,Children), delete(Child1, Children,OthersChildren),isMember(Child2,OthersChildren),birthdayEqual(Child1,Child2).

%�� � ���������� ��� ����? - twins(member(pat, fox, date(5, may, 1981), works(h, 5000)),member(al,fox,date(5,may,1981),nworks)). - true
