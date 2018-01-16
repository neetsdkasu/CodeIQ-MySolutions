///////////////////////////////////////
// Try CodeIQ Q3418
// author: Leonardone @ NEETSDKASU
// (TypeScript -> JavaScript(Node.js))
///////////////////////////////////////

function reverse(s: string): string {
    return s.split('').reverse().join('');
}
function bruteforce(lw: string, up: string): void {
    if (up.length > 5) { return; }
    const x = parseInt(lw);
    const y = parseInt(up);
    let arr: number[] = [];
    for (let i = x; i <= y; i++) {
        const s = i.toString();
        if (s === reverse(s)) {
            arr.push(i);
        }
    }
    const h = arr.length >> 1;
    process.stderr.write(`bruteforce c=${arr.length} h=${h} `);
    if (arr.length % 2 === 0) {
        process.stderr.write(`ans=[${arr[h-1]}, ${arr[h]}]\n`);
    } else {
        process.stderr.write(`ans=[${arr[h]}]\n`);
    }
}
function solve(lines: string[]): void {
    const [lw, up] = lines[0].split(',');
    bruteforce(lw, up);
    let lows: number[] = [0, 1];
    let upps: number[] = [0, 9];
    let cnts: number[] = [0, 9];
    for (let i = 2; i <= 16; i++) {
        const k = i >> 1;
        const q = Math.pow(10, k - 1 + i % 2) | 0;
        upps[i] = q * 10 - 1;
        lows[i] = q;
        cnts[i] = q * 9;
    }
    const p1 = lw.length % 2;
    const p2 = up.length % 2;
    const h1 = lw.length >> 1;
    const h2 = up.length >> 1;
    const [lwh, lwl] = [lw.substr(0,h1+p1), lw.substr(h1+p1)];
    const [uph, upl] = [up.substr(0,h2+p2), up.substr(h2+p2)];
    const x = parseInt(lwh, 10) + (lwl > reverse(lwh).substr(p1) ? 1 : 0);
    const y = parseInt(uph, 10) - (upl < reverse(uph).substr(p2) ? 1 : 0);
    let c = 0;
    if (lw.length === up.length) {
        if (y < x) {
            process.stdout.write('-');
            return;
        }
        c = y - x + 1;
    } else {
        c += upps[lw.length] - x + 1;
        for (let i = lw.length + 1; i < up.length; i++) {
            c += cnts[i];
        }
        c += y - lows[up.length] + 1;
    }
    const half = c >> 1;
    process.stderr.write(`solve c=${c} h=${half}\n`);
    let d = 0;
    for (let i = lw.length; i <= up.length; i++) {
        const k = i > lw.length ? cnts[i] : upps[i] - x + 1;
        if (d + k <= half) {
            d += k;
            continue;
        }
        const p = i % 2;
        const a = half - d + (i > lw.length ? lows[i] : x);
        const s = a.toString();
        let ss = s + reverse(s).substr(p);
        if (c % 2 === 0) {
            const q = a === lows[i] ? 1-p : p;
            const b = a === lows[i] ? upps[i-1] : a-1;
            const t = b.toString();
            ss = t + reverse(t).substr(q) + ',' + ss;
        }
        process.stdout.write(ss);
        break;
    }
}

let buf = '';
process.stdin.setEncoding('utf8');
process.stdin.on('readable', () => {
	const s: Buffer | string | null = process.stdin.read();
	if (s !== null) { buf += s.toString(); }
});
process.stdin.on('end', () => solve(buf.trim().split("\n")) );
