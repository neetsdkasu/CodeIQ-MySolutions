// Try CodeIQ Q3355
// author: Leonardone @ NEETSDKASU
package main

import "fmt"

func Abs(a int) int {
	if a < 0 {
		return -a
	}
	return a
}

func Solve(n int) (ans []string, ok bool) {
	if n%2 == 0 {
		return
	}
	c := n / 2
	for i := 0; i < n; i++ {
		s := ""
		for j := 0; j < n; j++ {
			switch {
			case i <= c && Abs(j-c) == i:
				s += "o"
			case i > c && Abs(j-c) == n-i-1:
				s += "o"
			default:
				s += "."
			}
		}
		ans = append(ans, s)
	}
    ok = true
    return
}

func main() {
	var n int
	fmt.Scan(&n)
	if ans, ok := Solve(n); ok {
		for _, ln := range ans {
			fmt.Println(ln)
		}
	} else {
		fmt.Println("invalid")
	}

}