// Try CodeIQ Q3323
// author: Leonardone @ NEETSDKASU
package main

import "fmt"

var targets = make(map[int]bool)
var all int

func dfs(t, r, p int) {
	if r == 0 {
		targets[t] = true
		return
	}
	if p >= all {
		return
	}
	for i := p; i < all-(r-1); i++ {
		f := 1 << uint(i)
		dfs(t|f, r-1, i+1)
	}
}

func Solve(n, m, a int) (ans int) {
	all = n * m
	dfs(0, a, 0)
	for t := range targets {
		c := 0
		for p := 0; p < all; p++ {
			f := 1 << uint(p)
			if t&f == 0 {
				continue
			}
			y := p / m
			x := p % m
			for dy := -1; dy <= 1; dy++ {
				for dx := -1; dx <= 1; dx++ {
					if dy == 0 && dx == 0 {
						continue
					}
					gx, gy := x+dx, y+dy
					if gx < 0 || m <= gx || gy < 0 || n <= gy {
						continue
					}
					gp := gy*m + gx
					gf := 1 << uint(gp)
					if t&gf == 0 {
						c++
					}
				}
			}
		}
		if c > ans {
			ans = c
		}
	}
	return
}

func main() {
	var n, m, a int
	fmt.Scan(&n, &m, &a)
	ans := Solve(n, m, a)
	fmt.Println(ans)
}