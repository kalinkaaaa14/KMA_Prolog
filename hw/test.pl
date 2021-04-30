dog(sharik).
dog(tuzik).

cat(pushok).
cat(druzgok).
cat(tuzik).

hamster(pit).

man(bill,ton).
man(george,mat).
man(barak, pol).
man(platon, ren).
man(sokrat, wer).

woman(ann).
woman(kate).
woman(pam).

dead(sharik).
dead(platon).
dead(sokrat).

age(sharik, 18). 
age(tuzik, 10). 
age(pushok, 5).
age(druzhok, 2).
age(bill, 62).
age(george, 62).
age(barak, 47).
age(sokrat, 70).
age(platon, 80).
age(ann, 20).
age(kate, 25).
age(pam, 30).

animal(X) :-
    dog(X); 
    cat(X);
    hamster(X).

animal(X) :- dog(X), !.
animal(X) :-  cat(X), !.
animal(X) :- hamster(X).
animal(X) :- dog(X), !; cat(X), !; hamster(X). 

human(X) :-
    man(X,_); 
    woman(X).
 
living(X) :-
    animal(X);
    human(X).

human_ages(X,Y) :- human(X),
                   age(X,Y).

man_woman(X,Y) :- man(X,_),woman(Y).

return_woman(Y) :- man_woman(_,Y).

alive(X) :-
    living(X),
    \+ dead(X).

old(X) :-
    (   animal(X),
        age(X, Age),
        Age >= 10 
    ;   human(X),
        age(X, Age),
        Age >= 70 
    ), 
    \+ dead(X).


age_18_52(X) :- age(X,Y), 
                Y > 18,
                Y < 52.


man_ages(X,Y,Z) :- man(X,Y),
                   age(X,Z). 





