% Facts about family members
parent(john, mary).    % John is Mary's parent
parent(john, james).   % John is James's parent
parent(mary, susan).   % Mary is Susan's parent
parent(mary, charlie). % Mary is Charlie's parent
parent(james, lily).   % James is Lily's parent
parent(james, ben).    % James is Ben's parent
parent(susan, olivia). % Susan is Olivia's parent
parent(charlie, adam). % Charlie is Adam's parent

% Sibling relationship: Two people are siblings if they have the same parent
sibling(X, Y) :- parent(P, X), parent(P, Y), X \= Y.

% Grandparent relationship: X is the grandparent of Y if X is a parent of Z and Z is a parent of Y
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

% Great-grandparent relationship: X is the great-grandparent of Y if X is a parent of Z, Z is a parent of W, and W is a parent of Y
great_grandparent(X, Y) :- parent(X, Z), parent(Z, W), parent(W, Y).

% Uncle/Aunt relationship: X is the uncle/aunt of Y if X is a sibling of Y's parent
uncle_aunt(X, Y) :- parent(P, Y), sibling(X, P).

% 1st generation ancestor: X is a 1st generation ancestor of Y if X is a parent of Y
ancestor_1st_gen(X, Y) :- parent(X, Y).

% 2nd generation ancestor: X is a 2nd generation ancestor of Y if X is a parent of Z and Z is a parent of Y
ancestor_2nd_gen(X, Y) :- parent(X, Z), parent(Z, Y).

% 3rd generation ancestor: X is a 3rd generation ancestor of Y if X is a parent of Z, Z is a parent of W, and W is a parent of Y
ancestor_3rd_gen(X, Y) :- parent(X, Z), parent(Z, W), parent(W, Y).

% Example queries:
% 1. Who is a sibling of Susan?
% sibling(X, susan).
% 2. Who is a grandparent of Lily?
% grandparent(X, lily).
% 3. Who is a great-grandparent of Olivia?
% great_grandparent(X, olivia).
% 4. Who is an aunt/uncle of Olivia?
% uncle_aunt(X, olivia).
% 5. Who are the 1st generation ancestors of Adam?
% ancestor_1st_gen(X, adam).
% 6. Who are the 2nd generation ancestors of Olivia?
% ancestor_2nd_gen(X, olivia).
% 7. Who are the 3rd generation ancestors of Lily?
% ancestor_3rd_gen(X, lily).
