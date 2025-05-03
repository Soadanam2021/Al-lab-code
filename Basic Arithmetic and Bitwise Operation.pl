add(X, Y, Result) :-
    Result is X + Y.

subtract(X, Y, Result) :-
    Result is X - Y.

multiply(X, Y, Result) :-
    Result is X * Y.

divide(X, Y, Result) :-
    Y \= 0, 
    Result is X / Y.

divide(_, 0, 'undefined'). 

remainder(X, Y, Result) :-
    Y \= 0,  
    Result is X mod Y.

remainder(_, 0, 'undefined').  

bitwise_and(X, Y, Result) :-
    Result is X /\ Y.

power(X, Y, Result) :-
    Result is X ** Y.

% ------------------------------------------------
% Example Queries:
% ------------------------------------------------
% ?- add(5, 3, X).
% ?- subtract(10, 4, X).
% ?- multiply(6, 7, X).
% ?- divide(9, 3, X).
% ?- remainder(10, 3, X).
% ?- bitwise_and(5, 3, X).
% ?- power(2, 3, X).
