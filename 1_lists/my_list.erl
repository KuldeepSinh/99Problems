-module(my_list).
-export(
   [
    last/1, 
    second_last/1, 
    nth/1,
    total_items/1,
    reverse/1,
    palindrom/1,
    flatten/1
   ]
  ).

%% Problem#1 (Last Item)
last([H|T]) when T =:= []->
    H;
last([_|T]) ->
    last(T).

%% Problem#2 (Last but one item)
second_last([H1, _|T]) when T =:= []->
    H1;
second_last([_|T]) ->
    second_last(T).

%% Problem#3 (nth item)
nth({1, [H|_]}) -> 
    H;
nth({N, [_|T]}) -> 
    nth({N-1, T}).

%% Problem#4 (Total items)
total_items([]) ->
    0;
total_items([_| T]) ->
    1 + total_items(T).

%% Problem#5 (Reverse list)
reverse([]) ->
    [];
reverse([H|T]) ->
    reverse(T) ++ [H].

%% Problem#6 (Check if list is palindrom)
palindrom(L1) ->
    L1 =:= reverse(L1).

%% Problem#7 (Flatten the list)
flatten([]) ->
    [];

flatten([H|T]) -> 
%% It is possible that H is a list, 
%% if such is a case this pattern will match in reccursion 
%% else next pattern will match.
    flatten(H) ++ flatten(T);

%% If both of above patterns did not match,
%% H is a single element (NOT a list) and
%% following pattern will match.
flatten(H) ->
    [H].

