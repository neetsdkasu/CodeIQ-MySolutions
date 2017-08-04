// Try CodeIQ Q3334
// author: Leonardone @ NEETSDKASU
package main

import "fmt"

func Solve(n, m, a int) (ans uint64) {
	if n < m {
		n, m = m, n
	}
	tmp1 := map[int]uint64{0: 1}
	for r := a; r > 0; r-- {
		tmp2 := map[int]uint64{}
		for k, v := range tmp1 {
			x, y := k/100, k%100
			if x < n && y < m {
				tmp2[k+101] += v
			}
			if x < n {
				tmp2[k+100] += v
			}
			if y < m {
				tmp2[k+1] += v
			}
		}
		tmp1 = tmp2
	}
	ans = tmp1[n*100+m]
	return
}

func main() {
	var n, m, a int
	fmt.Scan(&n, &m, &a)
	ans := Solve(n, m, a)
	fmt.Println(ans)
}