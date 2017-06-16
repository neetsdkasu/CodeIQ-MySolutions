// Try CodeIQ Q3225
// author: Leonardone @ NEETSDKASU
package main

import "fmt"

/*
0 <-> 0
1 <-> 1
2 <-> 2
5 <-> 5
6 <-> 9
8 <-> 8
数字は7種類

n = 1のときは 6 のみの1通り

例えば、n = 2のとき、以下の21通りがあります。
01, 02, 05, 06, 08, 09, 12, 15, 16, 18, 19, 25, 26, 28, 29, 56, 58, 59, 66, 68, 86

n = 2のとき反転しても変わらないパターンの7パターン
00 11 22 55 69 88 96


最上位桁をA、最下位桁をZ、Aの反転をA'、Zの反転をZ'とすると
A....Z
を反転したとき
Z'....A'
となる
Z'>AとなるときAとZの間の桁がどのような値でも題意を満たす
Z'==Aとなるときは間の一連の桁が題意を満たす場合のみ題意を満たす
Z'<Aとなるときは間の桁に関わらず題意を満たさない

Z'>Aとなるときはn=2のときと同じ21パターン
Z==Aはn=2のとき反転しても変わらない7パターン

Z'>Aとなるときの間の桁のパターンは7種類の数字のどれを置いてもいいので 7 ^ 間の桁数 通りになる

*/

func main() {
	var n int
	fmt.Scan(&n)
	switch n {
	case 1:
		fmt.Println(1) // 6 -> 9
	case 2:
		fmt.Println(21)
	default:
		inner := int64(1)
		answer := int64(0)
		if n%2 == 1 {
			inner = 7
			answer = 1
		}
		for i := 0; i < n/2; i++ {
			answer = 21*inner + 7*answer
			inner *= 7 * 7
		}
		fmt.Println(answer)
	}
}