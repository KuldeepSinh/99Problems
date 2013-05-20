-module(my_list).
-export(
   [
    last/1, second_last/1, nth/1, total_items/1,
    reverse/1, palindrom/1,
    flatten/1, compress/1, pack/1, encode/1, encode_modified/1, decode/1,
    clone_element/2, drop_element/2,
    split_list/2
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

% If H is a list (NOT a single element), 
%    same pattern will be called in the next recursive call.
% Else next pattern will be matched in the next recursive call.
flatten([H|T]) -> 
    flatten(H) ++ flatten(T);

% If both of above patterns do not match,
%    H is a single element (NOT a list)
%    list of H will be returned, so that it can be added in frot of flatten Tail (T).
flatten(H) ->
    [H].

%% =========
%% Problem#8 (Compress List, remove repeating adjscent elements)
compress(L) ->
    compress([], L).

% L will be the ultimate compressed list.
% Reverse of L is required to preserve the order of elements,
%    because L will be created by adding elements to its head,
%    it's a recomanded practice for Erlang list processing.
compress(L, []) ->
    reverse(L);

% When the first element of the resultant list and 
%    the first element of the input list are equal,
% Discard it from the list and recurse.
compress([H1|T1], [H2|T2]) when H1 =:= H2 ->
    compress([H1 | T1], T2);

% In rest of the cases, 
%    when the first elements of both lists are NOT equal,
% Add first element of the input list at the beginning of the resultant list, and recurse.
compress(L, [H2|T2]) ->
    compress([H2] ++ L, T2).
    

%% Problem#9 (Pack consecutive duplicates of list elements into sublists.)
pack(L) ->
    pack([], L).

% L will be the resultant packed list in the reversed order,
%   so reverse it before returning.
pack(L, []) ->
    reverse(L);

% Since the resultant list will be the list of sub-lists,
%    its head will be a sub list.
% In this pattern matching, we are checking  
%   if the head of the input list can be merged into the head sub-list of the resultant list.
%   if yes, then add head of the input list into the head sub-list of the resultant list.
pack([[H1|T1]| T], [H2|T2]) when H1 =:= H2 ->
    pack([[H2] ++ [H1|T1] | T], T2);

% In rest of the cases,
%   make a sub-list of the head element of the input list 
%   and add this newly created sub-list at the beginning of the resultant list.
pack(L, [H2|T2]) ->
    pack([[H2]] ++ L, T2).

%% Problem#10 (Run-length encoding of a list.)
encode(L) ->
    encode([], L).
encode(L, []) ->
    reverse(L);
encode([[Count, Element]| T], [H2|T2]) when Element =:= H2 ->
    encode([[Count + 1, Element] | T], T2);
encode(L, [H2|T2]) ->
    encode([[1, H2]| L], T2).

%% Problem#13 (Modified run-length encoding.)
%% Outcome of both Problem#11 and Problem#13 is same, 
%%   so Problem#11 is not solved.
encode_modified(L) ->
    encode_modified([], encode(L)).
% L is the resultant list, reverse it.
encode_modified(L, []) ->
    reverse(L);
% If Count =:= 1, remove it from the encoded list, keep only Element.
encode_modified(L, [[Count, Element]| T]) when Count =:= 1 ->
    encode_modified([Element] ++ L, T);
% Else keep [Count, Element]
encode_modified(L, [H|T]) ->
    encode_modified([H] ++ L, T).


%% Problem#12 (decode list)
decode(L) ->
    decode([], L).

decode(L, []) ->
    reverse(L);
decode(L, [[Count| Element] | T]) ->
    decode(expand(L, [Count | Element]),T);    
decode(L, [H|T]) ->
    decode([H] ++ L, T).

% Expand sub-list while uncopressing.
expand(L, [Count, Element]) when Count > 0 ->
    expand([Element] ++ L, [Count - 1, Element]);
expand(L, _) ->
    L.

%% Problem#14 (Clone each element of the list 2 times.)
%% Problem#15 (Clone each element of the list N times.)
clone_element(L, N) ->
    clone_element([], L , N).
clone_element(L, [], _) ->
    reverse(L);
clone_element(L, [H|T], N) ->
    clone_element(expand(L, [N, H]), T, N).

%% Problem#16 (Drop Nth element from the list)
drop_element(L, N) ->
    drop_element([], L, N).
drop_element(L, [H|T], N) when N > 1 ->
    drop_element([H] ++ L, T, N-1);
drop_element(L, [_|T], 1) ->
    reverse(L) ++ T.
    
%% Problem#17 (Split list after the Nth element)
split_list(L, N) ->
    split_list([], L, N).
split_list(L, [H|T], N) when N > 0 ->
    split_list([H] ++ L, T, N - 1);
split_list(L1, L2, 0) ->
    {reverse(L1), L2}.
