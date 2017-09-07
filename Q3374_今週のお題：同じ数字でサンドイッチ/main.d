// Try CodeIQ Q3374
// author: Leonardone @ NEETSDKASu
import std.stdio, std.string, std.conv, std.array, std.algorithm;

int solve(int n) {
    auto temp1 = appender!(int[][])();
    temp1.put(new int[n * 2 + 1]);
    for (int i = 1; i <=n; i++) {
        auto temp2 = appender!(int[][])();
        foreach (arr; temp1.data) {
            for (int j = 0; j + i + 1 < arr.length; j++) {
                if (arr[j] == 0 && arr[j + i + 1] == 0) {
                    auto dup = arr.dup;
                    dup[j] = i;
                    dup[j + i + 1] = i;
                    temp2.put(dup);
                }
            }
        }
        temp1 = temp2;
    }
    int ans = 0;
    foreach (arr; temp1.data) {
        foreach (i, v; arr) {
            if (v == 0) {
                ans = max(ans, i + 1);
                break;
            }
        }
    }
    return ans;
}

void main() {
    int n = to!int(readln().strip());
    int ans = solve(n);
    writeln(ans);
}