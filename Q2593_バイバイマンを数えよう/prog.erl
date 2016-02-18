-module(prog).
-export([main/0]).
main()->lists:foldr(fun(_,[A,B,C,D,E])->io:format("~w~n",[A+B+C+D+E]),[D+E,A+D,B,E,C]end,[1,0,0,0,0],lists:seq(0,99)).