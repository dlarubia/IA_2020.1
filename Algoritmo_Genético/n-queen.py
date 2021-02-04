import random
import matplotlib.pyplot

board_size = 32

# Gera uma população => conjunto de cromossomos, tal que cada cromossomo é uma configuração do tabuleiro
def gen_population(size):
    population = []
    for i in range(size):
        chromosome = []
        for j in range(board_size):
            chromosome.append(random.randint(0, board_size-1))
        #chromosome = ''.join(str(e) for e in chromosome) # opcional
        population.append(chromosome)
    return population

# population = gen_population(10)
# print("population = " + str(population))

# Avaliação de tabuleiro - baseado no numero de ataques possíveis na configuração avaliada
def fitness(chromosome):
    attacks = 0
    line_attacks = 0
    diagonal_attaks = 0
    for i in range(len(chromosome)):
        j = i + 1
        diagonal_counter = 0
        while j < len(chromosome):
            diagonal_counter += 1
            if(chromosome[i] == chromosome[j]):
                line_attacks += 1
            if(chromosome[i] == (chromosome[j] - diagonal_counter) or chromosome[i] == (chromosome[j] + diagonal_counter)):
                diagonal_attaks += 1
            j += 1
    return line_attacks + diagonal_attaks

# print(fitness(population[0]))

# Recebe uma população, constrói a roleta e faz a seleção de uma população intermediária
def roulette(population):
    intermediate_population = []
    fitness_values = []
    total_fitness = 0
    for chromosome in population:
        f = fitness(chromosome)
        total_fitness += f
        fitness_values.append(f)

    probabilities = []
    for i in range(len(fitness_values)):
        probabilities.append(fitness_values[i] / total_fitness)


    population_and_probabilities = zip(population, probabilities)
    for i in range(len(population)):
        sorted_value = random.uniform(0, 1)
        # print("valor sorteado: " + str(sorted_value))
        upto = 0
        for chromosome, probability in zip(population, probabilities):
            # print("probabilidade: " + str(probability) + " -- range: " + str(upto + probability))
            if upto + probability >= sorted_value:
                intermediate_population.append(chromosome)
                break
            upto += probability
    
    return intermediate_population

# pop_intermediaria = roulette(population)
# print("População intermediária: " + str(pop_intermediaria))

# roul,total_fitness = roulette(population)
# print(roul)
# print(sum(roul))
# print(total_fitness)


# Realiza o crossover entre os cromossomos X e Y
def crossover(x, y, crossover_rate, cutoff = 0):
    n = len(x)
    c = random.randint(0, n - 1)
    if cutoff != 0:
        c = cutoff

    rand_value = random.random()
    if rand_value < crossover_rate:
        return x[0:c] + y[c:n], y[0:c] + x[c:n]
    else: 
        return x, y


# Realizar a mutação de um determinado indivíduo
def mutate(x, rate):
    n = len(x)
    c = random.randint(0, n - 1)
    rand_value = random.random()
    new_value = random.randint(0, n - 1)
    if rand_value < rate:
        x[c] = new_value
    return x


# Algoritmo genético
def genetic_algorithm(population_size, n_generations, crossover_rate, mutation_rate, elitism):
    # Gera a população
    population = gen_population(population_size)
    n = len(population[0])
    max_fitness = (n * (n - 1)) / 2
    print("População: \n" + str(population))
    
    # Valores do gráfico
    generations = []
    best_fitnesses = []
    average_fitnesses = []

    answers = []

    # Cria a roleta viciada e retorna a população intermediária
    intermediate_population = roulette(population)

    # Realiza os processos para criar uma nova geração de indivíduos
    for generation in range(n_generations):
        print("Geração: " + str(generation))
        generations.append(generation)
        new_generation = []
        i = 0
        while i < len(population):
            # Realiza o crossover entre os individuos da população 
            x, y = crossover(intermediate_population[i], intermediate_population[i + 1], crossover_rate)
            # Realiza a mutação nos indivíduos
            x = mutate(x, mutation_rate)
            y = mutate(y, mutation_rate)
            # Armazena a nova geração
            new_generation.append(x)
            new_generation.append(y)

            i += 2
        sum_fitnesses = 0
        for chromosome in new_generation:
            best_fitness = max_fitness
            f_chromosome = fitness(chromosome)
            sum_fitnesses += f_chromosome
            if f_chromosome < best_fitness:
                best_fitness = f_chromosome
            #print("Fitness cromossomo: " + str(best_fitness))
            if f_chromosome == 0:
                # print("Melhor fitness: " + str(best_fitness))
                print("Resultado encontrado: " + str(chromosome))
                answers.append(chromosome)
                # return new_generation, chromosome
        
        best_fitnesses.append(best_fitness)
        print("Melhor fitness:  " + str(best_fitness) + "  ------  Cromossomo: " + str(chromosome))
        average_fitnesses.append(sum_fitnesses/population_size)
    print("Medias: " + str(average_fitnesses))
    matplotlib.pyplot.plot(generations, best_fitnesses)
    matplotlib.pyplot.show()
    matplotlib.pyplot.plot(generations, average_fitnesses)
    matplotlib.pyplot.show()
    return answers
    
    
answers = genetic_algorithm(10, 10000, 0.01, 0.3, False)
if answers:
    print("# -- Resultado encontrado -- #\n" + "Cromossomos: " + str(answers) + "\n")