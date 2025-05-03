% Simple Prolog program
likes(mary, pizza).
likes(john, burger).

food_lovers(X) :- likes(X, pizza).

% Query: ?- food_lovers(mary). 
