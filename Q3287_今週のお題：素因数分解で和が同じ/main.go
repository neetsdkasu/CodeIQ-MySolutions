// Try CodeIQ 3287
// author: Leonardone @ NEETSDKASU
package main

import "fmt"

func main() {
	var n int
	fmt.Scan(&n)
	dp := make([]int, n+1)
	dp[0] = 1
	sv := make([]bool, n+1)
	for f := 2; f <= n; f++ {
		if sv[f] {
			continue
		}
		for k := f; k <= n; k += f {
			sv[k] = true
		}
		for j := n - f; j >= 0; j-- {
			for k := f; j+k <= n; k += f {
				dp[j+k] += dp[j]
			}
		}
	}
	fmt.Println(dp[n])
}