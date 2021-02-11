% Faça um programa Prolog que recebe um número X e uma lista ordenada de forma crescente L1, e retorna a lista ordenada L2 que é obtida acrescentando X a L1. Você não pode usar nenhum predicado pré-definido do swipl.
% Casos de teste utilizados: add_to_list(7,[],L2).	| 	add_to_list(1,[2,5],L2).   |    add_to_list(2,[2,5],L2).   |add_to_list(3,[2,4],L2).   | 	add_to_list(4,[2,4],L2). 	|   	add_to_list(5,[2,4],L2).	
add_to_list(X, [], [X]).

add_to_list(X, L1, [X|L1]):-
    L1 = [H|_],
    X =< H.

add_to_list(X, [H|T], Y):-
    X >= H,
    T \= [],
    add_to_list(X, T, Z),
    Y = [H | Z].

add_to_list(X, [H|T], Y):-
    X >= H,
    T == [],
    Y = [H, X].


% Faça um programa Prolog que dado um número qualquer X maior ou igual a zero, retorna em uma lista L, todos os múltiplos de 4 que são menores ou iguais a  X. 
% Casos de teste utilizados:
get_multiples_of_4(X, L) :-
	X >= 0,
    X is X + 1,
    operation(X, L).

operation(X, L) :-
    X is X -1,
    X > 0,
    0 is X_ mod 4,
    L = [X|L],
	operation(X_, L).

% quando X chegar a zero
operation(X, L) :-
    X_ is X_ - 1,
    X_ == 0,
    L = [_|0].
