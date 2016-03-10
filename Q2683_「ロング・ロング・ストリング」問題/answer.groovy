// Try CodeIQ
// author: Leonardone @ NEETSDKASU

// method
def f(double n) {
	Math.floor(n * Math.log10(n)) + 1
}

// function
double h(double b, double t, double m) {
	if (b > t) return -1
	double x = Math.floor((b + t) / 2)
	def y = f(x)
	if (y < m) {
		h(x + 1, t, m)
	} else if (y > m) {
		h(b, x - 1, m)
	} else {
		x
	}
}

// closure ( ResultType is java.lang.Double, not double!! )
def g
g = { double m ->
	h(2, 1e10, m)
}

m = new Scanner(System.in).nextDouble()
println g(m).longValue()
