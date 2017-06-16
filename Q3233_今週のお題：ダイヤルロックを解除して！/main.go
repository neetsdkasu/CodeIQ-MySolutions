// Try CodeIA Q3233
// author: Leonardone @ NEETSDKASU
package main

import "fmt"

func main() {
    var m, n int
    fmt.Scan(&m, &n)
    
    var dp [51][51]int
    
    dp[0][0] = 1
    
    for i := 0; i < m; i++ {
        for j := 0; j < 51; j++ {
            for k := 1; k <= 9; k++ {
                if j + k < 51{
                    dp[i + 1][j + k] += dp[i][j]
                }
            }
        }
    }
    
    fmt.Println(dp[m][n])
}