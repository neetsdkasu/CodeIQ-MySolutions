// Try CodeIQ Q3319
// author: Leonardone @ NEETSDKASU
package main

import "fmt"

type Block [][]bool

func NewBlock(h, w int) (b Block) {
	b = make([][]bool, h)
	for i := range b {
		b[i] = make([]bool, w)
	}
	return
}

func (b Block) Copy() (c Block) {
	c = make([][]bool, len(b))
	for i, v := range b {
		c[i] = make([]bool, len(v))
		copy(c[i], v)
	}
	return
}

func (b Block) Translate() (c Block) {
	h, w := len(b), len(b[0])
	c = NewBlock(h, w)
	for i, v := range b {
		for j, t := range v {
			c[h-i-1][w-j-1] = !t
		}
	}
	return
}

func (b Block) String() string {
	s := ""
	for _, v := range b {
		for _, c := range v {
			if c {
				s += "o"
			} else {
				s += "x"
			}

		}
	}
	return s
}

func Solve(n, m int) (ans int) {
	if (n*m)%2 == 1 {
		return
	}
	b := NewBlock(n, m)
	b[0][0] = true
	temp1 := make(map[string]Block)
	temp1[b.String()] = b
	for i := (n * m) / 2; i > 1; i-- {
		temp2 := make(map[string]Block)
		for _, bl := range temp1 {
			for y, vert := range bl {
				for x, t := range vert {
					if t {
						continue
					}
					f := x > 0 && vert[x-1]
					f = f || (x+1 < m && vert[x+1])
					f = f || (y > 0 && bl[y-1][x])
					f = f || (y+1 < n && bl[y+1][x])
					f = f && !bl[n-y-1][m-x-1]
					if f {
						c := bl.Copy()
						c[y][x] = true
						temp2[c.String()] = c
					}
				}
			}
		}
		temp1 = temp2
	}
	for k, bl := range temp1 {
		c := bl.Translate().String()
		if k == c {
			ans++
		}
	}
	return
}

func main() {
	var n, m int
	fmt.Scan(&n, &m)
	ans := Solve(n, m)
	fmt.Println(ans)
}