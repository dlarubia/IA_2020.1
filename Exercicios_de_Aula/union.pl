% Faça um programa Prolog que dadas duas listas L1 e L2, retorne a lista L3 que é a união de L1 e L2. Note que nesta união não pode haver elementos repetidos.
union(L1, [], L1).

union([], L2, L2).

union(L1, [H|T], [H|X]) :-
    not(member(H, L1)),!,
    union(L1, T, X).

union(L1, [_|T], L3) :-
    union(L1, T, L3).
    

% ----------------------------------------------


% Faça um programa Prolog que dadas duas listas L1 e L2, retorne a lista L3 que contém todos os elementos de L1 que não estão em L2.
is_only_in_l1([], _, []).

is_only_in_l1([H|T], L2, L3):-
    member(H,L2),!,
    is_only_in_l1(T, L2, L3).

is_only_in_l1([H|T], L2, L3):-
    is_only_in_l1(T, L2, X),
    L3 = [H|X].
