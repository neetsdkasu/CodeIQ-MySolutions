// Try CodeIQ Q3267
// author: Leonardone @ NEETSDKASU
package main

import "fmt"

func IsOddPrime(x int) bool {
	for i := 3; i*i <= x; i += 2 {
		if x%i == 0 {
			return false
		}
	}
	return true
}

func Solve(n int) (ans int) {
	calender := make([]bool, 0, 20000)
	calender = append(calender, true)
	for y := 1970; y <= 2019; y++ {
		for m := 1; m <= 12; m++ {
			ed := 31
			switch m {
			case 4, 6, 9, 11:
				ed = 30
			case 2:
				if y%4 == 0 {
					ed = 29
				} else {
					ed = 28
				}
			}
			for d := 1; d <= ed; d++ {
				isPrime := false
				if d%2 != 0 {
					ymd := (y*100+m)*100 + d
					isPrime = IsOddPrime(ymd)
				}
				calender = append(calender, isPrime)
			}
		}
	}
	calender = append(calender, true)
	c := 0
	j := 0
	for i, b := range calender {
		if !b {
			continue
		}
		if c < n+2 {
			if c == 0 {
				j = i
			}
			c++
			if c == n+2 {
				ans = i - j - 1
			}
			continue
		}
		j++
		for !calender[j] {
			j++
		}
		tmp := i - j - 1
		if tmp > ans {
			ans = tmp
		}
	}
	return
}

func main() {
	var n int
	fmt.Scan(&n)
	ans := Solve(n)
	fmt.Println(ans)
}