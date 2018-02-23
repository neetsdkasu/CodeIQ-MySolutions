// Try CodeIQ Q3548
// author: Leonrdone @ NEETSDKASU
import std.stdio     : readf, writeln, stderr;

auto solve(int n)
{
    long[201][201] dp;
    
    foreach (i; 1 .. n + 1)
    {
        dp[i][i] = 1;
        foreach (j; 0 .. i)
        {
            foreach (t, c; dp[j])
            {
                if (t + i > n)
                {
                    break;
                }
                dp[i][t + i] += c * cast(long)(i - j);
            }
        }
    }
    
    long ret = 0;
    foreach (w; dp)
    {
        ret += w[n];
    }
    
    return ret;
}


void main()
{
    int n;
    readf("%d", &n);
    auto ret = solve(n);
    writeln(ret);
}

unittest
{
    struct TC { int n, ans; }
    TC[] testcases = [{ 6, 8 }];
    foreach (i, tc; testcases)
    {
        stderr.write(i, ": n=", tc.n, " ans=", tc.ans);
        auto ret = solve(tc.n);
        stderr.writeln(" ret=", ret);
        assert(ret == tc.ans);
    }
}