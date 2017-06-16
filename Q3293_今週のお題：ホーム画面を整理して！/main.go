// Try CodeIQ Q3293
// author: Leonardone @ NEETSDKASU
package main

import "fmt"

func main() {
	var n int
	fmt.Scan(&n)
	var dp [25][217]int
	dp[0][0] = 1
	for j := 1; j <= 9; j++ {
		for i, t := range dp[:24] {
			for k, v := range t {
				x := k + j
				if x > 216 {
					break
				}
				dp[i+1][x] += v
			}
		}
	}
	ans := 0
	for _, t := range dp {
		ans += t[n]
	}
	fmt.Println(ans)
}