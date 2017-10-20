// Try CodeIQ Q3423
// author: Leonardone @ NEETSDKASU

process.stdin.setEncoding('utf8');

let inputdata = '';

process.stdin.on('readable', () => {
  const chunk: String | Buffer | null = process.stdin.read();
  if (chunk !== null) {
    inputdata += chunk.toString();
  }
});

process.stdin.on('end', () => {
  const n = parseInt(inputdata);
  if (n % 2 === 0) {
    console.log('invalid');
    return;
  }
  const halfn = Math.floor(n / 2);
  for (let i = 0; i < halfn; i++) {
      let s = '';
      for (let j = 0; j < n; j++) {
        if (j === i || j === n - 1 - i) {
          s += 'y';
        } else {
          s += '.';
        }
      }
      console.log(s);
  }
  let c = '';
  for (let i = 0; i < halfn; i++) {
    c += '.';
  }
  c = c + 'y' + c;
  for (let i = halfn; i < n; i++) {
      console.log(c);
  }
});