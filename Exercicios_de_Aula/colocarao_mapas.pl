% O que eu gostaria de fazer era um algoritmo que funciona da seguinte forma:
%% 1. Recebe uma lista de países que serão coloridos e uma variável X que será consultada, tal variável retornaria uma lista no estilo [coloracao(brasil,amarelo), coloracao(argentina,vermelho),...]
%% --> ? - colorir([brasil, chile, uruguai, paraguai], X).
%% resposta: [coloracao(brasil, amarelo), coloracao(argentina, vermelho), ...]
%% 2. Inicia pelo primeiro país e o pinta de uma cor, em seguida, passa para o próximo país da lista e verifica se a próxima cor está disponível ou se já existe algum adjacente utilizando. Caso a cor esteja livre, pinta o país
%% 3. A abordagem acima funciona até certo ponto, porque pode acontecer de um vértice com maior grau causar problema na coloração ao chegar num ponto em que algum vértice não haja nenhuma cor disponível para pintar um país, portanto seria necessário fazer 'backtracking'.
%% 4. Visto que não haviam cores disponíveis para o país N, seria necessário retornar ao país N-1 e verificar se o mesmo poderia ser pintado de outra cor. Caso fosse possível, pintaria e avançaria para o país N e tentaria novamente pintá-lo. Caso funcionasse, o mesmo seria pintado. Se não funcionasse, retornaria ao país N-1 e testaria outra cor. Caso não houvessem mais cores à serem pintadas para tal país, retornaria ao N-2 e repetiria o processo. E assim por diante.
%% 5. Embora não seja um algorimo eficiente por ser força bruta, eu acreditava que seria o mais simples possível para se implementar no Prolog, entretanto não consegui avançar com o mesmo.
%% 6. Defini somente os predicados contendo as cores, países e adjacências, infelizmente não soube como utilizá-los.

cor(azul).
cor(verde).
cor(vermelho).
cor(amarelo).

pais(brasil).
pais(guianaFrancesa).
pais(suriname).
pais(guiana).
pais(colombia).
pais(equador).
pais(peru).
pais(bolivia).
pais(chile).
pais(argentina).
pais(paraguai).
pais(uruguai).

fronteiras(brasil, [guianaFrancesa, suriname, guiana, venezuela, colombia, peru, bolivia, paraguai, argentina, uruguai]).
fronteiras(guianaFrancesa, [brasil, suriname]).
fronteiras(suriname, [guianaFrancesa, guiana, brasil]).
fronteiras(guiana, [suriname, venezuela, brasil]).
fronteiras(colombia, [venezuela, brasil, equador, peru]).
fronteiras(equador, [colombia, peru]).
fronteiras(peru, [brasil, colombia, equador, brasil, bolivia, chile]).
fronteiras(bolivia, [brasil, peru, chile, argentina, paraguai]).
fronteiras(chile, [peru, bolivia, argentina]).
fronteiras(argentina, [uruguai, brasil, paraguai, bolivia, chile]).
fronteiras(paraguai, [brasil, bolivia, argentina]).
fronteiras(uruguai, [brasil, argentina]).

%% colorir([H|T], LISTA_DE_CORES) :-
