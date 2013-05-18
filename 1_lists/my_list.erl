-module(my_list).
-export(
   [
    last/1, 
    second_last/1, 
    nth/1,
    total_items/1,
    reverse/1,
    palindrom/2
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
palindrom(L1, L2) ->
    L1 =:= reverse(L2).
