// Try CodeIQ Q3360
// author: Leonardone @ NEETSDKASU
package main

import "fmt"

type State int

func (s State) Get(p int) int {
	return (int(s) >> uint(p*2)) & 3
}

func (s *State) Set(p, v int) {
	t := int(*s)
	t &^= 3 << uint(p*2)
	t |= (v & 3) << uint(p*2)
	*s = State(t)
}

func shf(x, y int) int {
	return x + y*3
}

var wins = []State{}

func init() {
	u := State(0)
	w := u
	for y := 0; y < 3; y++ {
		s := State(0)
		t := s
		for x := 0; x < 3; x++ {
			s.Set(shf(x, y), 1)
			t.Set(shf(y, x), 1)
		}
		u.Set(shf(y, y), 1)
		w.Set(shf(y, 2-y), 1)
		wins = append(wins, s, t)
	}
	wins = append(wins, u, w)
}

func (s State) IsWin() bool {
	for _, w := range wins {
		if int(s)&int(w) == int(w) {
			return true
		}
		if (int(s)>>1)&int(w) == int(w) {
			return true
		}
	}
	return false
}

var paths = map[State]uint64{}

func dfs(n int, s State) uint64 {
	if n == 0 {
		if s.IsWin() {
			return 1
		}
		return 0
	}
	if s.IsWin() {
		return 0
	}
	c := uint64(0)
	for i := 0; i < 9; i++ {
		if s.Get(i) != 0 {
			continue
		}
		t := s
		t.Set(i, (n%2)+1)
		if v, ok := paths[t]; ok {
			c += v
		} else {
			p := dfs(n-1, t)
			paths[t] = p
			c += p
		}
	}
	return c
}

func Solve(n int) (ans uint64) {
	ans = dfs(n, State(0))
	return
}

func main() {
	var n int
	fmt.Scan(&n)
	ans := Solve(n)
	fmt.Println(ans)
}