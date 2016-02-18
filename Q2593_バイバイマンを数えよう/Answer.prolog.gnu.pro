f(N,A,B,C,D,E,F,G,H,I,J,K,L):-M is 1000000,(N<100->(K<1->print(L),nl;format("%d%06d~N",[K,L])),(H+J<M->O is G+I,P is H+J;O is G+I+1,P is H+J-M),(B+J<M->Q is A+I,R is B+J;Q is A+I+1,R is B+J-M),(L+B<M->S is K+A,T is L+B;S is K+A+1,T is L+B-M),f(N+1,O,P,Q,R,C,D,E,F,G,H,S,T);halt).
q:-f(0,0,0,0,1,0,0,0,0,0,0,0,1).
:-initialization(q).