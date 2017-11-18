///////////////////////////////////////
// Try CodeIQ Q3465
// author: Leonardone @ NEETSDKASU
// (TypeScript -> JavaScript(Node.js))
///////////////////////////////////////

function solve(lines: string[]): void {
    const n = parseInt(lines[0], 10);
    if (n % 2 === 0) {
        console.log('invalid');
        return;
    }
    for (let i = 0; i < n; i++) {
        let s = '';
        for (let j = 0; j < n; j++) {
            if (j === 0 || j === n - 1 || j == i) {
                s += 'n';
            } else {
                s += '.';
            }
        }
        console.log(s);
    }
}

let buf = '';
process.stdin.setEncoding('utf8');
process.stdin.on('readable', () => {
    const s: Buffer | string | null = process.stdin.read();
    if (s !== null) { buf += s.toString(); }
});
process.stdin.on('end', () => solve(buf.trim().split("\n")) );