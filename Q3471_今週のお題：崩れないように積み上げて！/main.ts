///////////////////////////////////////
// Try CodeIQ Q3471
// author: Leonardone @ NEETSDKASU
// (TypeScript -> JavaScript(Node.js))
///////////////////////////////////////

type Map = { [key: string]: number };

function solve(lines: string[]): void {
    const [m, n] = lines[0].trim().split(' ').map( (x) => parseInt(x, 10) );
    const genkey = (r: number, w: number, h: number): string => {
        return r.toString() + 'x' + w.toString() + 'x' + h.toString();
    };
    const parse = (k: string): number[] => k.split('x').map( (x) => parseInt(x, 10) );
    let tb1: Map = {};
    let lim: number[] = [0];
    for (let i = 1; i <= m; i++) {
        lim[i] = lim[i - 1] + i * i;
    }
    for (let h = m; h <= n; h++) {
        for (let w = m; w * h <= n - lim[m-1]; w++) {
            const r = n - w * h;
            const k = genkey(r, w, h);
            tb1[k] = 1;
        }
    }
    for (let i = m - 1; i >= 1; i--) {
        let tb2: Map = {};
        for (let k in tb1) {
            const c = tb1[k];
            const [r, w, h] = parse(k);
            for (let h2 = i; h2 < h; h2++) {
                for (let w2 = i; w2 < w && w2 * h2 <= r - lim[i-1]; w2++) {
                    const r2 = r - w2 * h2;
                    const k2 = genkey(r2, w2, h2);
                    if (tb2[k2] === undefined) {
                        tb2[k2] = c;
                    } else {
                        tb2[k2] += c;
                    }
                }
            }
        }
        tb1 = tb2;
    }
    let ans = 0;
    for (let k in tb1) {
        const r = parse(k)[0];
        if (r === 0) {
            ans += tb1[k];
        }
    }
    console.log(ans);
}

let buf = '';
process.stdin.setEncoding('utf8');
process.stdin.on('readable', () => {
    const s: Buffer | string | null = process.stdin.read();
    if (s !== null) { buf += s.toString(); }
});
process.stdin.on('end', () => solve(buf.trim().split("\n")) );