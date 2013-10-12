//---------------------------------------------------------------------------
// My Answer for CodeIQ Q466
// Author: Leonardone @ NEETSDKASU
//
// 私の解答（残念ながら最小のステップ数には至りませんでした。つまり不正解）
// ステップ数: 8
// [201](4)->(4)0[4]0[12]->(201601)44->(44944)->21[2]->21[4]->(2116)->(4)6->26
//
//---------------------------------------------------------------------------
// HeiseiHenkan.java
//---------------------------------------------------------------------------

package codeiq;

import java.util.ArrayDeque;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;

/**
 * CodeIQ q466 平成変換の問題の解答用クラス。
 * 
 * @author Leonardone @ NEETSDKASU
 *
 */
class HeiseiHenkan {

	public static void main(String[] args) {
		HeiseiHenkan hh = new HeiseiHenkan();
		// seek(始端, 終端, 探索最大深度, 探索最大桁数)
		hh.seek(2014, 26, 10, 8);
	}
		
	// history 		探索済みの数字をkeyとし、探索時深度を登録する。
	private HashMap<String, Integer> history = null;
	// maxlength 	探索時の数字の最大桁数。
	private int maxlength;
	// end			探索の終端の数字。
	private String end = null;
	// begin		探索の始端の数字。
	private String begin = null;
	// processmap	変換パターンを登録する。keyは変換元の数字。
	private HashMap<String, HashSet<TransData>> processmap = null;
	// resultmap	結果を登録する。変換プロセスの文字列表現をkeyとし、変換回数を登録する。
	private HashMap<String, Integer> resultmap = null;
	// mincount		結果の最小変換回数。
	private int mincount;

	HeiseiHenkan() {
	}

	/**
	 * 見つかった変換プロセスを登録する。
	 * 
	 * @param process	見つかった一連の変換プロセス。
	 */
	private final void registProcess(ArrayDeque<TransData> process) {
		for (Iterator<TransData> i = process.descendingIterator(); i.hasNext();) {
			TransData p = i.next();
			String key = p.getBase();
			if (!this.processmap.containsKey(key)) {
				this.processmap.put(key, new HashSet<TransData>());
			}
			this.processmap.get(key).add(p);
		}
	}
	
	/**
	 * パターンから平成変換を表す文字列に変換する。
	 * 
	 * @param flags		平成変換のパターン。
	 * @param base		平成変換後の数字。
	 * @return			平成変換を表す文字列。
	 */
	private final String changeTransString(int[] flags, String base) {
		StringBuilder sb = new StringBuilder();
		long n = 0L;
		int p = 0;
		int len = flags.length;
		
		// 変換パターンを解析する。
		for (int j = 0; j < len; j++) {
			
			// 変換パターン適用の数字の処理。
			if (flags[j] == p) {
				n = (n * 10L) +  (long)(base.charAt(j) - '0');
			} else {
				p = p % 10; // 変換パターンの抽出。
				if (p == TransData.TRANSTYPE_ROOT) { 
					sb.append("(");
					sb.append(n * n);
					sb.append(")");
				} else if (p == TransData.TRANSTYPE_SQUARE) {
					sb.append("[");
					sb.append((long)Math.sqrt((double)n));
					sb.append("]");
				}
				n = (long)(base.charAt(j) - '0');
				p = flags[j];
			}

			// 変換対象外の数字はそのまま表示。
			if (flags[j] == 0) {
				sb.append(base.charAt(j));
			}			
		}
		
		// 最後に残ったパターンの処理。
		p = p % 10;
		if (p == TransData.TRANSTYPE_ROOT) { 
			sb.append("(");
			sb.append(n * n);
			sb.append(")");
		} else if (p == TransData.TRANSTYPE_SQUARE) {
			sb.append("[");
			sb.append((long)Math.sqrt((double)n));
			sb.append("]");
		}
		return sb.toString();
	}

	/**
	 * 見つかった変換プロセスのパターンの総当たりの組み合わせを再帰的に求め、終端まで辿り着いたプロセスを短縮化する。
	 * 
	 * @param current	調べる変換プロセスの数字。
	 * @param list		現在の一連の変換プロセス。
	 */
	private final void optimizeProcess(String current, ArrayDeque<TransData> list) {
		if (!this.end.equals(current)) {
			// currentからの変換パターンからのすべてのプロセスを再帰的に調べる。
			HashSet<TransData> mps = this.processmap.get(current);
			if (mps == null) {
				return;
			}
			for (Iterator<TransData> i = mps.iterator(); i.hasNext();) {
				TransData ps = i.next();
				list.push(ps);
				optimizeProcess(ps.getNext(), list);
				list.pop();
			}
		} else {
			// 平成変換の終端に到達したとき。
			StringBuilder result = new StringBuilder(); //一連のプロセスの文字列表現を格納する。
			TransData cur = null; //　
			int[] flags = null; // 変換パターンを格納する。
			int len;
			int type;
			int phase = 0; // 変換パターンの区別用。
			int count = 0;
			
			// プロセスの始端を追加する。
//			result.append(this.begin);
//			result.append("->");
			
			// 求まったプロセスを短縮処理を施しながら追加していく。
			for (Iterator<TransData> i = list.descendingIterator(); i.hasNext();) {
				cur = i.next();

				if (flags != null){
					len = flags.length - cur.getFootSize();
					
					// 変換パターンの重複を調べる。
					boolean check = false;
					for (int j = cur.getHeadSize(); j < len; j++) {
						if (flags[j] != 0) {
							check = true;
							break;
						} 
					}
					
					if (check) {
						// 変換パターンの重複があったので短縮形の確定し追加する。
						result.append(changeTransString(flags, cur.getBase()));
						result.append("->");
						count++;
						flags = null;
					} else {
						// 変換パターンが重複しないので短縮パターンに新しいパターンを重ねる。
						int tmplen = cur.getNext().length();
						int[] tmpflags = new int[tmplen];
						tmplen -= cur.getFootSize();
						phase += 10;
						type = cur.getTransType() + phase;
						for (int j = 0; j < tmpflags.length; j++) {
							if (j < cur.getHeadSize()) {
								tmpflags[j] = flags[j];
							} else if (j < tmplen) {
								tmpflags[j] = type;
							} else {
								tmpflags[j] = flags[j - tmplen + len];
							}
						}
						flags = tmpflags;
					}
				}
				
				// 新しい変換パターンの開始。				
				if (flags == null) {
					phase = 0;
					len = cur.getNext().length();
					flags = new int[len];
					type = cur.getTransType();
					len -= cur.getFootSize();
					for (int j = cur.getHeadSize(); j < len; j++) {
						flags[j] = type;
					}
				}
			}
			
			// 最後の変換パターンを追加する。
			if (flags != null) {
				result.append(changeTransString(flags, cur.getNext()));
				result.append("->");
				count++;
			}
			
			// プロセスの終端を追加する。
			result.append(this.end);
			
			// プロセスを登録する。
			resultmap.put(result.toString(), Integer.valueOf(count));
			if (count < this.mincount) {
				this.mincount = count;
			}
		}
	}



	/**
	 * 平成変換の部分プロセスを探索する。
	 * 
	 * @param begin		探索始端の数字。
	 * @param process	探索中の部分的な一連の変換プロセス。
	 * @param deep		残り探索深度。
	 */
	private final void henkan(String begin, ArrayDeque<TransData> process, int deep) {

		// 最終形に到達
		if (this.end.equals(begin)) {
			registProcess(process);
			return;
		}

		// 平方や平方根をいくらでも適用して終わりが来にくいパターンを回避する。(henkan()呼び出しのスタックオーバーフローを起こす。)
		if (deep < 0) {
			return;
		}

		int n = begin.length();
		// 平方した場合、いくらでも大きくなっていくので制限する。(henkan()呼び出しのスタックオーバーフローを起こす。)
		if (n > this.maxlength) {
			return;
		}

		// 重複の探索を減らすため一度調べた数字は除外する。
		int psize = process.size();
		if (this.history.containsKey(begin)) {
			Integer bf = this.history.get(begin);
			if (bf != null) {
				// 現在の深度が前回の深度以下の場合は解がありうるパターン
				if (psize <= bf.intValue()) {
					// 既存の解があるかチェック
					if (this.processmap.containsKey(begin)) {
						// 前回の探索で最短解が存在
						this.history.put(begin, Integer.valueOf(psize));
						registProcess(process);
						return;
					} else if (psize == bf.intValue()) {
						// 解なしで前回と同深度なら、やはり解なし
						return;
					}
					// beginの前回探索時にdeepによる探索打ち切りの可能性があるため
					// ps < bf.intValue() の場合は探索をする
					// (但し、本当に解なしの場合の重複探索になる場合もある)

				} else {
					return;
				}
			}
		}
		this.history.put(begin, Integer.valueOf(psize));

		// 数字(begin)の3分割の総当たり
		for (int i = 0; i < n; i++) {
			if (begin.charAt(i) == '0') {
				// 「平成変換のルール: 0で始まる数字で分割はされない。」
				continue;
			}
			// 平成変換において 1で分割は意味が無いので分割の頭文字が1なら2桁(2文字)以上から分割する。
			for (int j = i + (begin.charAt(i) == '1' ? 2 : 1); j <= n; j++) {
				// 数字(begin)を3つに分割
				String head = begin.substring(0, i);
				String sb = begin.substring(i, j); // 平方・平方根で計算する部分
				String foot = begin.substring(j);
				long sbnm = Long.parseLong(sb);

				// 平方根のパターン
				long root = (long) Math.sqrt((double) sbnm);
				if ((root * root) == sbnm) {
					String next = head.concat(Long.toString(root)).concat(foot);
					process.push(new TransData(begin, next, head.length(), foot.length(),
							TransData.TRANSTYPE_ROOT));
					this.henkan(next, process, deep - 1);
					process.pop();
				}

				// 平方(2乗)のパターン
				long sqnm = sbnm * sbnm;
				long test = (long) Math.sqrt((double) sqnm);
				if (test != sbnm) {
					// 2乗でlongの最大桁を超えた場合
					continue;
				}
				String square = Long.toString(sqnm);
				String next = head.concat(square).concat(foot);
				process.push(new TransData(begin, next, head.length(), foot.length(),
						TransData.TRANSTYPE_SQUARE));
				this.henkan(next, process, deep - 1);
				process.pop();
			}
		}
	}
	
	/**
	 * 平成変換の探索の結果を表示する。
	 */
	private final void printResults() {
		String result = null; // 最終結果
		int allcount = 0;
		
		// 求まった最短プロセスのすべてを列挙する。
		for (Iterator<String> i = this.resultmap.keySet().iterator(); i.hasNext(); ) {
			String key = i.next();
			int count = this.resultmap.get(key).intValue();
			
			// 最短プロセス以外は除外する。
			if (count > this.mincount) {
				continue;
			}
			allcount++;
			
			// 表示上の文字列が最も少ないものを最終結果とする。
			if (result != null) {
				if (key.length() < result.length()) {
					result = key;
				}
			} else {
				result = key;
			}
			
			// プロセスの表示。
			System.out.print("Count: ");
			System.out.print(count);
			System.out.print(" ; ");
			System.out.println(key);
		}
		if (this.resultmap.size() == 0) {
			// 変換プロセスがひとつも見つからなかった場合。
			System.out.println("No Answer.");
		} else {
			// 最終結果の表示。
			System.out.print("All Processes: ");
			System.out.println(allcount);
			System.out.println("------ Min Process ------");
			System.out.print("Count: ");
			System.out.println(this.mincount);
			System.out.println(result);
		}		
	}

	/**
	 * 平成変換の最小のルートを探し、結果を標準出力に表示する。
	 * 
	 * @param iBegin		平成変換の始端の数字。
	 * @param iEnd			平成変換の終端の数字。
	 * @param deep			平成変換の探索の最大深度。この数値が大きいほど探索に時間がかかる。
	 * @param maxlength		平成変換の探索の数字の上限桁数。この数値が大きいほど探索に時間がかかる。
	 */
	public final synchronized void seek(int iBegin, int iEnd, int deep, int maxlength) {
		long time = System.currentTimeMillis();
		
		System.out.print("begin: ");
		System.out.println(iBegin);
		System.out.print("end: ");
		System.out.println(iEnd);
		System.out.print("deep: ");
		System.out.println(deep);
		System.out.print("maxlength: ");
		System.out.println(maxlength);

		// 探索に使う変数の初期化。
		this.begin = Integer.toString(iBegin);
		this.end = Integer.toString(iEnd);
		this.maxlength = maxlength;
		this.history = new HashMap<String, Integer>();
		this.processmap = new HashMap<String, HashSet<TransData>>();
		this.resultmap = new HashMap<String, Integer>();
		this.mincount = deep + 1;
		
		System.out.println("Start seek process...");
		henkan(this.begin, new ArrayDeque<TransData>(), deep);
		
		if (this.processmap.size() > 0) {
			System.out.println("Start optimize process...");
			optimizeProcess(this.begin, new ArrayDeque<TransData>());
		}
		
		System.out.println("------ Results ------");
		printResults();
		
		time = System.currentTimeMillis() - time;
		System.out.print("seeking time: ");
		System.out.print(time / 1000L);
		System.out.println(" sec.");
	}

	/**
	 * 変換パターンの保持用クラス。
	 * 
	 * @author Leonardone @ NEETSDKASU
	 *
	 */
	private final class TransData {
		
		static final int TRANSTYPE_ROOT = 1;	// 変換の種類、平方根。
		static final int TRANSTYPE_SQUARE = 2;	// 変換の種類、二乗。
		
		private final String base;		// 変換前の数字。
		private final String next;		// 変換後の数字。
		private final int headsize;		// 数字の変換しない前部分のサイズ。
		private final int footsize;		// 数字の変換しない後ろ部分のサイズ。
		private final int transtype;	// 変換の種類。

		TransData(String base, String next, int headsize, int footsize, int transtype) {
			this.base 		= base;
			this.next 		= next;
			this.headsize 	= headsize;
			this.footsize 	= footsize;
			this.transtype  = transtype;
		}

		final String getBase() {
			return this.base;
		}

		final String getNext() {
			return this.next;
		}

		final int getHeadSize() {
			return this.headsize;
		}

		final int getFootSize() {
			return this.footsize;
		}
		
		final int getTransType() {
			return this.transtype;
		}

		/*
		 * Eclipseによる自動生成
		 * 
		 * @see java.lang.Object#hashCode()
		 */
		@Override
		public final int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result + getOuterType().hashCode();
			result = prime * result + ((base == null) ? 0 : base.hashCode());
			result = prime * result + footsize;
			result = prime * result + headsize;
			result = prime * result + transtype;
			return result;
		}

		/*
		 * Eclipseによる自動生成
		 * 
		 * @see java.lang.Object#equals(java.lang.Object)
		 */
		@Override
		public final boolean equals(Object obj) {
			if (this == obj) {
				return true;
			}
			if (obj == null) {
				return false;
			}
			if (getClass() != obj.getClass()) {
				return false;
			}
			TransData other = (TransData) obj;
			if (!getOuterType().equals(other.getOuterType())) {
				return false;
			}
			if (base == null) {
				if (other.base != null) {
					return false;
				}
			} else if (!base.equals(other.base)) {
				return false;
			}
			if (footsize != other.footsize) {
				return false;
			}
			if (headsize != other.headsize) {
				return false;
			}
			if (transtype != other.transtype) {
				return false;
			}
			return true;
		}

		/*
		 * Eclipseによる自動生成
		 */
		private final HeiseiHenkan getOuterType() {
			return HeiseiHenkan.this;
		}
	}
}

