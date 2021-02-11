# Correção 

## Buscas não-informadas

    1. 10
    2. 7.5  - A modelagem de estado para o problema não está descrevendo a posição do barco/pessoa entre as margens. Sem essa informação não é possível realizar as verificações de limitações impostas (cabra não pode ficar sozinha com lobo nem com a couve).
    3. 7.5  - Não foram definidos os espaços do problema na resposta.
    4. 7.5  - A busca de custo-uniforme não necessariamente vai encontrar de primeira o objetivo com menor custo, já que nesse caso existem arestas com peso negativo. Nesse caso ele encontra mas foi por sorte, deveriam ser testado todos os caminhos para ter certeza.
    5. 10
    6. 5    - Não fez a b).
    7. 5    - b^d será a quantidade de nós presentes somente no último nível da árvore, não nela por inteiro.
    8. 8    - Faltou a busca de custo-uniforme.
    9. 9    - Complexidade de espaço da busca em profundidade é O(b.m).
    Nota: 69.5/90 => 77.2/100 pontos
