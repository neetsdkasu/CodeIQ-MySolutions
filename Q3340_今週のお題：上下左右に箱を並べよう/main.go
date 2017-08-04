// Try CodeIQ Q3340
// author: Leonardone @ NEETSDKASu
package main

import (
	"fmt"
	"sort"
)

const (
	W = 21
	H = W
    X0, Y0 = W / 2, H / 2
)

var (
	memo  = map[string]bool{}
	field [H][W]bool
)

func enc(x, y int) (k int) { k = y*100 + x; return }
func dec(k int) (x, y int) { x, y = k%100, k/100; return }

func rotate(a []int) {
	for i := range a {
		x0, y0 := dec(a[i])
		x1, y1 := y0, (W-1)-x0
		a[i] = enc(x1, y1)
	}
}

func tostr(a []int) string {
	b := make([]int, len(a))
	copy(b, a)
	sort.Sort(sort.IntSlice(b))
	s := make([]rune, len(a))
	for i, v := range b {
		s[i] = rune(v)
	}
	return string(s)
}

func dfs(n, x, y int, a []int) {
	if n == 0 {
		for i := 0; i < 4; i++ {
			s := tostr(a)
			memo[s] = true
			rotate(a)
		}
		return
	}
	if field[y][x] {
		return
	}
	field[y][x] = true
	a = append(a, enc(x, y))
	dfs(n-1, x+1, y, a)
	dfs(n-1, x-1, y, a)
	dfs(n-1, x, y+1, a)
	dfs(n-1, x, y-1, a)
	field[y][x] = false
}

func Solve(n int) (ans int) {
    field[Y0][X0] = true
    dfs(n, X0, Y0-1, make([]int, 0, n))
    ans = len(memo)
	return
}

func main() {
	var n int
	fmt.Scan(&n)
	ans := Solve(n)
	fmt.Println(ans)
}