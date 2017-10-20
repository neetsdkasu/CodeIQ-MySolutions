// Try CodeIQ
// author: Leonrdone @ NEETSDKASU
import std.stdio     : readln, writeln, stderr;
import std.string    : chomp;
import std.conv      : to;

long solve(int n) {

	if (n < 0 || 9 < n) {
		return 0;
	}
	
	auto ans = new int[20];
	auto flag = new bool[10];
	
	void dfs(int k, int isbn10, int isbn13) {
		if (k == 0) {
			auto cd10 = (11 - (isbn10 % 11)) % 11;
			auto cd13 = (10 - (isbn13 % 10)) % 10;
			if (cd10 == cd13) {
				ans[cd10]++;
			}
			return;
		}
		for (int i = 0; i <= 9; i++) {
			if (flag[i]) { continue; }
			flag[i] = true;
			dfs(k - 1, isbn10+(k+1)*i, isbn13+(1+(k%2)*2)*i);
			flag[i] = false;
		}
	}
	dfs(8, 4*10, 9*1+7*3+8*1+4*3);
	
	return ans[n];
}

void main() {
    auto n_str = readln.chomp;
	if (n_str[0] == 'X') {
		writeln(0);
		return;
	}
	auto n = n_str.to!int;
	auto ans = solve(n);
	writeln(ans);
}

unittest {
	struct TC { int n, ans; }
	TC[] testcases = [{1, 14751}];
	foreach (i, tc; testcases) {
		stderr.write(i, ": n=", tc.n, " ans=", tc.ans);
		auto ret = solve(tc.n);
		stderr.writeln(" ret=", ret);
		assert (ret == tc.ans);
	}
}