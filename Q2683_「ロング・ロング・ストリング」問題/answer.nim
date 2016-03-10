# Try CodeIQ
# author: Leonardone @ NEETSDKASU

import parseutils
import math

proc flr(x: float): float = return x.int64.float

proc f(n: float): float = return 1.0 + flr(n * log10(n))

proc h(b, t, m: float): float =
    if b > t:
        return -1.0
    else:
        var x = flr((b + t) / 2.0)
        var y = f(x)
        if y < m:
            return h(x + 1.0, t, m)
        elif y > m:
            return h(b, x - 1.0, m)
        else:
            return x

proc g(m: float): float = return h(2.0, pow(10.0, 10.0), m)

var m = 0.0
var r = parseFloat(readLine(stdin), m)
var ans = g(m).int64
echo(ans)
