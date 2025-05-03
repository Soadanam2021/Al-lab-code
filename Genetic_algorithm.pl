:- use_module(library(random)).  % For random number generation

% Parameters
population_size(4).             % Small population for example
chromosome_length(6).           % Binary string length
generations(10).                % Number of generations

% Initialize a single chromosome (random binary string)
init_chromosome(Chromosome) :-
    chromosome_length(Len),
    random_permutation([0,1], Bits),  % Generate 0s and 1s
    length(Chromosome, Len),
    fill_chromosome(Chromosome, Bits).

fill_chromosome([], _).
fill_chromosome([H|T], Bits) :-
    random_member(H, Bits),
    fill_chromosome(T, Bits).

% Initialize population
init_population(Pop) :-
    population_size(Size),
    length(Pop, Size),
    maplist(init_chromosome, Pop).

% Fitness function: sum of 1s in chromosome
fitness(Chromosome, Fitness) :-
    sumlist(Chromosome, Fitness).

% Selection: tournament selection
select_parent(Population, Parent) :-
    random_select(C1, Population, Rest),
    random_select(C2, Rest, _),
    fitness(C1, F1),
    fitness(C2, F2),
    (F1 >= F2 -> Parent = C1 ; Parent = C2).

% Crossover: single-point crossover
crossover(P1, P2, Child1, Child2) :-
    chromosome_length(Len),
    random(1, Len, Point),
    length(Prefix1, Point),
    append(Prefix1, Suffix1, P1),
    append(Prefix2, Suffix2, P2),
    append(Prefix1, Suffix2, Child1),
    append(Prefix2, Suffix1, Child2).

% Mutation: flip a random bit
mutate(Chromosome, Mutated) :-
    random(0, 2, DoMutate),  % 50% chance of mutation
    (DoMutate = 1 -> 
        chromosome_length(Len),
        random(0, Len, Pos),
        nth0(Pos, Chromosome, Bit),
        NewBit is 1 - Bit,   % Flip 0 to 1 or 1 to 0
        replace(Chromosome, Pos, NewBit, Mutated)
    ; Mutated = Chromosome).

replace([_|T], 0, X, [X|T]).
replace([H|T], Pos, X, [H|R]) :-
    Pos > 0,
    Pos1 is Pos - 1,
    replace(T, Pos1, X, R).

% Create new generation
new_generation(Pop, NewPop) :-
    population_size(Size),
    length(NewPop, Size),
    generate_population(Pop, Size, NewPop).

generate_population(_, 0, []).
generate_population(Pop, N, [C1|Rest]) :-
    N > 0,
    select_parent(Pop, P1),
    select_parent(Pop, P2),
    crossover(P1, P2, Child1, Child2),
    mutate(Child1, C1),
    N1 is N - 1,
    generate_population(Pop, N1, Rest).

% Main genetic algorithm
genetic_algorithm(Best) :-
    init_population(Pop),
    generations(MaxGen),
    evolve(Pop, 0, MaxGen, Best).

evolve(Pop, Gen, MaxGen, Best) :-
    Gen >= MaxGen,
    evaluate_population(Pop, Scores),
    max_member(BestScore-Chromosome, Scores),
    Best = Chromosome-Fitness,
    Fitness = BestScore.
evolve(Pop, Gen, MaxGen, Best) :-
    Gen < MaxGen,
    new_generation(Pop, NewPop),
    Gen1 is Gen + 1,
    evolve(NewPop, Gen1, MaxGen, Best).

% Evaluate entire population
evaluate_population(Pop, Scores) :-
    maplist(chromosome_score, Pop, Scores).

chromosome_score(Chromosome, Fitness-Chromosome) :-
    fitness(Chromosome, Fitness).

% Run the algorithm
run :-
    genetic_algorithm(Best),
    format('Best solution: ~w with fitness ~w~n', Best).