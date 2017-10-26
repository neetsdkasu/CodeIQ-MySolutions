///////////////////////////////////
// Try CodeIQ Q3446
// author: Leonardone @ NEETSDKASU
// (TypeScript -> JavaScript)
///////////////////////////////////

function solve(lines: String[]): void {
	let n = parseInt(lines[0].trim());
	let cnt1st: number[] = [];
	let cntFin: number[] = [];
	let cntJap: number[] = [];
	let dp: number[][] = [[], [], [], [], [], []];
	for (let i = 0; i <= n; i++) {
		cnt1st[i] = 0;
		cntFin[i] = 0;
		cntJap[i] = 0;
		for (let j = 0; j < dp.length; j++) {
			dp[j][i] = 0;
		}
	}
	function dfs1st(p: number, s: number, t: number): void {
		if (s >= 101 || t >= 200 || p === 3) {
			cnt1st[p]++;
			return;
		}
		dfs1st(p + 1, s + 100, t);
		dfs1st(p + 1, s + 1, t + 1);
		dfs1st(p + 1, s, t + 100);
	}
	function dfsFin(p: number, f: number, w: number): void {
		if (f >= 4 || f >= w + (6 - p) || w >= 4 || w > f + (6 - p) || p === 6) {
			cntFin[p]++;
			return;
		}
		dfsFin(p + 1, f + 1, w);
		dfsFin(p + 1, f, w);
		dfsFin(p + 1, f, w + 1);
	}
	function dfsJap(mn: number, p: number, sw: number, pw: number): void {
		if (sw >= 4 || pw >= 4) {
			cntJap[p]++;
			return;
		}
		if (p > mn) {
			return;
		}
		dfsJap(mn, p + 1, sw + 1, pw);
		dfsJap(mn, p + 1, sw, pw);
		dfsJap(mn, p + 1, sw, pw + 1);
	}
	dfs1st(0, 0, 0);
	dfsFin(0, 1, 0);
	dp[0][0] = 1;
	for (let k = 0; k < 2; k++) {
		for (let i = 0; i <= n; i++) {
			if (cnt1st[i] === 0) { continue; }
			for (let j = 0; i+j <= n; j++) {
				dp[k+1][i+j] += dp[k][j] * cnt1st[i];
			}
		}
	}
	for (let k = 2; k < 4; k++) {
		for (let i = 0; i <= n; i++) {
			if (cntFin[i] === 0) { continue; }
			for (let j = 0; i+j <= n; j++) {
				dp[k+1][i+j] += dp[k][j] * cntFin[i];
			}
		}
	}
	for (let i = 0; i <= n; i++) {
		if (dp[4][i] === 0) { continue; }
		dfsJap(n - i, 0, 0, 0);
		break;
	}
	for (let i = 0; i <= n; i++) {
		if (cntJap[i] === 0) { continue; }
		for (let j = 0; i+j <= n; j++) {
			dp[5][i+j] += dp[4][j] * cntJap[i];
		}
	}
	console.log(dp[5][n]);
}

let buf = '';
process.stdin.setEncoding('utf8');
process.stdin.on('readable', () => {
	const s: Buffer | String | null = process.stdin.read();
	if (s !== null) {
		buf += s.toString();
	}
});
process.stdin.on('end', () => {
	solve(buf.trim().split("\n"));
});