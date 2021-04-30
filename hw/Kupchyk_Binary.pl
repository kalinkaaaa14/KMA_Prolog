% додаткова функція
appen([],L,L).
appen([First|Sublist1],Sublist2,[First|Rsult]):-appen(Sublist1,Sublist2,Rsult).

% Бінарні дерева
% Скласти та налагодити програми визначення:
% 1. Послідовності вузлів при обході в глибину бінарного дерева праворуч
% ?- lftToRight(tree(nil,x,nil),R).
% R = [x].
% ?- lftToRight(nil,R).
% R = [].
% ?- lftToRight(tree(tree(tree(tree(nil,0,nil),1,nil),2,tree(nil,3,nil)),4,tree(nil,5,tree(tree(nil,6,tree(nil,7,nil)),8,nil))),R).
% R = [0, 1, 2, 3, 4, 5, 6, 7, 8].
% ?- lftToRight(tree(tree(nil,5,tree(nil,6,tree(nil,7,nil))),4,tree(nil,3,tree(nil,2,tree(nil,1,nil)))),R).
% R = [5, 6, 7, 4, 3, 2, 1].

lftToRight(nil,[]):-!.
lftToRight(tree(Lft,X,Right),Rsult):-lftToRight(Lft,Rs1),lftToRight(Right,Rs2),appen(Rs1,[X|Rs2],Rsult),!.

% 2. Визначення кількості листків бінарного дерева.
% ?- quentityLeaves(tree(tree(nil,5,tree(nil,6,tree(nil,7,nil))),4,tree(nil,3,tree(nil,2,tree(nil,1,nil)))),R).
% R = 2.
% ?- quentityLeaves(tree(tree(tree(tree(nil,0,nil),1,nil),2,tree(nil,3,nil)),4,tree(nil,5,tree(tree(nil,6,tree(nil,7,nil)),8,nil))),R).
% R = 3.
% ?- quentityLeaves(nil,R).
% R = 0.
% ?- quentityLeaves(tree(nil,x,nil),R).
% R = 1.

quentityLeaves(nil,0) :- !.
quentityLeaves(tree(nil, _, nil),1) :-!.
quentityLeaves(tree(Lft, _, Right), Rsult) :- quentityLeaves(Lft, LftQuantity),
                                                                               quentityLeaves(Right, RightQuantity),
                                                                               Rsult is LftQuantity + RightQuantity, !.

% 3. Визначення висоту бінарного дерева.
%  Висота бінарного дерева Т:
   % висота порожнього дерева Т рівна H(T)=0;
    % висота непорожнього бінарного дерева Т з батьком та піддеревами Т1 і Т2: H(T)=1+max(H(T1), H(T2)).
% ?- heightBinTree(tree(tree(nil,5,tree(nil,6,tree(nil,7,nil))),4,tree(nil,3,tree(nil,2,tree(nil,1,nil)))),R).
% R = 4.
% ?- heightBinTree(tree(tree(tree(tree(nil,0,nil),1,nil),2,tree(nil,3,nil)),4,tree(nil,5,tree(tree(nil,6,tree(nil,7,nil)),8,nil))),R).
% R = 5.
% ?- heightBinTree(nil,R).
% R = 0.
% ?- heightBinTree(tree(nil,x,nil),R).
% R = 1.

heightBinTree(nil, 0):-!.
heightBinTree(tree(Lft,_,Right), Rsult) :- heightBinTree(Lft, Lftheight), 
                                                                           heightBinTree(Right, Rightheight), 
                                                                           Max is max(Lftheight, Rightheight), 
                                                                           Rsult is 1+Max.

% 4.Визначення кількість вузлів у бінарному дереві.
% ?- quentityNodes(tree(tree(nil,5,tree(nil,6,tree(nil,7,nil))),4,tree(nil,3,tree(nil,2,tree(nil,1,nil)))),R).
% R = 7.
% ?- quentityNodes(tree(tree(tree(tree(nil,0,nil),1,nil),2,tree(nil,3,nil)),4,tree(nil,5,tree(tree(nil,6,tree(nil,7,nil)),8,nil))),R).
% R = 9.
% ?- quentityNodes(nil,R).
% R = 0.
% ?- quentityNodes(tree(nil,x,nil),R).
% R = 1.

quentityNodes(nil,0).
quentityNodes(tree(Lft, _, Right), Rsult) :- quentityNodes(Lft, LftQuantity), 
                                                                               quentityNodes(Right, RightQuantity), 
                                                                              Rsult is 1 + LftQuantity + RightQuantity.

% 2-3-дерева
% Скласти та налагодити програми:
% 5. Обходу 2-3-дерева
% ?- obhid23Tree(nil,R).
% R = [].
% ?- obhid23Tree(v2(nil,a,v3(v2(nil,b,nil),f,v2(v2(nil,k,nil),t,nil),w,v3(nil,q,nil,w,v2(v2(nil,p,nil),s,nil)))),R).
% R = [a, b, f, k, t, w, q, w, p|...].
% ?- obhid23Tree(v2(v2(nil,k,nil),t,nil),R).
% R = [k, t].
% ?- obhid23Tree(v3(nil,1,nil,2,v2(v2(nil,4,nil),5,nil)),R).
% R = [1, 2, 4, 5].

obhid23Tree(nil,[]):-!.
obhid23Tree(l(X),[X]):-!.
obhid23Tree(v2(Lft,Mil,Right),Rsult) :- obhid23Tree(Lft,Obhi1Rs),
                                                                       obhid23Tree(Right,Obhi2Rs),
                                                                       appen(Obhi1Rs,[Mil|Obhi2Rs],Rsult) , !.

obhid23Tree(v3( Lft,X,Mil,Y,Right),Rsult) :- obhid23Tree(Lft,Obhi1Rs),
                                                                                obhid23Tree(Mil,Obhi2Rs), 
                                                                                obhid23Tree(Right,Obhi3Rs),
                                                                                appen(Obhi1Rs,[X|Obhi2Rs],Rs1),appen(Rs1,[Y|Obhi3Rs],Rsult), !.

% 6. Пошуку заданого елемента в 2-3-дереві.
% Видає стільки раз true, скільки присутніх таких елемеентів, яких шукаємо 2 арг
% ?- findElemIn23Tr(v2(nil,a,v3(v2(nil,b,nil),f,v2(v2(nil,k,nil),t,nil),w,v3(nil,q,nil,w,v2(v2(nil,p,nil),s,nil)))),s).
% true ;
% false.
%?- findElemIn23Tr(v2(v2(nil,k,nil),t,nil),s).
% false.
%?- findElemIn23Tr(nil,5).
%false.
% ?- findElemIn23Tr(v3(nil,1,nil,2,v2(v2(nil,4,nil),5,nil)),2).
% true ;
% false.

findElemIn23Tr(l(X), Y) :- X==Y.
findElemIn23Tr(v2(Lft,Mil,Right),Elm) :- Mil==Elm;
                                                                          findElemIn23Tr(Lft,Elm);
                                                                          findElemIn23Tr(Right,Elm).
findElemIn23Tr(v3(Lft,X,Mil,Y,Right),Elm) :- X==Elm;
                                                                                  Y==Elm;
                                                                                  findElemIn23Tr(Lft,Elm);
                                                                                  findElemIn23Tr(Mil,Elm);
                                                                                  findElemIn23Tr(Right,Elm).

% 7. Написати програму, яка перевірить чи є заданий об'єкт.
% бінарним деревом
% ?- checkBinaryTr(tree(tree(tree(tree(nil,0,nil),1,nil),2,tree(nil,3,nil)),4,tree(nil,5,tree(tree(nil,6,tree(nil,7,nil)),8,nil)))).
% true.
% ?- checkBinaryTr(tree(tree(nil,5,tree(nil,6,tree(nil,7,nil))),4,tree(nil,3,tree(nil,2,tree(nil,1,nil))))).
% true.
% ?- checkBinaryTr((tree(tree(nil,5,tree(nil,6,tree(nil,7,nil))),4,tree(nil,3)))).
% false.

checkBinaryTr(nil).
checkBinaryTr(tree(Lft, _, Right)) :- checkBinaryTr(Lft),
                                                                  checkBinaryTr(Right).

% 2-3 деревом
% ?- check23Tree(v2(nil,a,v3(v2(nil,b,nil),f,v2(v2(nil,k,nil),t,nil),w,v3(nil,q,nil,w,v2(v2(nil,p,nil),s,nil))))).
% true.
% ?- check23Tree(v2(nil,a,v3(v2(nil,b,nil),v2(v2(nil,k,nil),f,t,nil),w,v3(nil,q,nil,w,v2(v2(nil,p,nil),s,nil))))).
% false.
% ?- check23Tree(v2(v2(nil,k,nil),t,nil)).
% true.
% ?- check23Tree(v2(u,t,nil)).
% false.

check23Tree(nil).
check23Tree(v2(Tr1, _, Tr2)) :-  check23Tree(Tr1), 
                                                        check23Tree(Tr2).
check23Tree(v3(Tr1, _, Tr2, _, Tr3)) :- check23Tree(Tr1), 
                                                                   check23Tree(Tr2),
                                                                   check23Tree(Tr3).