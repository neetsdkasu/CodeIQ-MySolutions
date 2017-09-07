// Try CodeIQ Q3284
// author: Leonardone @ NEETSDKASU
import std.stdio  : readln, writeln, stderr;
import std.string : chomp;
import std.array  : split;
import std.conv   : to;

long bruteforce(long n, long p) {
    long ans = 1;
    for (long i = 1; i <= n; i++) {
        auto x = i;
        while (x % p == 0) {
            x /= p;
        }
        ans = (ans * x) % p;
    }
    return ans;
}

long solve(long n, long p) {
    auto rms = new long[cast(uint)p];
    rms[0] = 1;
    for (int i = 1; i < p; i++) {
        rms[i] = (rms[i - 1] * i) % p;
    }
    long ans = 1, x = n, e = 0;
    while (x >= p) {
        auto d = x / p;
        auto m = x % p;
        ans = (ans * rms[cast(uint)m]) % p;
        e = (e + d) % (p - 1);
        x = d;
    }
    ans = (ans * rms[cast(uint)x]) % p;
    for (long i = 0; i < e; i++) {
        ans = (ans * rms[$-1]) % p;
    }
    return ans;
}

void main() {
    auto xs = readln.chomp.split.to!(long[]);
    auto n = xs[0], p = xs[1];
    auto ans = solve(n, p);
    writeln(ans);
}

unittest {
    struct TC { long n, p, ans; }
    TC[] tcs = [
        {12, 5, 4},
        {5, 3, 1},
        {20, 7, 5},
        {1000, 31, 11}
    ];
    foreach (tc; tcs) {
        stderr.writeln(tc);
        auto ans = solve(tc.n, tc.p);
        assert(ans == tc.ans);
    }
}