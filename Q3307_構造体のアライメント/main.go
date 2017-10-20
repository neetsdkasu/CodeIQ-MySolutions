// Try CodeIQ Q3307
// author: Leonardone @ NEETSDKASU
package main

import "fmt"

func Solve(s string) (ans int) {
    sz := 0
    for _, ch := range s {
        switch ch {
        case 'C':
            ans = sz
            sz++
        case 'S':
            ans = sz + (2 - (sz % 2)) % 2
            sz = ans + 2
        case 'I':
            ans = sz + (4 - (sz % 4)) % 4
            sz = ans + 4
        case 'L':
            ans = sz + (4 - (sz % 4)) % 4
            sz = ans + 8
        case 'D':
            ans = sz + (8 - (sz % 8)) % 8
            sz = ans + 8
        case 'M':
            ans = sz + (16 - (sz % 16)) % 16
            sz = ans + 16
        }
    }
    return
}

func main() {
    var s string
    fmt.Scan(&s)
    ans := Solve(s)
    fmt.Println(ans)
}