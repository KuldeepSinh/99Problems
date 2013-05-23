-module(my_list).
-compile(export_all).

%% =========
%% Problem#1 (Last Item)
last([H|[]]) ->
    H;
last([_|T]) ->
    last(T).

%% =========
%% Problem#2 (Last but one item)
second_last([H1, _|[]]) ->
    H1;
second_last([_|T]) ->
    second_last(T).

%% =========
%% Problem#3 (nth item)
nth([H|_], 1) -> 
    H;
nth([_|T], N) -> 
    nth(T, N -1).

%% =========
%% Problem#4 (Total items)
list_length([]) ->
    0;
list_length([_| T]) ->
    1 + list_length(T).

%% Not in the Problem list, but helpful function.
remove_nth(L, N) ->
    remove_nth([], L, N).
% Find Nth element one by one.
remove_nth(L1, [H|T], N) when N > 1 ->
    remove_nth([H] ++ L1, T, N - 1); 
% When Nth element is reached, remove it/don't include it.
remove_nth(L1, [_|T], 1) ->
    reverse(L1) ++ T.


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
compress([H|T1], [H|T2]) ->
    compress([H | T1], T2);

% In rest of the cases, 
%    when the first elements of both lists are NOT equal,
% Add first element of the input list at the beginning of the resultant list, and recurse.
compress(L, [H2|T2]) ->
    compress([H2] ++ L, T2).
    
%% =========
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
pack([[H|T1]| T], [H|T2]) ->
    pack([[H] ++ [H|T1] | T], T2);

% In rest of the cases,
%   make a sub-list of the head element of the input list 
%   and add this newly created sub-list at the beginning of the resultant list.
pack(L, [H2|T2]) ->
    pack([[H2]] ++ L, T2).

%% =========
%% Problem#10 (Run-length encoding of a list.)
encode(L) ->
    encode([], L).
encode(L, []) ->
    reverse(L);
encode([[Count, H]| T1], [H|T2]) ->
    encode([[Count + 1, H] | T1], T2);
encode(L, [H2|T2]) ->
    encode([[1, H2]| L], T2).

%% =========
%% Problem#13 (Modified run-length encoding.)
%% Outcome of both Problem#11 and Problem#13 is same, 
%%   so Problem#11 is not solved.
encode_modified(L) ->
    encode_modified([], encode(L)).
% L is the resultant list, reverse it.
encode_modified(L, []) ->
    reverse(L);
% If Count =:= 1, remove it from the encoded list, keep only Element.
encode_modified(L, [[1, Element]| T]) ->
    encode_modified([Element] ++ L, T);
% Else keep [Count, Element]
encode_modified(L, [H|T]) ->
    encode_modified([H] ++ L, T).

%% =========
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

%% =========
%% Problem#14 (Clone each element of the list 2 times.)
%% Problem#15 (Clone each element of the list N times.)
clone_element(L, N) ->
    clone_element([], L , N).
clone_element(L, [], _) ->
    reverse(L);
clone_element(L, [H|T], N) ->
    clone_element(expand(L, [N, H]), T, N).

%% =========
%% Problem#16 (Drop every Nth element from the list)
drop_every_nth(L, N) ->
    drop_every_nth([], L, N, N).
drop_every_nth(L, [], _, _)  ->
    reverse(L);
drop_every_nth(L, [H|T], N, M) when M > 1 ->
    drop_every_nth([H] ++ L, T, N, M-1);
drop_every_nth(L, [_|T], N, 1) ->
    drop_every_nth(L, T, N, N).

%% =========    
%% Problem#17 (Split list after the Nth element)
split(L, N) ->
    split([], L, N).
split(L, [H|T], N) when N > 0 ->
    split([H] ++ L, T, N - 1);
split(L1, L2, 0) ->
    {reverse(L1), L2}.

%% =========
%% Problem#18 (Slice list between positions)
slice(L, From, To) ->
    slice([], L, From, To).
slice(L, _, 1, 0) ->
    reverse(L);
slice(L, [_|T], From, To) when From > 1 ->
    slice(L, T, From - 1, To -1);
slice(L, [H|T], 1, To) when To > 0 ->
    slice([H] ++ L, T, 1, To -1).

%% =========
%% Problem#19 (Rotate List)
rotate(L, N) when N > 0 ->
    rotate([], L, N, positive);
rotate(L, N) when N < 0 ->
    rotate([], L, N, negative);
rotate(L, _) ->
    L.

rotate(L, [H|T], N, positive)  when N > 0 ->
    rotate([H] ++ L, T, N-1, positive);
rotate(L1, L2, N, negative) when N < 0 ->
    rotate(L1, reverse(L2), abs(N), negative);
rotate(L, [H|T], N, negative) when N > 0 ->
    rotate([H] ++ L, T, N-1, negative);
rotate(L1, L2, 0, positive) ->
    L2 ++ reverse(L1);
rotate(L1, L2, 0, negative) ->
    L1 ++ reverse(L2).

%% =========
%% Problem#20 (Drop Nth element from the list)
drop_nth(L, N) ->
    drop_nth([], L, N).
drop_nth(L, [H|T], N) when N > 1 ->
    drop_nth([H] ++ L, T, N-1);
drop_nth(L, [_|T], 1) ->
    reverse(L) ++ T.

%% =========
%% Problem#21 (Insert element at Nth position)
insert(L, Element, N) ->
    insert([], L, Element, N).
insert(L, [H|T], Element, N) when N > 1 ->
    insert([H] ++ L, T, Element, N -1);
insert(L1, L2, Element, 1) ->
    reverse([Element] ++ L1) ++ L2.

%% =========
%% Problem#22 (Create a list between range of integers (From-To))
create_range(From, To) ->
    create_range([], From, To).
create_range(L, From, To) when From =< To ->
    create_range([From] ++ L, From + 1, To);
create_range(L, From, To) when From > To ->
    reverse(L).

%% =========
%% Problem#23 (Extract a given number of randomly selected elements from a list.)
create_random_sublist(L, Count) ->
    create_random_sublist([], L, list_length(L), Count).
create_random_sublist(L1, L2, Total, Count) when Count > 0 ->
    create_random_sublist([nth(L2, random:uniform(Total))] ++  L1, L2, Total, Count - 1);
create_random_sublist(L1, _, _, 0)  ->
    L1.

%% =========
%% Problem#24 (Lotto: Draw N different random numbers from the set 1..M.)
draw_random_list(Count, Max) ->
    draw_random_list([], Count, Max).
draw_random_list(L, Count, Max) when Count > 0 ->
    draw_random_list([random:uniform(Max)] ++ L, Count - 1, Max);
draw_random_list(L, 0, _) ->
    L.

%% =========
%% Problem#25 (Generate a random permutation of the elements of a list.)
random_permute(L) ->
    random_permute([], L).
random_permute(L1, []) ->
    L1;
random_permute(L1, L2) -> 
    %Find length (list_length) of the list,
    %   based on that generate a random (nth) position.
    N = random:uniform(list_length(L2)),
    %Select the nth element from the list, to construct a new (resultant) list.
    %Remove nth element from the input list. 
    random_permute([nth(L2, N)] ++ L1, remove_nth(L2, N)).

%% =========
%% Problem#26 (Generate the combinations of K distinct objects chosen from the N elements of a list.)
combination([{CL, RL} | T], N) when N > 0 -> 
    combination(create_comb([{CL, RL}|T], []), N-1);
combination(L, 0) ->
    extract(L);
combination(L, N) ->
    combination([{[], L}], N).

create_comb([], L2) ->
    L2;
create_comb([{ComLst, RmnLst} | T], L2) ->
    create_comb(T, create_comb({ComLst, RmnLst}) ++ L2).
% Create list form individual item.
create_comb({ComLst, RmnLst}) ->
    create_comb({ComLst, RmnLst}, [], list_length(RmnLst)).
create_comb({ComLst, RmnLst}, L2, N) when N > 0 ->  
    CL = [nth(RmnLst, N)] ++ ComLst,
    RL = remove_nth(RmnLst, N),    
    create_comb({ComLst, RmnLst}, [{CL, RL}] ++ L2, N-1);
create_comb(L1, [], _) ->
    L1;
create_comb(_L1, L2, 0) ->
    L2.

% Extract required list.
extract(L) ->
    extract(L, []).
extract([], L) ->
    L;
extract([{CL, _}|T], L) ->
    extract(T, [CL] ++ L).
    
