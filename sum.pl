% Base case: the sum of an empty list is 0.
sum_of_list([], 0).

% Recursive case: sum of a list is the head (first element) + sum of the tail (rest of the list).
sum_of_list([Head|Tail], Sum) :-
    sum_of_list(Tail, TailSum),
    Sum is Head + TailSum.
