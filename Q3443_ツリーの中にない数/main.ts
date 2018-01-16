///////////////////////////////////////
// Try CodeIQ Q3443
// author: Leonardone @ NEETSDKASU
// (TypeScript -> JavaScript(Node.js))
///////////////////////////////////////

function solve(lines: string[]): void {
    const [R, M, N] = lines[0].trim().split(' ').map( (x) => parseFloat(x) );
    let memo: any = {};
    let values = [R];
    let tmp = [R];
    memo[R.toString()] = true;
    while (tmp.length > 0) {
        const x: number | undefined = tmp.pop();
        if (x === undefined) { break; }
        const y = Math.floor(x / 2.0) - M;
        if (y > 0.0 && memo[y.toString()] === undefined) {
            memo[y.toString()] = true;
            tmp.push(y);
            values.push(y);
        }
        const z = Math.floor(x * 2.0 / 3.0) - N;
        if (z > 0.0 && memo[z.toString()] === undefined) {
            memo[z.toString()] = true;
            tmp.push(z);
            values.push(z);
        }
    }
    values.sort( (a, b) => a - b );
    let p = 1;
    for (let v of values) {
        if (v !== p) {
            console.log(p);
            return;
        }
        p++;
    }
    console.log(p);
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