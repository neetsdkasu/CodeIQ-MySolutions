// Try CodeIQ
// author: Leonardone @ NEETSDKASU
package main

import "fmt"

func main() {
    var m, n int
    fmt.Scan(&m, &n)
    dp := make([]int, m + 1)
    dp[0] = 1
    for j := 0; j < m; j++ {
        x := m - j
        k := n
        if x < k { k = x }
        for ; k > 0; k-- {
            dp[j + k] += dp[j]
        }
    }
    fmt.Println(dp[m])
}