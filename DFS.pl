% Define the graph edges (facts)
edge(a, b).
edge(a, c).
edge(b, d).
edge(b, e).
edge(c, f).
edge(d, g).
edge(e, h).

% Base case: if start and goal are the same, path is just that node
dfs(Start, Start, [Start]).

% Recursive case: find a path from Start to Goal
dfs(Start, Goal, [Start|Path]) :-
    edge(Start, Next),           % There exists an edge from Start to Next
    dfs(Next, Goal, Path).       % Recursively find path from Next to Goal

% Helper predicate to avoid cycles using a visited list
dfs_visited(Start, Goal, Visited, Path) :-
    dfs_helper(Start, Goal, [Start|Visited], Path).

% Base case with visited list
dfs_helper(Start, Start, _, [Start]).

% Recursive case with visited list
dfs_helper(Start, Goal, Visited, [Start|Path]) :-
    edge(Start, Next),
    \+ member(Next, Visited),    % Check if Next hasn't been visited
    dfs_helper(Next, Goal, [Next|Visited], Path).

% Query examples:
% ?- dfs(a, g, Path).           % Simple DFS
% ?- dfs_visited(a, g, [], Path). % DFS with cycle prevention