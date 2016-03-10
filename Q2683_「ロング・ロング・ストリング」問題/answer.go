// Try CodeIQ
// author: Leonardone @ NEETSDKASU

package main

import (
    "fmt"
    "math"
)

func f(n float64) float64 {
    return 1 + math.Floor(n * math.Log10(n))
}

func g(m float64) float64 {
    b := 2.0
    t := math.Pow10(10)
    for b <= t {
        x := math.Floor((b + t) / 2)
        y := f(x)
        if y < m {
            b = x + 1
        } else if y > m {
            t = x - 1
        } else {
            return x
        }
    }
    return -1
}

func main() {
    var m float64;
    
    fmt.Scan(&m);
    
    ans := int64(g(m))
    
    fmt.Print(ans)
    
}
