// Try CodeIQ Q3410
// author: Leonrdone @ NEETSDKASU
import std.stdio     : readf, writeln, stderr;
import std.math      : log2;
import std.array     : appender;
import std.algorithm : sort, reverse;
import std.conv      : to;


auto solve(int score) {
	struct Pattern { int[10] cnt; }
	
	int[string] allpatcnt;
	Pattern[string] allpat;
	Pattern pat;
	void dfsSum(int total, int count, int cur) {
		if (total == 0 && count == 0) {
			Pattern tmp = pat;
			tmp.cnt[].sort();
			auto key = tmp.cnt.to!string;
			allpatcnt[key]++;
			allpat[key] = tmp;
			return;
		}
		if (total <= 0 || count <= 0) { return; }
		int value = 1 << cur;
		if (value > total) { return; }
		int sc = value * (cast(int)log2(value) - 1);
		for (int i = 0; i <= 8; i++) {
			pat.cnt[cur] = i;
			dfsSum(total - (i * sc), count - i, cur + 1);
			pat.cnt[cur] = 0;
		}
	}
	dfsSum(score, 16, 1);
	
	
	auto flags = new int[][100];
	bool[4][4] matrix;
	void dfsPlace(int ix, int cnt, int pos) {
		if (cnt == 0) {
			int tmp = 0;
			for (int i = 0; i < 4; i++) {
				for (int j = 0; j < 4; j++) {
					tmp <<= 1;
					tmp |= matrix[i][j] ? 1 : 0;
				}
			}
			flags[ix].length++;
			flags[ix][$-1] = tmp;
			return;
		}
		if (pos == 16) { return; }
		int x = pos % 4;
		int y = pos / 4;
		if ((x == 0 || !matrix[y][x-1]) && (y == 0 || !matrix[y-1][x])) {
			matrix[y][x] = true;
			dfsPlace(ix, cnt - 1, pos + 1);
			matrix[y][x] = false;
		} 
		dfsPlace(ix, cnt, pos + 1);
	}
	for (int i = 1; i <= 8; i++) {
		dfsPlace(i, i, 0);
		debug {
			stderr.writeln(i, ": ", flags[i].length);
			stderr.writef("%b\n", flags[i][0]);
		}
	}
	int[int][100] twins;
	for (int i = 1; i <= 8; i++) {
		for (int j = i; j <= 8; j++) {
			int p = i * 10 + j;
			foreach (v; flags[i]) {
				foreach (w; flags[j]) {
					if ((v & w) != 0) { continue; }
					twins[p][v | w]++;
				}
			}
			flags[p] = twins[p].keys;
		}
	}

	int ans = 0;
	
	int dfsCount(int ix, int place) {
		int pc = pat.cnt[ix];
		if (pc == 0) {
			return 1;
		}
		int ret = 0;
		if (pat.cnt[ix+1] > 0) {
			int p = pat.cnt[ix+1] * 10 + pc;
			foreach (v; flags[p]) {
				if ((place & v) != 0) { continue; }
				int bi = twins[p][v];
				ret += bi * dfsCount(ix + 2, place | v);
			}
		} else {
			foreach (v; flags[pc]) {
				if ((place & v) != 0) { continue; }
				ret += dfsCount(ix + 1, place | v);
			}
		}
		return ret;
	}
	
	foreach (k, p; allpat) {
		p.cnt[].reverse();
		pat = p;
		int ret = dfsCount(0, 0);
		ans += ret * allpatcnt[k];
		debug stderr.writeln(k, ": ", ret);
	}
	
	return ans;
}

void main() {
    int sc;
	readf("%d", &sc);
	auto ans = solve(sc);
	writeln(ans);
}

unittest {
	struct TC { int sc, ans; }
	TC[] testcaes = [ {32, 2} ];
	foreach (i, tc; testcaes) {
		stderr.write(i, ": sc", tc.sc, " ans=", tc.ans);
		auto ret = solve(tc.sc);
		stderr.writeln(" ret=", ret);
		assert (ret == tc.ans);
	}
}