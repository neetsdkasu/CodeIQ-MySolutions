f(N,A,B,C,D,E,R):-(N<100->writeln(R),plus(D,E,X),plus(A,E,Y),plus(R,A,Z),f(N+1,X,Y,B,C,D,Z)).
:-f(0,0,1,0,0,0,1).