///////////////////////////////////////
// Try CodeIQ Q3454
// author: Leonardone @ NEETSDKASU
// (TypeScript -> JavaScript(Node.js))
///////////////////////////////////////

function solve(lines: string[]): void {
    let [m, n] = lines[0].trim().split(' ').map( (x) => parseInt(x, 10) );
    /*
    m人 n種類仮装  (0<n<m<=20)
    並び順パターン
    同じ仮装が隣通しにならないパターン
    m=5,n=3のとき7通り
    (1) A B A B C
    (2) A B A C A
    (3) A B A C B
    (4) A B C A B
    (5) A B C A C
    (6) A B C B A
    (7) A B C B C
    衣装を入れ替えた並び順は同一として数えるらしい
    例えば(1)のパターンなら
    A C A C B
    B A B A C
    B C B C A
    C A C A B
    C B C B A
    が同一並び順パターンの扱いになる
    */
    let memo: number[][][] = [];
    for (let k = 0; k <= m + 1; k++) {
        memo[k] = [];
        for (let b = 0; b <= n + 1; b++) {
            memo[k][b] = [];
            for (let p = 0; p <= n + 1; p++) {
                memo[k][b][p] = -1;
            }
        }
    }
    function dfs(k: number, b: number, p: number): number {
        if (k === 0) {
            if (p !== n) { return 0; }
            return 1;
        }
        if (b >= 0 && memo[k][b][p] >= 0) {
            return memo[k][b][p];
        }
        let ret = 0;
        if (k + p >= n) {
            for (let i = 0; i < p; i++) {
                if (i === b) { continue; }
                ret += dfs(k - 1, i, p);
            }
        }
        if (b !== p && p < n) {
            ret += dfs(k - 1, p, p + 1);
        }
        if (b >= 0) {
            memo[k][b][p] = ret;
        }
        return ret;
    }
    const ans = dfs(m, -1, 0);
    console.log(ans);
}

let buf = '';
process.stdin.setEncoding('utf8');
process.stdin.on('readable', () => {
	const s: Buffer | string | null = process.stdin.read();
	if (s !== null) {
		buf += s.toString();
	}
});
process.stdin.on('end', () => solve(buf.trim().split("\n")) );