// Try CodeIQ
// author: Leonardone @ NEETSDKASU

import std.stdio, std.conv, std.string, std.math;

long f(long n) {
    return 1 + cast(long)floor(n * log10(n)); // 間違っていたので修正
}

long g(long m) {
    long h(long b, long t) {
        if (b > t) return -1;
        auto x = (t + b) / 2;
        auto y = f(x);
        if (y < m) {
            return h(x + 1, t);
        } else if (y > m) {
            return h(b, x - 1);
        } else {
            return x;
        }
    }
    return h(2, pow(10, 10));
}

void main() {
    
    auto m = to!long(strip(readln()));
    auto ans = g(m);
    
    writeln(ans);
    
}