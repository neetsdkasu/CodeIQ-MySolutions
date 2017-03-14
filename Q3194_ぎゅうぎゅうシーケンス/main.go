// Try CodeIQ
// author: Leoanrdone @ NEETSDKASU
package main

import "fmt"

func min(a, b int) (c int) { c = b; if a < b { c = a }; return }
func max(a, b int) (c int) { c = b; if a > b { c = a }; return }

func main() {
    var n int
    fmt.Scan(&n)
    p1, p2, p3 := -1, -1, -1
    ans := n
    for i := 0; i < n; i++ {
        var a int
        fmt.Scan(&a)
        switch a {
        case 1:
            p1 = i
        case 2:
            p2 = i
        case 3:
            p3 = i
        }
        if p1 < 0 || p2 < 0 || p3 < 0 {
            continue
        }
        ans = min(ans, max(p1,max(p2,p3)) - min(p1,min(p2,p3)) + 1)
    }
    fmt.Println(ans)
}