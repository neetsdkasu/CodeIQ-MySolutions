// Try CodeIQ Q3354
// author: Leonardone @ NEETSDKASU
package main

import "fmt"

func F(n, k int) uint64 {
	n -= k
	dp := make([]uint64, n+1)
	dp[0] = 1
	for i := 1; i <= k; i++ {
		for j := n; j >= 0; j-- {
			for x := i; x+j <= n; x += i {
				dp[x+j] += dp[j]
			}
		}
	}
	return dp[n]
}

func G(n, k int) uint64 {
	dp := make([][]uint64, k+1)
	for i := range dp {
		dp[i] = make([]uint64, n+1)
	}
	dp[0][0] = 1
	for i := 1; i <= n-(k-1); i++ {
		for j := 1; j <= k; j++ {
			for x, v := range dp[j-1] {
				if x+i > n {
					break
				}
				dp[j][x+i] += v
			}
		}
	}
	return dp[k][n]
}

func Solve(n, k int) uint64 {
	return F(n, k) + G(n, k)
}

func main() {
	var n, k int
	fmt.Scan(&n, &k)
	ans := Solve(n, k)
	fmt.Println(ans)
}