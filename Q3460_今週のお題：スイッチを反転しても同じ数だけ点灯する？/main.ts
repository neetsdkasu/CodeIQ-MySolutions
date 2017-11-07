///////////////////////////////////////
// Try CodeIQ Q3460
// author: Leonardone @ NEETSDKASU
// (TypeScript -> JavaScript(Node.js))
///////////////////////////////////////

function solve(lines: string[]): void {
    const [m, n] = lines[0].trim().split(' ').map( (x) => parseInt(x, 10) );
    // 切り替えで変わらないパターン
    // BR(ON)  -> ON  OFF (1 <-> 1) ブレーカー1個 点灯常時1個
    // BR(ON)  -> OFF ON  (1 <-> 1) ブレーカー1個 点灯常時1個
    // BR1(ON) -> ON  ON And BR2(ON) -> OFF OFF  (2 <-> 2)　ブレーカー2個組 点灯常時2個
    // ブレーカーONは上記のパターンのみ
    // ブレーカーOFF数乗したパターン数をm個以下のONのパターン数それぞれに掛ける必要がある？
    // BR(OFF) -> OFF OFF
    // BR(OFF) -> ON  OFF
    // BR(OFF) -> OFF ON
    // BF(OFF) -> ON  ON
    // 各ブレーカーの並び順とかも考慮しないといけない
    let memo: number[][][] = [];
    for (let i = 0; i <= m; i++) {
        memo[i] = [];
        for (let j = 0; j <= n; j++) {
            memo[i][j] = [];
            for (let k = 0; k <= m + m; k++) {
                memo[i][j][k] = -1;
            }
        }
    }
    function dfs(remM: number, remN: number, needPair: number): number {
        if (remM === 0) {
            return (remN === 0 && needPair === 0) ? 1 : 0;
        }
        if (memo[remM][remN][needPair + m] >= 0) {
            return memo[remM][remN][needPair + m];
        }
        let cnt = 0;
        // BR(OFF) [ON ON; ON OFF; OFF ON; OFF OFF]
        cnt += 4 * dfs(remM - 1, remN, needPair);
        // BR(ON) OFF OFF
        cnt += dfs(remM - 1, remN, needPair - 1);
        if (remN > 1) {
            // BR(ON) ON ON
            cnt += dfs(remM - 1, remN - 2, needPair + 1);
        }
        if (remN > 0) {
            // BR(ON) ON OFF or BR(ON) OFF ON
            cnt += 2 * dfs(remM - 1, remN - 1, needPair);
        }
        memo[remM][remN][needPair + m] = cnt;
        return cnt;
    }
    const ans = dfs(m, n, 0);
    console.log(ans);
}

let buf = '';
process.stdin.setEncoding('utf8');
process.stdin.on('readable', () => {
    const s: Buffer | string | null = process.stdin.read();
    if (s !== null) { buf += s.toString(); }
});
process.stdin.on('end', () => solve(buf.trim().split("\n")) );