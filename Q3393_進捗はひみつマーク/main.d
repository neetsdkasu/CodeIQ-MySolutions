// Try CodeIQ Q3393
// author: Leonrdone @ NEETSDKASU
import std.array     : replicate;
import std.stdio     : readf, writeln;

void main() {
    int n;
    readf("%d", &n);
    if (n % 2 == 0) {
        writeln("invalid");
        return;
    }
    for (int i = 0; i < n; i++) {
        if (i == n / 2){
            writeln("h".replicate(n));
        } else {
            writeln("h", ".".replicate(n - 2), "h");
        }
    }
}