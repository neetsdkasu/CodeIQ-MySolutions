///////////////////////////////////////
// Try CodeIQ Q3458
// author: Leonardone @ NEETSDKASU
// (TypeScript -> JavaScript(Node.js))
///////////////////////////////////////

function solve(lines: string[]): void {
    const N = parseInt(lines[0].trim(), 10);
    if (N % 2 === 0) {
        console.log('invalid');
        return;
    }
    function repeat(s: string, c: number): string {
        let ret: string[] = [];
        for (let i = 0; i < c; i++) { ret[i] = s; }
        return ret.join('');
    }
    const ALLP = repeat('p', N);
    const TWOP = 'p' + repeat('.', N - 2) + 'p';
    const ONEP = 'p' + repeat('.', N - 1);
    for (let i = 0; i < N; i++) {
        if (i === 0 || i === N >> 1) {
            console.log(ALLP);
        } else {
            console.log(i + i < N ? TWOP : ONEP);
        }
    }
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