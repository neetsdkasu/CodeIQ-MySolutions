// Try CodeIQ Q3314
// author: Leonardone @ NEETSDKASU
package main

import (
	"fmt"
)

/*
type field []uint64

func newField() field {
	return make(field, 10)
}

func (f *field) String() (s string) {
	for _, v := range *f {
		s += fmt.Sprintf("%x ", v)
	}
	return
}

func (f *field) get(y, x int) bool {
	return (((*f)[y] >> uint(x)) & 1) == 1
}

func (f *field) set(y, x int) {
	(*f)[y] |= 1 << uint(x)
}

func (src field) getCopy() field {
	dst := newField()
	copy(dst, src)
	return dst
}

func Solve(n int) (ans uint64) {
	f0 := newField()
	f0.set(0, 0)
	targets := map[string]field{f0.String(): f0}
	for i := 1; i < n; i++ {
		temp := map[string]field{}
		for _, f := range targets {
			w := f.getCopy()
			for j := 0; j < 60; j++ {
				if !w.get(0, j) {
					w.set(0, j)
					break
				}
			}
			temp[w.String()] = w
			for y := 1; y < 10; y++ {
				for x := 0; x < i+1-y; x++ {
					if !f.get(y, x) && f.get(y-1, x) && f.get(y-1, x+1) {
						u := f.getCopy()
						u.set(y, x)
						temp[u.String()] = u
					}
				}
			}
		}
		targets = temp
	}
	ans = uint64(len(targets))
	return
}
*/

//
// https://oeis.org/A005169
//
var memo = map[string]uint64{}

func f(n, p uint64) uint64 {
	s := fmt.Sprintf("%d %d", n, p)
	if v, ok := memo[s]; ok {
		return v
	}
	switch {
	case p > n:
		return 0
	case p == n:
		return 1
	default:
		sum := uint64(0)
		for q := uint64(1); q <= p+1; q++ {
			sum += f(n-p, q)
		}
		memo[s] = sum
		return sum
	}
}

func Solve(n int) (ans uint64) {
	ans = f(uint64(n), 1)
	return
}

func main() {
	var n int
	fmt.Scan(&n)
	ans := Solve(n)
	fmt.Println(ans)
}