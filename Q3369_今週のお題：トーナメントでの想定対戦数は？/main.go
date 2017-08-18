// Try CodeIQ Q3369
// author: Leonardone @ NEETSDKASU
package main

import "fmt"

func Solve(n int) (min, max int) {
	max = n*(n-1)/2 + (n - 1)
	hoge := []int{0}
	for {
		fuga := []int{}
		for i, v := range hoge {
			fuga = append(fuga, v+1, v+1)
			x := len(hoge) - (i + 1)
			if len(fuga)+x == n {
				min = 0
				for _, f := range fuga {
					min += f
				}
				for _, z := range hoge[i+1:] {
					min += z
				}
				return
			}
		}
		hoge = fuga
	}
	return
}

func main() {
	var n int
	fmt.Scan(&n)
	min, max := Solve(n)
	fmt.Println(min, max)
}