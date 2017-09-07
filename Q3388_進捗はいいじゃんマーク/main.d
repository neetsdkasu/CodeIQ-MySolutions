// Try CodeIQ Q3388
// author: Leonardone @ NEETSDKASU
import std.stdio, std.array;

void main(){
    int n;
    readf("%d", &n);
    if (n % 2 == 0) {
        writeln("invalid");
        return;
    }
    writeln("e".replicate(n));
    if (n == 1) {
        return;
    }
    for (int i = 1; i < n - 1; i++) {
        if (i == n / 2) {
            writeln("e".replicate(n - n / 2), ".".replicate(n / 2));
        } else {
            writeln("e", ".".replicate(n - 1));
        }
    }
    writeln("e".replicate(n));
}