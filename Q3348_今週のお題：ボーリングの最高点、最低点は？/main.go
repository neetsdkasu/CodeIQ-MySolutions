// Try CodeIQ Q3348
// author: Leonardone @ NEETSDKASU
package main

import "fmt"

var (
	minscore = 999
	maxscore = 0
)

func dfsMin(n, strike, spare, score int, a []int) {
	if strike == 0 && spare == 0 {
		if score < minscore {
			minscore = score
		}
		return
	}
	k := len(a)
	if n == 10 {
		if spare > 0 || strike > 2 {
			return
		}
		if strike > 1 {
			if a[k-1] != 2 {
				return
			}
			x := score + 20
			if a[k-2] == 2 {
				x += 10
			}
			if x < minscore {
				minscore = x
			}
			return
		}
		if a[k-1] == 0 {
			return
		}
		x := score
		if a[k-1] > 0 {
			x += 10
		}
		if a[k-2] > 1 {
			x += 10
		}
		if x < minscore {
			minscore = x
		}
		return
	}
	if strike > 0 {
		x := score + 10
		if k > 0 && a[k-1] > 0 {
			x += 10
		}
		if k > 1 && a[k-2] > 1 {
			x += 10
		}
		dfsMin(n+1, strike-1, spare, x, append(a, 2))
	}
	if spare > 0 {
		x := score + 10
		if k > 0 && a[k-1] == 2 {
			x += 10
		}
		dfsMin(n+1, strike, spare-1, x, append(a, 0, 1))
	}
	dfsMin(n+1, strike, spare, score, append(a, 0, 0))
}

func dfsMax(n, strike, spare, score int, a []int) {
	k := len(a)
	if strike == 0 && spare == 0 {
		x := score
		for i := n; i < 10; i++ {
			x += 9
			if k > 0 && a[k-1] > 0 {
				x += 9
			}
			if k > 1 && a[k-2] == 2 {
				x += 9
			}
			a = append(a, 0, 0)
			k = len(a)
		}
		if a[k-1] == 1 {
			x += 9
		}
		if a[k-1] == 2 {
			x += 9
		}
		if a[k-2] == 2 {
			x += 9
		}
		if x > maxscore {
			maxscore = x
		}
		return
	}
	if n == 10 {
		if spare > 0 || strike > 2 {
			return
		}
		if strike > 1 {
			if a[k-1] != 2 {
				return
			}
			x := score + 20
			if a[k-2] == 2 {
				x += 10
			}
			if x > maxscore {
				maxscore = x
			}
			return
		}
		if a[k-1] == 0 {
			return
		}
		x := score
		if a[k-1] > 0 {
			x += 10
			if a[k-1] == 2 {
				x += 9
			}
		}
		if a[k-2] > 1 {
			x += 10
		}
		if x > maxscore {
			maxscore = x
		}
		return
	}
	if strike > 0 {
		x := score + 10
		if k > 0 && a[k-1] > 0 {
			x += 10
		}
		if k > 1 && a[k-2] > 1 {
			x += 10
		}
		dfsMax(n+1, strike-1, spare, x, append(a, 2))
	}
	if spare > 0 {
		x := score + 10

		if k > 0 {
			if a[k-1] == 2 {
				x += 10
			}
			if a[k-1] == 1 {
				x += 9
			}
		}
		if k > 1 && a[k-2] == 2 {
			x += 9
		}
		dfsMax(n+1, strike, spare-1, x, append(a, 0, 1))
	}
	x := score + 9
	if k > 0 && a[k-1] > 0 {
		x += 9
	}
	if k > 1 && a[k-2] == 2 {
		x += 9
	}
	dfsMax(n+1, strike, spare, x, append(a, 0, 0))
}

func Solve(strike, spare int) (ans int) {
	minscore, maxscore = 999, 0
	dfsMin(0, strike, spare, 0, []int{})
	dfsMax(0, strike, spare, 0, []int{})
	ans = maxscore - minscore
	return
}

func main() {
	var strike, spare int
	fmt.Scan(&strike, &spare)
	ans := Solve(strike, spare)
	fmt.Println(ans)
}