// Try CodeIQ Q3397
// author: Leonardone @ NEETSDKASU
import std.stdio      : readf, writeln, stderr;

auto solve(long n) {
    long ans = 0;
    long car = 0;
    long dfs(long c, long b) {
        if (c >= n) {
            return c;
        }
        long x = c * 10 + b;
        long y = dfs(x, b * 10);
        long diff = c + car * b;
        for (long i = 9; i > 3; i--) {
            y -= diff;
            if (y < n) {
                ans = ans * 10 + i;
                return y + diff;
            }
        }
        y -= diff + b;
        if (y < n) {
            ans = ans * 10 + 3;
            car++;
            return y + diff + b;
        }
        for (long i = 2; i > 0; i--) {
            y -= diff;
            if (y < n) {
                ans = ans * 10 + i;
                return y + diff;
            }
        }
        ans = ans * 10;
        return y;
    }
    long ret = dfs(0, 1);
    return ans;
}

void main() {
    long n;
    readf("%d", &n);
    auto ans = solve(n);
    writeln(ans);
}

unittest {
    struct TC { long n, ans; }
    TC[] testcases = [
        {3, 23}, {7, 33}, {8, 33},
        {10, 35}, {1000, 3081}
    ];
    foreach (i, tc; testcases) {
        stderr.write(i, ": n=", tc.n, " ans=", tc.ans);
        auto ret = solve(tc.n);
        stderr.writeln(" ret=", ret);
        assert(ret == tc.ans);
    }
}