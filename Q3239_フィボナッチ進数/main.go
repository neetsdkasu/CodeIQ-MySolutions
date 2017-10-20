// Try CodeIQ Q3239
// author: Leonardone @ NEETSDKASU
package main

import (
	"fmt"
)

func trimHead0(s string) string {
	for i, ch := range []byte(s) {
		if ch != '0' {
			s = s[i:]
			break
		}
	}
	if len(s) == 0 {
		s = "0"
	}
	return s
}

func Solve(n uint64) (ansmax, ansmin string) {
	fibs := []uint64{1, 1}
	sums := []uint64{1, 2}
	for i := 0; ; i++ {
		fibs = append(fibs, fibs[i]+fibs[i+1])
		sums = append(sums, fibs[i+2]+sums[i+1])
		if fibs[i+2] > 1000000 {
			break
		}
	}
	x := len(sums) - 1
	for {
		if sums[x] < n {
			x++
			break
		} else if sums[x] == n {
			break
		}
		x--
	}
	tmpx := sums[x]
	for ; x >= 0; x-- {
		if tmpx-fibs[x] < n {
			ansmin += "1"
		} else {
			ansmin += "0"
			tmpx -= fibs[x]
		}
	}
	y := len(fibs) - 1
	for {
		if fibs[y] <= n {
			break
		}
		y--
	}
	tmpy := uint64(0)
	for ; y >= 0; y-- {
		if tmpy+fibs[y] <= n {
			tmpy += fibs[y]
			ansmax += "1"
		} else {
			ansmax += "0"
		}
	}
	ansmax = trimHead0(ansmax)
	ansmin = trimHead0(ansmin)
	return
}

func main() {
	var n uint64
	fmt.Scan(&n)
	ansmax, ansmin := Solve(n)
	fmt.Printf(ansmax + "," + ansmin)
}