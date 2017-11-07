// Try CodeIQ Q3366
// author: Leonardone @ NEETSDKASU
import std.stdio, std.algorithm, std.array, std.conv;

void main() {
    int n;
    readf("%d", &n);
    auto ans = appender!(int[])();
    if (n < 6) {
        ans.put(n + 5);
        ans.put(n < 5 ? n + 1 : 1);
        ans.put(n > 1 ? n - 1 : 5);
    } else if (n < 11) {
        ans.put(n - 5);
        ans.put(n + 5);
        ans.put(n > 6 ? n + 4 : 15);
    } else if (n < 16) {
        ans.put(n - 5);
        ans.put(n + 5);
        ans.put(n < 15 ? n - 4 : 6);
    } else {
        ans.put(n - 5);
        ans.put(n < 20 ? n + 1 : 16);
        ans.put(n > 16 ? n - 1 : 20);
    }
    ans.data.sort();
    writeln(to!(string[])(ans.data).join(","));
}