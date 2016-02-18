#include<stdio.h>
typedef long long L;void f(L a,L b,L c,L d,L e,L n){if(n){printf("%lld\n",a+b+c+d+e);f(d+e,a+d,b,e,c,n-1);}}int main(){f(1,0,0,0,0,100);return 0;}