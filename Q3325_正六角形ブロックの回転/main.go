// Try CodeIQ Q3325
// author: Leonardone @ NEETSDKASU
package main

import (
	"fmt"
	"strings"
)

func Solve(pivot string, cells []string) (ans []string, ok bool) {
	table := make([][]bool, 15)
	for i := range table {
		table[i] = make([]bool, 30)
	}
	count := 0
	for i, c := range cells {
		y := 5 + i
		x := 10 - (len(c) - len(cells[0]))
		for _, p := range c {
			if p == '1' {
				count++
				table[y][x] = true
			}
			x += 2
		}
	}
	var x0, y0 int
	switch pivot {
	case "a":
		x0, y0 = (10 - 3 - 2), (5 + 3)
	case "b":
		x0, y0 = (10 + 2 - 2), (5 + 4)
	default:
		return
	}
	tempCount := 0
	for i, c := range cells {
		if i > 0 && len(c) < len(cells[i-1]) {
			x0++
			y0--
		} else {
			x0 += 2
		}
		x, y := x0, y0
		temp := ""
		for _ = range c {
			if table[y][x] {
				temp += "1"
				tempCount++
			} else {
				temp += "0"
			}
			x--
			y--
		}
		ans = append(ans, temp)
	}
	ok = tempCount == count
	/*
		fmt.Println(count)
		for _, t := range table {
			for _, b := range t {
				if b {
					fmt.Print("1")
				} else {
					fmt.Print("0")
				}
			}
			fmt.Println()
		}
	*/
	return
}

func main() {
	var pivot, temp string
	fmt.Scan(&pivot, &temp)
	cells := []string{}
	for _, c := range strings.Split(temp, "/") {
		cells = append(cells, c)
	}
	if ans, ok := Solve(pivot, cells); ok {
		fmt.Println(strings.Join(ans, "/"))
	} else {
		fmt.Println("-")
	}
}