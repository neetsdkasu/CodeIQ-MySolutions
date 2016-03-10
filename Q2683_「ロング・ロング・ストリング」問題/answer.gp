\\ Try CodeIQ
\\ author: Leonardone @ NEETSDKASU

f(N) =
{   1+floor(N*log(N)/log(10));
}

h(B,T,M) =
{   my(x,y);

    if(B>T,return(-1));
    x=floor((B+T)/2);
    y=f(x);
    if(y<M,h(x+1,T,M),
    if(y>M,h(B,x-1,M),
        x));
}

g(M) =
{   h(2,10^10,M);
}

ans() = 
{   my(m);
    
    m=input();
    print(g(m));
}

ans();