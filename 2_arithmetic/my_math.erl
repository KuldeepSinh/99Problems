-module (my_math).
-compile(export_all).

%%=========
%% Problem#1 : Determine whether a given integer number is prime.
is_prime(N) when N < 2 ->
    invalid;
is_prime(2) ->
    true;
is_prime(3) ->
    true;
is_prime(N) when (N rem 2 =:= 0) ->
    false;
is_prime(N) ->
    is_prime(N, 3).
is_prime(N, PF) when (N rem PF =:= 0) ->
    false;
is_prime(N, PF) when (PF * PF) =< N->
    is_prime(N, PF + 2);
is_prime(_, _) ->
    true.

		   


