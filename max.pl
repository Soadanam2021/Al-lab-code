% Base case: if the list has only one element, that element is the maximum.
max_of_list([X], X).

% Recursive case: max of the list is the larger of the head and the max of the tail.
max_of_list([Head|Tail], Max) :-
    max_of_list(Tail, TailMax),
    (   Head > TailMax
    ->  Max = Head
    ;   Max = TailMax
    ).
