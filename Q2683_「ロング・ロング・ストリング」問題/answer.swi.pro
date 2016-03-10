/* Try CodeIQ */
/* author: Leonardone @ NEETSDKASU */

:- set_prolog_flag(verbose, silent).
:- prompt(_, '').
:- use_module(library(readutil)).

main :-
	process,
	halt.

f(N, X) :-
	X is 1 + floor(N * log10(N)).

h(B, T, M) :-
	( B > T -> writeln(-1);
		X is floor((B + T) / 2),
		f(X, Y),
		( Y < M -> h(X + 1, T, M);
		( Y > M -> h(B, X - 1, M);
			writeln(X)))).

g(M) :-
	h(2, 10 ** 10, M).

process :-
	read_line_to_codes(current_input, Codes),
	number_codes(M, Codes),
	g(M).

:- main.
