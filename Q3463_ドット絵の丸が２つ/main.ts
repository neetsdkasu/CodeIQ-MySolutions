///////////////////////////////////////
// Try CodeIQ Q3463
// author: Leonardone @ NEETSDKASU
// (TypeScript -> JavaScript(Node.js))
///////////////////////////////////////

function solve(lines: string[]): void {
    const [fst, snd] = lines[0].trim().split(' ')
                        .map( (x) => x.split(',').map( (y) => parseInt(y, 10) ) );
    function inCircle(cir: number[], x: number, y: number): boolean {
        const dx = x - cir[0];
        const dy = y - cir[1];
        return dx * dx + dy * dy <= cir[2] * cir[2];
    }
    if (!inCircle([fst[0], fst[1], fst[2] + snd[2]], snd[0], snd[1])) {
        console.log('0');
        return;
    }
    const left   = Math.max(fst[0] - fst[2], snd[0] - snd[2]);
    const right  = Math.min(fst[0] + fst[2], snd[0] + snd[2]);
    const top    = Math.max(fst[1] - fst[2], snd[1] - snd[2]);
    const bottom = Math.min(fst[1] + fst[2], snd[1] + snd[2]);
    let ans = 0;
    for (let y = top; y <= bottom; y++) {
        for (let x = left; x <= right; x++) {
            if (inCircle(fst, x, y) && inCircle(snd, x, y)) {
                ans++;
            }
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