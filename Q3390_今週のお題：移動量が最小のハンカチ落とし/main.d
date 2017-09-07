// Try CodeIQ Q3390
// author: Leonardone @ NEETSDKASU
import std.stdio   : readf, writeln, stderr;
import std.container.binaryheap : BinaryHeap;
import std.container.array : Array;

auto solve(int n) {
    class Foo{
        bool[int] flags;
        bool[] xs;
        int p = 0, c = 1, ret = 0;
        this(int n){ xs = new bool[n]; xs[0] = true; }
    }
    auto hp = BinaryHeap!(Array!Foo, "a.ret > b.ret")();
    hp.insert(new Foo(n));
    for (;;) {
        auto f = hp.front;
        if (f.c == n) {
            return f.ret;
        }
        hp.removeFront;
        for (int i = 1, c = f.c; c < n; i++) {
            if (i in f.flags) { continue; }
            int k = (f.p + i) % n;
            if (f.xs[k]) { continue; }
            auto g = new Foo(n);
            g.flags = f.flags.dup;
            g.xs = f.xs.dup;
            g.flags[i] = true;
            g.xs[k] = true;
            g.c = f.c + 1;
            g.p = k;
            g.ret = f.ret + i;
            hp.insert(g);
            c++;
        }
    }
} 

void main() {
    int n;
    readf("%d", &n);
    auto ans = solve(n);
    writeln(ans);
}

unittest {
    struct TC { int n, ans; }
    TC[] testcases = [{3, 5}, {4, 6}, {7, 23}, {8, 28}, {9, 38}];
    foreach (i, tc; testcases) {
        auto ans = solve(tc.n);
        stderr.writefln("%d: n=%d ans=%d result=%d", i, tc.n, tc.ans, ans);
        assert (ans == tc.ans);
    }
}