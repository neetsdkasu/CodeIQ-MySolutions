// Try CodeIQ Q3392
// author: Leonrdone @ NEETSDKASU
import std.stdio     : readf, writeln, stderr;

auto solve(long n) {
    long minimum = long.max;
    void seek(int p, int b, bool bit, long val) {
        if (bit) {
            long tmp = val;
            for (int i = 0; i < p; i++) {
                tmp <<= 1;
                tmp |= 1;
            }
            if (tmp > n && tmp < minimum) {
                minimum = tmp;
            }
        } else {
            long tmp = val << p;
            if (tmp > n && tmp < minimum) {
                minimum = tmp;
            }
        }
        for (int i = b + 1; i < (p + 1) / 2; i++) {
            if (bit) {
                long tmp = val;
                for (int k = 0; k < i; k++) {
                    tmp <<= 1;
                    tmp |= 1;
                }
                seek(p - i, i, !bit, tmp);
            } else {
                seek(p - i, i, !bit, val << i);
            }
        }
    }
    int bits = 0;
    long tmp = n;
    while (tmp > 0) {
        bits++;
        tmp >>= 1;
    }
    for (int i = 0; ; i++) {
        seek(bits + i, 0, true, 0);
        if (minimum < long.max) {
            return minimum;
        }
    }
}

void main() {
    long n;
    readf("%d", &n);
    auto ans = solve(n);
    writeln(ans);
}

unittest {
    struct TC { long n, ans; }
    TC[] testcases = [{77, 79}, {79, 96}, {57, 63}];
    foreach (i, tc; testcases) {
        auto res = solve(tc.n);
        stderr.writeln(i, ": n=", tc.n, " ans=", tc.ans, " res=", res);
        assert (res == tc.ans);
    }
}