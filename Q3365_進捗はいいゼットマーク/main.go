// Try CodeIQ Q3365
// author: Leonardone @ NEETSDKASU
package main

import (
	"fmt"
	"strings"
)

func Solve(n int) (ans []string, ok bool) {
	if ok = n%2 != 0; !ok {
		return
	}
	ans = append(ans, strings.Repeat("z", n))
	if n == 1 {
		return
	}
	for i := 1; i < n-1; i++ {
		s := strings.Repeat(".", n-i-1)
		s += "z" + strings.Repeat(".", i)
		ans = append(ans, s)
	}
	ans = append(ans, strings.Repeat("z", n))
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