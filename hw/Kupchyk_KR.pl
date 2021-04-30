злиття([ ], L, L).
злиття([X|L1], L2, [X|L]):- злиття(L1, L2, L).

member1(X,L) :- злиття(_,[X|_],L).

duplicate([M],Result) :- member(M,Result), !.
duplicate([M],Result) :- Result is [M|Result],!.
duplicate([M|List],Result):- member1(M,List), duplicate([List],[Result]).
duplicate([M|List],Result):- not(member1(M,List)), duplicate([List],[M|Result]). 

