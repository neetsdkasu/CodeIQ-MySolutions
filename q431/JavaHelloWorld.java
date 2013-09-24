//---------------------------------------
// My Answer for CodeIQ Q431
// Author: Leonardone @ NEETSDKASU
//---------------------------------------
//CodeIQ  Q431
// https://codeiq.jp/ace/cielavenir/q431
//---------------------------------------
//問題文(一部引用)
//
// Quiz-Title: Restricted Words
// Quiz-Author: @cielavenir cielavenir
//              https://codeiq.jp/ace/cielavenir/
//
// 標準出力に
// Hello World
// と出力するプログラムを作成して下さい。
// 
// ただし、数値、文字及び文字列リテラルを解答に含めることはできません。
// Perlのqqやqw、Rubyの%Q、%q、%wなども避けたほうが評価が高くなります。
// 言語仕様をフル活用して下さい！
// 
// プログラミング言語は
// AppleScript(osascript)/C/C++/C#/Clojure/D/Erlang/Fortran/Go/Groovy/Haskell/
// Hello Algorithm/HSP/Java/JavaScript(Node.js)/Kuin/Lisp/Lua/OCaml/Pascal/
// Perl/PHP/Pike/Python/R/Ruby/Scala/Scheme/Smalltalk/VB.Net
// のいずれかを使用して下さい。指定された言語以外での解答は評価されません。
//---------------------------------------

// Java
package codeiq;
class JavaHelloWorld {
	public static void main(String[] args) {
		int one = (int)Math.signum(Math.PI);
		int two = one + one;
		int four = two + two;
		StringBuilder sb = new StringBuilder(new JavaHelloWorld().getClass().getName());
		sb.delete(one - one, sb.length() - four - four - two);
		sb.insert(one + four, new java.util.Date().toString().charAt(one + two));
		System.out.println(sb.toString());
	}	
}
