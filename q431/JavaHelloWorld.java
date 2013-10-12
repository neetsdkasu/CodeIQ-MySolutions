//---------------------------------------
// My Answer for CodeIQ Q431
// Author: Leonardone @ NEETSDKASU
//
// 私の解答 (一応の正解ではありましたが、出題者の意図(文字コード指定での一文字ずつの出力)とは少しずれてたみたいです。)
// 以下のソースコード
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
