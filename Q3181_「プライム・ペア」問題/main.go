// Try CodeIQ
// author: Leonardone @ NEETSDKASU
package main

import "fmt"

func main() {
    const dv = 1000003
    var n int
    fmt.Scan(&n)
    p := make(map[int]int)
    for i := 2; i <= n; i++ {
        v := i
        for j := 2; j * j <= v; j++ {
            if v % j != 0 { continue }
            c := 0
            for v % j == 0 {
                v /= j
                c++
            }
            p[j] += c
        }
        if v != 1 {
            p[v]++
        }
    }
    var y int64 = 1
    for k, v := range p {
        e1 := int64(k)
        e2 := int64(1)
        for i := 1; i < v; i++ {
            e1 = (e1 * int64(k)) % dv
            e2 = (e2 * int64(k)) % dv
        }
        e := (e1 + dv - e2) % dv
        y = (y * e) % dv
    }
    fmt.Println(y)
}