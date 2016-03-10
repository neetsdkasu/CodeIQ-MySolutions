/* Try CodeIQ */
/* author: Leonardone @ NEETSDKASU */

main :-
	process,
	halt.


f(N, X) :-
	X is 1.0 + float_integer_part(N * log(N) / log(10)).

h(B, T, M) :-
	( B > T -> write(-1);
		X is float_integer_part((B + T) / 2.0),
		f(X, Y),
		( Y < M -> h(X + 1.0, T, M);
		( Y > M -> h(B, X - 1.0, M);
			write_to_codes(C,X), d(1, C)))).

g(M) :-
	h(2.0, 10.0 ** 10, M).

d(I, X) :-
	nth(I, X, C),
	( C > 46 ->
		put_code(C),
		J is I + 1,
		d(J, X)
	; true ).

r(X, D) :-
	get_code(K),
	(K > 10 ->
		Y is (X * 10.0) + float(K - 48),
		r(Y, Z),
		D is Z
	; D is X).

process :-
	r(0.0, M), g(M),
	nl.

:-initialization(main).
