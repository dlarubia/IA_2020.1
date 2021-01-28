# 1 - Modelagem do indivíduo

# a) Utilizar a mesma representação de tabuleiro usada na tarefa do Hill Climbing
# b) Propor uma representação binária para o tabuleiro

# Exemplo: tabuleiro 4x4 --> [1,1], [0,1], [0,0], [1,0]
# coluna 0 - linha 3, coluna 1 - linha 1, coluna 2 - linha 0, coluna 3 - linha 2

import random

def CreateBoard(N):
    board = []
    binary_size = len("{0:b}".format(N-1))

    binary = []
    for i in range(binary_size):
        binary.append(0)

    for i in range(N):
        board.append(binary)
    print("Binary: " + str(binary))
    print("Clean Board: " + str(board))
    return board


def GenerateRandomBoard(board):
    random_board = board.copy()
    binary_size = len(board[0])
    for i in range(len(board)):
        for j in range(binary_size):
            random_board[i][j] = random.randint(0,2)
    return random_board

# board = CreateBoard(8)
# print("Board: " + str(board))
# random_board = GenerateRandomBoard(board)
# print("Random board: " + str(random_board))