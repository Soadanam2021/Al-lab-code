% Entry point to solve N-Queens problem
n_queens(N, Solution) :-
    length(Initial, N),                  % Create a list of length N
    random_permutation(1, N, Initial),  % Randomly place queens (one per row)
    hill_climbing(Initial, Solution, N, 1000), % Apply hill climbing with max 1000 steps
    conflicts(Solution, 0).             % Ensure the solution has zero conflicts

% Generate a random permutation of numbers from 1 to N
random_permutation(Min, Max, Perm) :-
    findall(X, between(Min, Max, X), List),
    random_permute(List, Perm).

random_permute([], []).
random_permute(List, [X|Rest]) :-
    random_select(X, List, Remaining),
    random_permute(Remaining, Rest).

% Hill climbing search with step limit
hill_climbing(State, FinalState, N, MaxSteps) :-
    conflicts(State, Conflicts),
    (Conflicts = 0 -> FinalState = State ;  % If no conflicts, found a solution
     MaxSteps > 0 ->                        % Check step limit
        find_best_neighbor(State, BestNeighbor, N, Conflicts),
        NewSteps is MaxSteps - 1,
        hill_climbing(BestNeighbor, FinalState, N, NewSteps) ;
     random_permutation(1, N, NewState),    % Random restart if step limit reached
     hill_climbing(NewState, FinalState, N, MaxSteps)).

% Find the best neighbor by trying all possible moves
find_best_neighbor(State, BestNeighbor, N, CurrentConflicts) :-
    findall((NewState, Conflicts),
            (neighbor(State, NewState, N), conflicts(NewState, Conflicts)),
            Neighbors),
    sort(2, @=<, Neighbors, SortedNeighbors), % Sort by number of conflicts
    select_better_neighbor(SortedNeighbors, CurrentConflicts, BestNeighbor-Conflicts),
    !.

% If no better neighbor, select a random neighbor to escape local optima
find_best_neighbor(State, NewState, N, _) :-
    findall(NewState, neighbor(State, NewState, N), Neighbors),
    random_member(NewState, Neighbors).

% Select the best neighbor with fewer or equal conflicts
select_better_neighbor([BestNeighbor-Conflicts|_], CurrentConflicts, BestNeighbor-Conflicts) :-
    Conflicts =< CurrentConflicts.

% Generate a neighbor by moving one queen to a different column in its row
neighbor(State, NewState, N) :-
    select(Queen, State, Rest),               % Pick a queen
    length(Rest, Row),                        % Row is the index of the queen
    Row1 is Row + 1,
    between(1, N, NewCol),                    % Try a new column
    NewCol \= Queen,                          % Ensure it's a different column
    append(Before, [Queen|After], State),     % Split the state
    append(Before, [NewCol|After], NewState). % Replace with new column

% Calculate the number of conflicts (attacking pairs of queens)
conflicts(State, Conflicts) :-
    conflicts_acc(State, 1, 0, Conflicts).

conflicts_acc([], _, Acc, Acc).
conflicts_acc([Q|Queens], Row, Acc, Conflicts) :-
    NextRow is Row + 1,
    conflicts_with(Q, Row, Queens, 1, QConflicts),
    NewAcc is Acc + QConflicts,
    conflicts_acc(Queens, NextRow, NewAcc, Conflicts).

% Count conflicts for a queen with all subsequent queens
conflicts_with(_, _, [], _, 0).
conflicts_with(Q1, Row1, [Q2|Queens], Offset, Conflicts) :-
    NextOffset is Offset + 1,
    conflicts_with(Q1, Row1, Queens, NextOffset, RestConflicts),
    (Q1 = Q2 -> C1 = 1 ; C1 = 0),                  % Column conflict
    Diag1 is Q1 - Row1, Diag2 is Q2 - (Row1 + Offset),
    (Diag1 = Diag2 -> C2 = 1 ; C2 = 0),            % Diagonal conflict (/)
    Diag3 is Q1 + Row1, Diag4 is Q2 + (Row1 + Offset),
    (Diag3 = Diag4 -> C3 = 1 ; C3 = 0),            % Diagonal conflict (\)
    Conflicts is C1 + C2 + C3 + RestConflicts.

% Example query to solve for N=4
:- n_queens(4, Solution), write('Solution: '), write(Solution), nl.