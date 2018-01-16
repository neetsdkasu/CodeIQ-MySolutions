///////////////////////////////////////
// Try CodeIQ Q3434
// author: Leonardone @ NEETSDKASU
// (TypeScript -> JavaScript(Node.js))
///////////////////////////////////////

// https://oeis.org/A018809 より
// g n k = takeWhile ((<n).(*k)) $ dropWhile ((<=(-n)).(*k)) [(-n)..n]
// h n k = sum [(n-k*abs x)*(n-k*abs y)|x<-g n k,y<-g n k,gcd x y==1]
// f n = (`div`2) $ (h n 3)-2*(h n 2)+(h n 1)
// main = print $ map f [2 .. 40]
function gcd(a: number, b: number): number {
    if (a === 0) { return b; }
    if (b < a) { return gcd(b, a); }
    return gcd(b % a, a);
}
function h(n: number, k: number): number {
    let sum = 0;
    for (let x = -n+1; x < n; x++) {
        const kx = Math.abs(k * x);
        if (kx >= n) { continue; }
        for (let y = -n+1; y < n; y++) {
            const ky = Math.abs(k * y);
            if (ky >= n) { continue; }
            if (gcd(Math.abs(x), Math.abs(y)) === 1) {
                sum += (n - kx) * (n - ky);
            }
        }
    }
    return sum;
}
function f(n: number): number {
    return Math.floor((h(n, 3) - 2 * h(n, 2) + h(n, 1)) / 2);
}
function solve(lines: string[]): void {
    const n = parseInt(lines[0], 10);
    const ans = f(n);
    console.log(ans);
}

let buf = '';
process.stdin.setEncoding('utf8');
process.stdin.on('readable', () => {
    const s: Buffer | string | null = process.stdin.read();
    if (s !== null) { buf += s.toString(); }
});
process.stdin.on('end', () => solve(buf.trim().split("\n")) );