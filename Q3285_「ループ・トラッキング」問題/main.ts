///////////////////////////////////////
// Try CodeIQ Q3285
// author: Leonardone @ NEETSDKASU
// (TypeScript -> JavaScript(Node.js))
///////////////////////////////////////

//
// x = 0: f(n,0) == 0 == f(n,n) :x = n
// x = 1: f(n,1) == f(n,n-1)    :x = n-1
// x = 2: f(n,2) == f(n,n-2)    :x = n-2
// x = 3: f(n,3) == f(n,n-3)    :x = n-3
// ...
// x = p: f(n,p) == f(n,n-p) :x = n-p
//
function f(n: number, x: number): number {
    return Math.floor(4 * x * (n - x) / n) | 0;
}

//
// k = 0: f(n,0) -> f(n,k00) -> f(n,k01) ... -> f(n,k0?)
// k = 1: f(n,1) -> f(n,k10) -> f(n,k11) ... -> f(n,k1?)
// k = 2: f(n,2) -> f(n,k20) -> f(n,k21) ... -> f(n,k2?)
// k = 3: f(n,3) -> f(n,k30) -> f(n,k31) ... -> f(n,k3?)
// ...
// k = n-3: f(n,n-3) == f(n,3) ... -> f(n,k3?)
// k = n-2: f(n,n-2) == f(n,2) ... -> f(n,k2?)
// k = n-1: f(n,n-1) == f(n,1) ... -> f(n,k1?)
// k = n:   f(n,n)   == f(n,0) ... -> f(n,k0?)
//
let memo: number[] = [];
function g(n: number, k: number): number {
    if (memo.length === 0) {
        for (let i = 0;i <= n; i++) {
            memo[i] = 0;
        }
    }
    if (memo[k] > 0) {
        return memo[k];
    }
    let o: number[] = [];
    let c: { [key: number]: number } = {};
    o.push(k);
    c[k] = 0;
    let x = 0;
    for (let i = 1; ; i++) {
        k = f(n, k);
        if (memo[k] > 0) {
            x = memo[k];
            o.push(k);
            break;
        }
        if (c[k] !== undefined) {
            x = i - c[k];
            break;
        }
        o.push(k);
        c[k] = i;
    }
    while (o.length > 0) {
        const p = o.pop();
        if (p === undefined) { break; }
        memo[p] = x;
        if (p === k) {
            break;
        }
    }
    while (o.length > 0) {
        const p = o.pop();
        if (p === undefined) { break; }
        x++;
        memo[p] = x;
    }
    return x;
}

//
// 0 < n <= 3e5 
// n = 0: g(0,0)
// n = 1: g(1,0)+g(1,1) == g(1,0)+g(1,0)
// n = 2: g(2,0)+g(2,1)+g(2,2) == g(2,0)+g(2,1)+g(2,0)
// n = 3: g(3,0)+g(3,1)+g(3,2)+g(3,3) == g(3,0)+g(3,1)+g(3,1)+g(3,0)
// n = 4: g(4,0)+g(4,1)+g(4,2)+g(4,3)+g(4,4) == g(4,0)+g(4,1)+g(4,2)+g(4,1)+g(4,0)
//
function h(n: number): number {
    let ret = 0;
    for (let k = 0; k <= n; k++) {
        ret += g(n, k);
    }
    return ret;
}

function solve(lines: string[]): void {
    const n = parseInt(lines[0]);
    console.log(h(n));
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