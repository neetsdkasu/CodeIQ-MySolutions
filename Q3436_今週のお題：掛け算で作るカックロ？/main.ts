///////////////////////////////////
// Try CodeIQ Q3436
// author: Leonardone @ NEETSDKASU
// (TypeScript -> JavaScript)
///////////////////////////////////
function solve(lines: string[]): void {
	let [m, n] = lines[0].split(' ').map( (x) => parseInt(x) );
	let tb: number[] = [];
	let flag: boolean[] = [];
	const maximum = 32768;
	for (let i = 0; i < 10; i++) {
		flag[i] = false;
	}
	for (let i = 0; i <= maximum; i++) {
		tb[i] = 0;
	}
	function dfs(p: number, x: number, v: number): void {
		if (x === 0) {
			tb[v]++;
			return;
		}
		for (let i = p; i < 10; i++) {
			if (flag[i]) { continue; }
			let w = v * i;
			if (w > maximum) { return; }
			flag[i] = true;
			dfs(i + 1, x - 1, w);
			flag[i] = false;
		}
	}
	dfs(1, m, 1);
	let ans = 0;
	for (let i = 1; i <= maximum; i++) {
		if (tb[i] === n) {
			ans++;
		}
	}
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
process.stdin.on('end', () => {
	solve(buf.trim().split("\n"));
});