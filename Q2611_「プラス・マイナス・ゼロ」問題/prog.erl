% Try CodeIQ
% author: Leonardone @ NEETSDKASU
-module(prog).
-export([main/0]).

solve(N,H) when N == 0 ->
    case dict:find(0, H) of
        {ok, X} -> X;
        _Else -> 0
    end;
solve(N,H) ->
    solve(
        N - 1,
        dict:fold(
            fun (K,V,A) ->
                F = fun (OldVal) -> OldVal + V end,
                dict:update(K - N, F, V, dict:update(K + N, F, V, A) )
            end,
            dict:new(),
            H)
        ).

main() ->
    {N, _} = string:to_integer(io:get_line("")),
    Ans = solve(N, dict:from_list([{0, 1}])),
    io:format("~w~n", [Ans]).
