% Bitwise OR operation
dobitwise_or(A, B, Result) :-
    Result is A / B.

% Bitwise XOR operation
dobitwise_xor(A, B, Result) :-
    Result is A xor B.

% Left shift operation
doleft_shift(A, N, Result) :-
    Result is A << N.

% Right shift operation
doright_shift(A, N, Result) :-
    Result is A >> N.

% Bitwise Complement operation
dobitwise_complement(A, Result) :-
    Result is \A.

% Finding root of an equation (quadratic: ax^2 + bx + c = 0)
quadratic_roots(A, B, C, Root1, Root2) :-
    D is B*B - 4*A*C,
    D >= 0,
    SqrtD is sqrt(D),
    Root1 is (-B + SqrtD) / (2 * A),
    Root2 is (-B - SqrtD) / (2 * A).

% GCD operation
gcd(X, 0, X) :- !.
gcd(X, Y, GCD) :-
    R is X mod Y,
    gcd(Y, R, GCD).
