//---------------------------------------
// My Answer for CodeIQ Q431
// Author Leonardone @ NEETSDKASU
//---------------------------------------
//CodeIQ  Q431
// https://codeiq.jp/ace/cielavenir/q431
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
