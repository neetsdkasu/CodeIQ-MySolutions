// Try CodeIQ Q3264
// author: Leonardone @ NEETSDKASU
package main

import (
	"fmt"
	"strings"
)

func Solve(target string, words []string) (ans []string) {
	for _, w := range words {
		switch {
		case w == target:
			ans = append(ans, "["+w+"]")
		case strings.Contains(w, target):
			ans = append(ans, strings.Replace(w, target, "="+target+"=", -1))
		default:
			ans = append(ans, w)
		}
	}
	return
}

func main() {
	var target string
	fmt.Scan(&target)
	words := make([]string, 0, 100)
	for {
		var w string
		if _, err := fmt.Scan(&w); err != nil {
			break
		}
		words = append(words, w)
	}
	ans := Solve(target, words)
	for i, w := range ans {
		if i > 0 {
			fmt.Print(" ")
		}
		fmt.Print(w)
	}
	fmt.Println()
}