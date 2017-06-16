// Try CodeIQ 3292
// author: Leonardone @ NEETSDKASU
package main

import (
	"fmt"
	"strconv"
	"strings"
)

const (
	REMOTEWORK = iota
	CONTRIBUTEOSS
	CASUALFASHION
	RATINGSPECIALIST
	OVERTIME
)

const ENABLE = "true"

func main() {
	var input string
	fmt.Scan(&input)
	offerdata := strings.Split(input, ",")
	score := 0
	needs := offerdata[REMOTEWORK] == ENABLE && offerdata[CONTRIBUTEOSS] == ENABLE
	if overtime, _ := strconv.Atoi(offerdata[OVERTIME]); needs && overtime < 30 {
		if offerdata[CASUALFASHION] == ENABLE {
			score += 10
		}
		if offerdata[RATINGSPECIALIST] == ENABLE {
			score += 10
		}
		switch {
		case 20 <= overtime && overtime <= 29:
			score += 10
		case 1 <= overtime && overtime <= 19:
			score += 20
		case overtime == 0:
			score += 30
		}
	}
	fmt.Println(score)
}