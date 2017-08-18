// Try CodeIQ Q3322
// author: Leonardone @ NEETSDKASU
package main

import (
	"fmt"
)

func Solve(ad, rf, mt, lm int) (ans int, ok bool) {
	for i := 0; i < mt; i++ {
		ans += ad
		if ans > lm {
			ans -= rf
			if ans < 0 {
				ans = 0
			}
		}
		if ans > 75 {
			return
		}
	}
	ok = true
	return
}

func main() {
	var ad, rf, mt, lm int
	fmt.Scanf("%d,%d,%d,%d", &ad, &rf, &mt, &lm)
	if ans, ok := Solve(ad, rf, mt, lm); ok {
		fmt.Println(ans)
	} else {
		fmt.Println("good bye")
	}
}