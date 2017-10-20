// Try CodeIQ Q3265
// author: Leonardone @ NEETSDKASU
package main

import (
	"fmt"
	"sort"
)

func Solve(x int) (ans []int) {
	corners := make([]bool, 12)
	for i := range corners {
		if i%2 == 0 {
			corners[i] = true
		}
	}
	startp := 0
	joints := make([]bool, 12)
	for i := 0; i < 12; i++ {
		if x&(1<<uint(i)) != 0 {
			joints[i] = true
			corners[i] = true
			startp = i
		}
	}
	count := 1
	p := startp
	for i := 0; i < 12; i++ {
		p = (p + 1) % 12
		if corners[p] {
			count++
		}
		if joints[p] {
			if startp%6 != p%6 {
				count++
			}
			ans = append(ans, count)
			startp = p
			count = 1
		}
	}
	sort.Sort(sort.IntSlice(ans))
	return
}

func main() {
	var x int
	fmt.Scan(&x)
	ans := Solve(x)
	for i, v := range ans {
		if i > 0 {
			fmt.Print(",")
		}
		fmt.Print(v)
	}
	fmt.Println()
}