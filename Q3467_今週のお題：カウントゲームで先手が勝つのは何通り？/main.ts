///////////////////////////////////////
// Try CodeIQ Q3467
// author: Leonardone @ NEETSDKASU
// (TypeScript -> JavaScript(Node.js))
///////////////////////////////////////

function solve(lines: string[]): void {
    const n = parseInt(lines[0], 10);
    let dp: number[][] = [];
    for (let j = 0; j < 2; j++) {
        dp[j] = [];
        for (let i = 0; i <= n; i++) {
            dp[j][i] = 0;
        }
    }
    dp[0][0] = 1;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < 2; j++) {
            for (let k = 1; k <= 3; k++) {
                if (i + k > n) { break; }
                dp[1 - j][i + k] += dp[j][i];
            }
        }
    }
    console.log(dp[1][n]);
}

let buf = '';
process.stdin.setEncoding('utf8');
process.stdin.on('readable', () => {
    const s: Buffer | string | null = process.stdin.read();
    if (s !== null) { buf += s.toString(); }
});
process.stdin.on('end', () => solve(buf.trim().split("\n")) );