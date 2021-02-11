/* A) estados finais */
% objetivo((2,0)).
% objetivo((2,1)).
% objetivo((2,2)).
% objetivo((2,3)).

objetivo((2,_)).

/* B) Descrever as ações de encher, esvaziar e passar */

acao((J1,J2),encher1,(4,J2)):- J1<4.
acao((J1,J2),encher2,(J1,3)):- J2<3.
acao((J1,J2),esvaziar1,(0,J2)):- J1>0.
acao((J1,J2),esvaziar2,(J1,0)):- J2>0.

acao((J1,J2),passa12,(J1a, J2a)):- 
     J1>0,
     J2<3,
     Capacidade is 3-J2,
     J1 > Capacidade ,
     J1a is J1-Capacidade,
     J2a is J2+Capacidade.

acao((J1,J2),passa12,(J1a, J2a)):-
    J1>0,
    J2<3,
    Capacidade is 3-J2,
    J1 =< Capacidade ,
    J1a is 0,
    J2a is J2+J1.

acao((J1,J2), passa21, (J1a,J2a)) :-
  J2 > 0,
  J1 < 4,
  Capacidade is 4 - J1,
  Capacidade < J2,
  J1a is J1 + Capacidade,
  J2a is J2 - Capacidade.

acao((J1,J2), passa21, (J1a,J2a)) :-
  J2 > 0,
  J1 < 4,
  Capacidade is 4 - J1,
  Capacidade >= J2,
  J1a is J1 + J2,
  J2a is 0.


/* C) Obter instâncias usando o Findall */
vizinhos(N, FilhosN) :-
    findall(N1, acao(N, _, N1), FilhosN).


/* D) busca em largura  */
% Consulta: busca_em_largura(([(0,0)])).
/* 
 * Retorna True indefinidamente. Isto ocorre porque a árvore de busca que é gerada não é armazenada.
 */ 

busca_em_largura([N|_]):-
    objetivo(N).

busca_em_largura([N|F1]):-
    vizinhos(N,NN),
    adicionar_fronteira(NN,F1,F2),
    busca_em_largura(F2).

adicionar_fronteira(NN, F1, F2):-
    append(F1, NN, F2).


/* E) Guardar a sequência de configurações dos estados das jarras */

% Consulta: busca_em_largura_armazenado([(0,0)], L).

busca_em_largura_armazenado([N|_], [N]):- objetivo(N).

busca_em_largura_armazenado([N|F1], [N|L]):-
    vizinhos(N,FilhosN),
    adicionar_fronteira(FilhosN,F1,F2),
    busca_em_largura_armazenado(F2,L).


/* F) Desconsiderar os nós que já foram gerados anteriormente para impedir repetição. */
% Consulta: busca_em_largura_limpo(([(0,0)]),(0,0),L).
% Realizando a consulta, apenas um nó se repete que é o (0,0), quando a busca retorna à raiz 

diferente([], _, []) :- !.
diferente(L, [], L) :- !.
diferente(L, L, []) :- !.

diferente([H|T], L2, L3) :-
    member(H, L2), !,
    diferente(T, L2, L3), !.

diferente([H|T], L2, [H|T1]) :-
    diferente(T, L2, T1).

busca_em_largura_limpo([N|_], _, [N]) :- objetivo(N).

busca_em_largura_limpo([N|F], Visitados, [N|T]) :-
    vizinhos(N, FilhosN),
    diferente(FilhosN, Visitados, FilhosU),
    append(FilhosU, Visitados, Visitados1),
    adicionar_fronteira(FilhosU, F, F1),
    busca_em_largura_limpo(F1, Visitados1, T).

% ------------------------------------------------------- %

 /* Letra G - Repetir exercícios para
 * BUSCA EM PROFUNDIDADE
 */

/* D) */

% Consulta: busca_em_profundidade(([(0,0)])).
% Resultado: 'Stack limit (0.2Gb) exceeded'.
/* 
 * O problema ocorre porque não há o armazenamento dos nós que foram gerados e visitados.
 * Uma vez que a busca em profundidade chega ao final do caminho e o descarta, não há como saber que tal caminho já foi gerado
 * e já foi percorrido, caindo em um loop infinito. 
 */

adicionar_fronteira_2(NN, F1, F2):-
    append(NN, F1, F2).

busca_em_profundidade([N|_]):- objetivo(N).

busca_em_profundidade([N|F1]):-
    vizinhos(N, FilhosN),
    adicionar_fronteira_2(FilhosN,F1,F2),
    busca_em_profundidade(F2).


/* E) Guardar a sequência de configurações dos estados das jarras */
% Consulta: busca_em_profundidade_arm_rev((0,0), X).

vizinhos_c([N|C], FilhosN):-
    findall([N1,N|C], acao(N,_,N1), FilhosN).

busca_em_profundidade_armazenado([[N|C]|_], [N|C]):-
    objetivo(N).

busca_em_profundidade_armazenado([C|F], R):-
    vizinhos_c(C,FilhosN),
    adicionar_fronteira_2(FilhosN,F,F2),
    busca_em_profundidade_armazenado(F2,R).

busca_em_profundidade_arm_rev(E, L):-
    busca_em_profundidade_armazenado([[E]], S),
    reverse(S, L).
                              

/* F) Desconsiderar os nós que já foram gerados anteriormente para impedir repetição. */
% Consulta: busca_em_profundidade_limpo_rev((0,0),X).

vizinhos_c_limpo([N|C], ListaArm, FilhosN) :-
    findall([N1, N|C], (acao(N, _, N1), \+(member(N1, ListaArm))), FilhosN).

busca_em_profundidade_limpo([[N|C]|_], _, [N|C]):- objetivo(N).

busca_em_profundidade_limpo([C|F1], ListaArm, R) :-
    vizinhos_c_limpo(C,ListaArm,FilhosN),
    flatten(FilhosN,FilhosF),
    append(FilhosF,ListaArm,ListaArm1),
    adicionar_fronteira(FilhosN,F1,F2),
    busca_em_profundidade_limpo(F2,ListaArm1,R).
    
busca_em_profundidade_limpo_rev(E,L):-
    busca_em_profundidade_limpo([[E]],[E],R),
    reverse(R,L).
