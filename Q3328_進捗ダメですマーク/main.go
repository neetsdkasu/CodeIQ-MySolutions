// Try CodeIQ Q3328
// author: Leonardone @ NEETSDKASU
package main

import "fmt"

func Solve(n int) (ok bool, res []string) {
	if n%2 == 0 {
		return
	}
	ok = true
	res = make([]string, n)
	for y := range res {
		for x := 0; x < n; x++ {
			if x == y || n-x == y+1 {
				res[y] += "x"
			} else {
				res[y] += "."
			}
		}
	}
	return
}

func main() {
	var n int
	fmt.Scan(&n)
	ok, ans := Solve(n)
	if ok {
		for _, ln := range ans {
			fmt.Println(ln)
		}
	} else {
		fmt.Println("invalid")
	}
}