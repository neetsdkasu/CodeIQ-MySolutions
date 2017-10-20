// Try CodeIQ Q3293
// author: Leonardone @ NEETSDKASU
package main

import "fmt"

type State struct { 
    Pole [3]int
    Last int
}

func (s State)String() string {
    return fmt.Sprintf("%v %d", s.Pole, s.Last)
}

func (s State) Move(f, t int) (r State, ok bool) {
    if s.Pole[f] == 0 {
        return
    }
    h := s.Pole[f] % 10
    for z := s.Pole[t]; z > 0; z /= 10 {
        w := z % 10
        cnt := false
        for x := h; x > 0; x /= 10{
            if x % 10 > w {
                if cnt {
                    return
                }
                cnt = true
            }
        }
        h = h * 10 + w
    }
    e := 3 - f - t
    r.Pole[f] = s.Pole[f] / 10
    r.Pole[t] = s.Pole[t] * 10 + s.Pole[f] % 10
    r.Pole[e] = s.Pole[e]
    r.Last = t
    ok = true
    return
}

func main() {
	var n int
	fmt.Scan(&n)
    var s State
    for n > 0 {
        s.Pole[0] = s.Pole[0] * 10 + n % 10
        n /= 10
    }
    mp := make(map[string]bool)
    mp[s.String()] = true
    s.Last = 1
    ss1 := []State{s}
    cnt := 0
    for len(ss1) > 0 {
        ss2 := []State{}
        for _, z := range ss1 {
            if z.Pole[0] + z.Pole[2] == 0 {
                fmt.Println(cnt)
                return
            }
            for i := 1; i <= 2; i++ {
                f := (z.Last + i) % 3
                for j := 1; j <= 2; j++ {
                    t := (f + j) % 3
                    if r, ok := z.Move(f, t); ok {
                        rs := r.String()
                        if _, q := mp[rs]; !q {
                            ss2 = append(ss2, r)
                            mp[rs] = true
                        }
                    }
                }
            }
        }
        ss1 = ss2
        cnt++
    }
    fmt.Println("err")
}