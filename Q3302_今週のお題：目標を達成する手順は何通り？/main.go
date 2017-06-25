// Try CodeIQ Q3302
// author: Leonardone @ NEETSDKASU
package main

import "fmt"

type uumap map[uint64]uint64

func GetXY(k uint64) (x, y uint64) {
	x = k & ((1 << 32) - 1)
	y = k >> 32
	return
}

func GenKey(x, y uint64) uint64 {
	return (y << 32) | x
}

func Solve(n, m, c uint64) uint64 {

	const (
		N = iota
		S
		E
		W
	)

	canMove := func(f, x, y, i uint64) bool {
		rem := c - i
		dx, dy := n-x, m-y
		if dx < 0 || n <= dx || dy < 0 || m <= dy {
			return false
		}
		if dx == 0 && dy == 0 {
			return rem == 0
		}
		if dx == 0 {
			switch f {
			case N:
				return rem >= dy+2
			case S:
				return rem >= dy
			default:
				return rem >= dy+1
			}
		}
		if dy == 0 {
			switch f {
			case E:
				return rem >= dx
			case W:
				return rem >= dx+2
			default:
				return rem >= dx+1
			}
		}
		min := dx + dy + 1
		switch f {
		case E, S:
			return rem >= min
		default:
			return rem >= (min + 1)
		}
	}

	start := GenKey(1, 1)
	north := uumap{start: 1}
	south := uumap{start: 1}
	east := uumap{start: 1}
	west := uumap{start: 1}

	for i := uint64(1); i <= c; i++ {
		tempNorth := uumap{}
		tempSouth := uumap{}
		tempEast := uumap{}
		tempWest := uumap{}

		for k, v := range north {
			x, y := GetXY(k)
			if canMove(N, x, y-1, i) {
				tempNorth[GenKey(x, y-1)] += v
			}
			if canMove(E, x, y, i) {
				tempEast[k] += v
			}
			if canMove(W, x, y, i) {
				tempWest[k] += v
			}
		}

		for k, v := range south {
			x, y := GetXY(k)
			if canMove(S, x, y+1, i) {
				tempSouth[GenKey(x, y+1)] += v
			}
			if canMove(E, x, y, i) {
				tempEast[k] += v
			}
			if canMove(W, x, y, i) {
				tempWest[k] += v
			}
		}

		for k, v := range east {
			x, y := GetXY(k)
			if canMove(N, x, y, i) {
				tempNorth[k] += v
			}
			if canMove(S, x, y, i) {
				tempSouth[k] += v
			}
			if canMove(E, x+1, y, i) {
				tempEast[GenKey(x+1, y)] += v
			}
		}

		for k, v := range west {
			x, y := GetXY(k)
			if canMove(N, x, y, i) {
				tempNorth[k] += v
			}
			if canMove(S, x, y, i) {
				tempSouth[k] += v
			}
			if canMove(W, x-1, y, i) {
				tempWest[GenKey(x-1, y)] += v
			}
		}

		north, south, east, west = tempNorth, tempSouth, tempEast, tempWest

		if len(north)+len(south)+len(east)+len(west) == 0 {
			panic("DAME: all zero")
		}
	}

	if len(north)+len(west) != 0 {
		panic("DAME: north west not 0")
	}

	if len(south) > 1 || len(east) > 1 {
		panic("DAME: south east over 1")
	}

	return south[GenKey(n, m)] + east[GenKey(n, m)]
}

func main() {
	var n, m, c uint64
	fmt.Scan(&n, &m, &c)
	ans := Solve(n, m, c)
	fmt.Println(ans)
}