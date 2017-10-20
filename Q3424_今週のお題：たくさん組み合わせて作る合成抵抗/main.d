// Try CodeIQ Q3424
// author: Leonrdone @ NEETSDKASU
import std.stdio     : readf, writeln, stderr;
import std.numeric   : gcd;
import std.conv      : text;

struct Ratio
{
	int ab;
	this(int _ab){ ab = _ab; }
	this(int a, int b)
	{
		int g = gcd(a, b); a /= g; b /= g; ab = (a << 16) | b;
	}
	int nume() @property { return ab >> 16; }
	int deno() @property { return ab & 0xFFFF; }
	Ratio rev() @property { return Ratio((deno << 16) | nume); }
	double toDouble() { return double(nume) / double(deno); }
	string toString() { return text(nume)~"/"~text(deno)~"("~text(toDouble())~")"; }
	Ratio opBinary(string op)(Ratio rhs)
	{
		static if (op == "+")
		{
			return Ratio(nume*rhs.deno+deno*rhs.nume,deno*rhs.deno);
		}
		else
		{
			static assert(0, "Operator "~op~" not implemented");
		}
	}	
}

auto solve(int n)
{
	auto dp = new bool[Ratio][n + 1];
	dp[0][Ratio(1, 1)] = true;
	for (int i = 1; i < n; i++)
	{
		int x = 0, y = i - 1;
		while (x <= y)
		{
			foreach (u, _; dp[x])
			{
				foreach (w, _; dp[y])
				{
					auto d = u + w;
					dp[i][d] = true;
					auto p = (u.rev + w.rev).rev;
					dp[i][p] = true;
				}
			}
			x++; y--;
		}
	}
	return dp[n - 1].length;
}

void main()
{
    int n;
	readf("%d", &n);
	auto ans = solve(n);
	writeln(ans);
}

unittest
{
	struct TC { int n, ans; }
	TC[] testcases = [{3, 4}];
	foreach (i, tc; testcases)
	{
		stderr.write(i, ": n=", tc.n, " ans=", tc.ans);
		auto ret = solve(tc.n);
		stderr.writeln(" ret=", ret);
		assert(ret == tc.ans);
	}
}