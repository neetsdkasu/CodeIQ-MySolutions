// Try CodeIQ
// author: Leonardone @ NEETSDKASU
package main

import "fmt"

func Solve(m, n int) (ans int) {
	var factors [1000001]bool
	var mostleft [10]int
    for i, _ := range mostleft {
        mostleft[i] = -1
    }
    nums := make([]int, 0, 1000000)
    sums := make([]int, 0, 1000000)
	sum := 0
	if m == 2 {
        nums = append(nums, 2)
        sums = append(sums, sum)
		mostleft[2] = 0
        sum += 2
	}
	for i := 3; i <= n; i += 2 {
		if factors[i] {
			continue
		}
		if m <= i {
			s := fmt.Sprintf("%d", i)
			for _, r := range s {
				v := int(r) - '0'
                x := len(nums)
				nums = append(nums, v)
                sums = append(sums, sum)
                sum += v
				if mostleft[v] < 0 {
					mostleft[v] = x
				} else {
                    k := mostleft[v]
                    for ; nums[k] != v || x - k + 1 > 140; k++ {
                    }
                    mostleft[v] = k
					if ans < sum-sums[mostleft[v]] {
						ans = sum - sums[mostleft[v]]
					}
				}
			}
		}
		for j := i + i; j <= n; j += i {
			factors[j] = true
		}
	}
	return
}

func main() {
	var m, n int
	fmt.Scan(&m, &n)
	answer := Solve(m, n)
	fmt.Println(answer)
}