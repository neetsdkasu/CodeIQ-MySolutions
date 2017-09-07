// Try CodeIQ Q3380
// author: Leonardone @ NEETSDKASU
import std.stdio, std.conv, std.string, std.array, std.algorithm;

string to_s(int[] a, int[] b, int[] c) {
    return a.text() ~ b.text() ~ c.text();
}

int solve(int m, int n) {
    int[][][string] temp1;
    bool[string] allarr;
    auto first = new int[][3];
    first[0] = new int[m];
    for (int i = 0; i < m; i++) {
        first[0][i] = i;
    }
    first[1] = new int[0];
    first[2] = new int[0];
    auto key = to_s(first[0], first[1], first[2]);
    temp1[key] = first;
    allarr[key] = true;
    for (int i = 0; i < n; i++) {
        int[][][string] temp2;
        foreach (int[][] arr; temp1) {
            for (int j = 0; j < 3; j++) {
                if (arr[j].length == 0) { continue; }
                auto p = arr[j].length - 1;
                for (int k = 0; k < 3; k++) {
                    if (j == k) { continue; }
                    auto q = arr[k].length - 1;
                    if (arr[k].length > 0) {
                        if (arr[j][p] < arr[k][q]) { continue; }
                    }
                    auto xs = new int[][3];
                    xs[3-j-k] = arr[3-j-k];
                    xs[j] = arr[j][0..p];
                    xs[k] = arr[k][] ~ arr[j][p..p+1];
                    auto a = xs[0].text(), b = xs[1].text(), c = xs[2].text();
                    key = a~b~c;
                    if (key in allarr) { continue; }
                    key = a~c~b;
                    if (key in allarr) { continue; }
                    key = b~a~c;
                    if (key in allarr) { continue; }
                    key = b~c~a;
                    if (key in allarr) { continue; }
                    key = c~a~b;
                    if (key in allarr) { continue; }
                    key = c~b~a;
                    if (key in allarr) { continue; }
                    allarr[key] = true;
                    temp2[key] = xs;
                } 
            }
        }
        temp1 = temp2;
    }
    return temp1.length;
}

void main() {
    auto mn = to!(int[])(readln().chomp().split(" "));
    auto ans = solve(mn[0], mn[1]);
    writeln(ans);
}