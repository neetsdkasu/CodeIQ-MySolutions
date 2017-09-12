// Try CodeIQ Q3394
// author: Leonardone @ NEETSDKASU
import std.stdio      : readf, writeln, stderr;
import std.algorithm  : nextPermutation;
import std.array      : array;
import std.range      : iota;
import std.math       : abs;

auto solve(int n) {
    auto a = iota(0, n-1).array;
    auto ans = 0;
outerloop:
    do {
        if (a[0] == 0 || a[0] == n-2 || a[n-2] == 0 || a[n-2] == n-2) {
            continue;
        }
        for (int i = 1; i < n-1; i++) {
            if (abs(a[i]-a[i-1]) == 1) {
                continue outerloop;
            }
        }
        ans++;
    } while (nextPermutation(a));
    return ans;
}

void main() {
    int n;
    readf("%d", &n);
    auto ans = solve(n);
    writeln(ans);
}

unittest {
    struct TC { int n, ans; }
    TC[] testcases = [
        {4, 0}, {5, 2}, {6, 6},
        {9, 3106}, {10, 29926}];
    foreach (i, tc; testcases) {
        stderr.writef("%d: n=%d ans=%d", i, tc.n, tc.ans);
        auto ret = solve(tc.n);
        stderr.writeln(" ret=", ret);
        assert(ret == tc.ans);
    }
}