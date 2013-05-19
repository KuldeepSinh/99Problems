-module(my_list).
-export(
   [
    last/1, 
    second_last/1, 
    nth/1,
    total_items/1,
    reverse/1,
    palindrom/1,
    flatten/1,
    compress/1
   ]
  ).

%% =========
%% Problem#1 (Last Item)
last([H|T]) when T =:= []->
    H;
last([_|T]) ->
    last(T).

%% =========
%% Problem#2 (Last but one item)
second_last([H1, _|T]) when T =:= []->
    H1;
second_last([_|T]) ->
    second_last(T).

%% =========
%% Problem#3 (nth item)
nth({1, [H|_]}) -> 
    H;
nth({N, [_|T]}) -> 
    nth({N-1, T}).

%% =========
%% Problem#4 (Total items)
total_items([]) ->
    0;
total_items([_| T]) ->
    1 + total_items(T).

%% =========
%% Problem#5 (Reverse list)
reverse([]) ->
    [];
reverse([H|T]) ->
    reverse(T) ++ [H].

%% =========
%% Problem#6 (Check if list is palindrom)
palindrom(L1) ->
    L1 =:= reverse(L1).

%% =========
%% Problem#7 (Flatten the list)
flatten([]) ->
    [];

% It is possible that H is a list, 
% if such is a case this pattern will match in reccursion 
% else next pattern will match.
flatten([H|T]) -> 
    flatten(H) ++ flatten(T);

% If both of above patterns did not match,
% H is a single element (NOT a list) and
% following pattern will match.
flatten(H) ->
    [H].

%% =========
%% Problem#8 (Compress List, remove repeating adjscent elements)
compress([]) ->
    [];
compress(L) ->
    compress([], L).

% L will be the ultimate compressed list.
% Reverse of L is required to preserve the order of elements,
% because L will be created by adding elements to its head,
% it's a recomanded practice for Erlang list processing.
compress(L, []) ->
    reverse(L);
% When resultant list is empty, 
% add first element of the input list to it, and recurse.
compress([], [H2|T2]) ->
    compress([H2], T2);

% When the first element of the resultant list and 
%    the first element of the input list are equal,
% Discard it from the list and recurse.
compress([H1|T1], [H2|T2]) when H1 =:= H2 ->
    compress([H1 | T1], T2);

% In rest of the cases, 
%    when the first element of the input list are NOT equal,
% Add first element of the input list at the beginning of the resultant list,
% and recurse.
compress([H1|T1], [H2|T2]) ->
    compress([H2] ++ [H1|T1], T2).
    

