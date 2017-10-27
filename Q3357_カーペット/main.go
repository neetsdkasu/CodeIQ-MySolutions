// Try CodeIQ Q3357
// author: Leonardone @ NEETSDKASu
package main

import (
	"fmt"
	"sort"
)

type Pos struct{ x, y int }

var rot = []Pos{
	{0, 0}, {1, 0}, {2, 0}, {2, 1},
	{2, 2}, {1, 2}, {0, 2}, {0, 1},
}

func enc(n int) (x, y, p int) {
	x, y, p = 0, 0, 1
	n--
	for {
		d := rot[n%8]
		x += d.x * p
		y += d.y * p
		if n < 8 {
			break
		}
		p *= 3
		n /= 8
	}
	return
}

func dec(c, x, y, p int) int {
	if p == 0 {
		return c + 1
	}
	d := Pos{x / p, y / p}
	k := -1
	for i, r := range rot {
		if d == r {
			k = i
			break
		}
	}
	if k < 0 {
		return -1
	}
	return dec(c*8+k, x%p, y%p, p/3)
}

func Solve(n int) (ans []int) {
	x, y, p := enc(n)
	for _, dt := range []Pos{{1, 0}, {0, 1}, {-1, 0}, {0, -1}} {
		dx, dy := x+dt.x, y+dt.y
		if dx < 0 || dy < 0 {
			continue
		}
		if m := dec(0, dx, dy, p*3); m > 0 {
			ans = append(ans, m)
		}
	}
	return
}

func main() {
	var n int
	fmt.Scan(&n)
	ans := Solve(n)
	sort.Sort(sort.IntSlice(ans))
	for i, v := range ans {
		if i > 0 {
			fmt.Print(",")
		}
		fmt.Print(v)
	}
	fmt.Println()
}