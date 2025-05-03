% Base case: the length of an empty list is 0.
length_of_list([], 0).

% Recursive case: length of the list is 1 + length of the tail (rest of the list).
length_of_list([_|Tail], Length) :-
    length_of_list(Tail, TailLength),
    Length is TailLength + 1.
