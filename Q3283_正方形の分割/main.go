// Try CodeIQ Q3283
// author: Leonardone @ NEETSDKASU
package main

import (
	"fmt"
	"reflect"
	"sort"
)

func Solve(newedges []string) (ans []int) {
	corner := make([]bool, 12)
	for i := 0; i < 12; i++ {
		if i%3 == 0 {
			corner[i] = true
		}
	}
	edges := [][]int{}
outerloop:
	for _, e := range newedges {
		es := []int{int(e[0] - 'a'), int(e[1] - 'a')}
		sort.Sort(sort.IntSlice(es))
		if es[0] == es[1] {
			continue
		}
		for k := 0; k < 2; k++ {
			c := 0
			for i := (es[k] + 1) % 12; i != es[1-k]; i = (i + 1) % 12 {
				if corner[i] {
					c++
				}
			}
			if c == 0 {
				continue outerloop
			}
		}
		for _, xs := range edges {
			if reflect.DeepEqual(xs, es) {
				continue outerloop
			}
		}
		edges = append(edges, es)
	}
	joint := make([]bool, 12)
	for _, es := range edges {
		for _, e := range es {
			corner[e] = true
			joint[e] = true
		}
	}
	switch len(edges) {
	case 0:
		ans = append(ans, 4)
	case 1:
		es := edges[0]
		for k := 0; k < 2; k++ {
			c := 1
			for i := es[k]; i != es[1-k]; i = (i + 1) % 12 {
				if corner[i] {
					c++
				}
			}
			ans = append(ans, c)
		}
	case 2:
		irng := func(i int, r []int) bool { return r[0] < i && i < r[1] }
		orng := func(i int, r []int) bool { return i < r[0] || r[1] < i }
		rng := func(p, r []int) bool { return irng(p[0], r) && orng(p[1], r) }
		count := func(e int) {
			c := 1
			for i := 0; i < 12; i++ {
				j := (e + i + 1) % 12
				if corner[j] {
					c++
				}
				if joint[j] {
					ans = append(ans, c)
					c = 1
				}
			}
		}
		e0, e1 := edges[0], edges[1]
		switch {
		case rng(e0, e1) || rng(e1, e0):
			count(e0[0])
			for i := range ans {
				ans[i]++
			}
		case e0[0] == e1[0] || e0[0] == e1[1]:
			count(e0[0])
			ans[1]++
		case e0[1] == e1[0] || e0[1] == e1[1]:
			count(e0[1])
			ans[1]++
		case e0[0] > e1[0]:
			count(e0[0])
			ans[1] += ans[3]
			ans = ans[:3]
		default:
			count(e0[1])
			ans[1] += ans[3]
			ans = ans[:3]
		}
	}
	sort.Sort(sort.IntSlice(ans))
	return
}

func main() {
	var edges [2]string
	fmt.Scan(&edges[0], &edges[1])
	ans := Solve(edges[:])
	for i, c := range ans {
		if i > 0 {
			fmt.Print(",")
		}
		fmt.Print(c)
	}
	fmt.Println()
}