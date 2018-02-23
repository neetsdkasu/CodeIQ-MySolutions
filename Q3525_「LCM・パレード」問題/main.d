// Try CodeIQ Q3525
// author: Leonrdone @ NEETSDKASU
import std.stdio     : readf, writeln, stderr;
import std.numeric   : gcd;
import std.algorithm : min;

long solve(long n, long k)
{
    auto ik = cast(int)k;
    auto gcds = new long[ik+1];
    foreach (i; 1..ik+1)
    {
        gcds[i] = gcd(i, k);
    }
    long ret = 0;
    int p = 1;
    foreach (i; 1..n+1)
    {
        ret += i / gcds[p];
        p++;
        if (p > ik)
        {
            p = 1;
        }
    }
    return ret;
}

void main()
{
    long n, k;
    readf("%d %d", &n, &k);
    auto ret = solve(n, k);
    writeln(ret);
}

debug
long bruteforce(long n, long k)
{
    long ret = 0;
    foreach (i; 1..n+1)
    {
        ret += i / gcd(i, k);
    }
    return ret;
}

unittest
{
    struct TC { long n, k, ans; }
    TC[] testcases = [
        { 25, 12, 0 },
        { 9, 12, 22 },
        { 10, 3, 43 },
        { 20, 9, 162 },
    ];
    foreach (i, tc; testcases)
    {
        if (tc.ans == 0)
        {
            tc.ans = bruteforce(tc.n, tc.k);
        }
        stderr.write("i=", i, " n=", tc.n, " k=", tc.k, " ans=", tc.ans);
        auto ret = solve(tc.n, tc.k);
        stderr.writeln(" ret=", ret);
        assert(ret == tc.ans);
    }
}