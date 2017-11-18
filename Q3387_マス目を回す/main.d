// Try CodeIQ Q3387
// author: Leonardone @ NEETSDKASU
import std.stdio     : readln, writeln, stderr;
import std.array     : split, join, appender;
import std.string    : chomp;
import std.typecons  : tuple, Tuple;
import std.algorithm : swap;

class Problem {
    char[6][6] field;
    string     query;
    this(string s) {
        auto xs = s.chomp.split(" ");
        foreach (i, ys; xs[0].split("/")) {
            foreach (j, ch; ys) {
                if (ch == '-') { continue; }
                field[i+1][j+1] = ch;
            }
        }
        query = xs[1];
    }
    auto getAnswer() {
        auto ans = appender!(string[])();
        foreach (xs; field[1..5]) {
            auto s = appender!string();
            foreach (ch; xs[1..5]) {
                s.put(ch == ch.init ? '-' : ch);
            }
            ans.put(s.data);
        }
        return ans.data.join("/");
    }
    auto search(char target) {
        foreach (i, xs; field) {
            foreach (j, ch; xs) {
                if (ch != target) { continue; }
                return tuple!("i", "j")(i, j);
            }
        }
        throw new Exception("invalid target");
    }
    void rotate(char target) {
        alias XY = Tuple!(int, "x", int, "y");
        auto dxy = [[-1, -1], [0, -1], [1, -1], [1, 0],
                    [1, 1], [0, 1], [-1, 1], [-1, 0]];
        auto ap = appender!(XY[])();
        auto pos = search(target);
        foreach (d; dxy) {
            auto xy = XY(pos.j+d[0], pos.i+d[1]);
            auto ch = field[xy.y][xy.x];
            if (ch != ch.init) {
                ap.put(xy);
            }
        }
        auto xs = ap.data[0..$];
        debug stderr.writeln(xs);
        for (int i = xs.length - 1; i > 0; i--) {
            auto a = xs[i], b = xs[i-1];
            swap(field[a.y][a.x], field[b.y][b.x]);
        }
    }
}

auto solve(string s) {
    auto p = new Problem(s);
    foreach (q; p.query) {
        p.rotate(q);
    }
    return p.getAnswer();
}

void main() {
    auto ans = solve(readln());
    writeln(ans);
}

unittest {
    auto test = "abc-/d-ef/g-hi/opqr codeiq";
    auto answer = "pac-/o-dh/e-qf/grbi";
    stderr.writeln(test);
    stderr.writeln(answer);
    auto result = solve(test);
    stderr.writeln(result);
    assert(result == answer);
}

unittest {
    auto test = "na-c/d-be/t---/g-hi nabetani";
    auto answer = "ab-t/c-en/d---/g-hi";
    stderr.writeln(test);
    stderr.writeln(answer);
    auto result = solve(test);
    stderr.writeln(result);
    assert(result == answer);
}

unittest {
    auto test = "ab--/----/----/---c abcabc";
    auto answer = "ab--/----/----/---c";
    stderr.writeln(test);
    stderr.writeln(answer);
    auto result = solve(test);
    stderr.writeln(result);
    assert(result == answer);
}