// Try CodeIQ Q3308
// author: Leonardone @ NEETSDKASU
package main

import "fmt"

func Solve(n uint) (ans int) {

	mask := ((1 << n) - 1) << 1
	first := 1 << n
	temp1 := map[int]bool{first: true}
	goal := 2

	for {
		ans++
		temp2 := map[int]bool{}
		for k, _ := range temp1 {
			for i := uint(0); i < n; i++ {
				x := (k ^ (7 << i)) & mask
				temp2[x] = true
			}
		}
		if temp2[goal] {
			return
		}
		temp1 = temp2
	}
}

func main() {
	var n uint
	fmt.Scan(&n)
	ans := Solve(n)
	fmt.Println(ans)
}