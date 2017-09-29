// Try CodeIQ Q3404
// author: Leonrdone @ NEETSDKASU
import std.stdio     : readf, writeln, stderr;
import std.numeric   : gcd;

auto solve(int n) {
    auto dp = new int[n+10];
    for (int i = 1; i < n; i++) {
        int j = 1, k = i;
        while (j <= k) {
            int p = j + k;
            int x = dp[j] + dp[k] + p / gcd(j, k);
            if (dp[p] == 0 || x < dp[p]) {
                dp[p] = x;
            }
            j++;
            k--;
        }
    }
    return dp[n];
}

void main() {
    int n;
    readf("%d", &n);
    auto ans = solve(n);
    writeln(ans);
}

unittest {
    struct TC { int n, ans; }
    TC[] testcases = [{4, 6}, {5, 11}];
    foreach (i, tc; testcases) {
        stderr.write(i, ": n=", tc.n, " ans=", tc.ans);
        auto ret = solve(tc.n);
        stderr.writeln(" ret=", ret);
        assert(ret == tc.ans);
    }
}