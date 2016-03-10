// Try CodeIQ
// author: Leonardone @ NEETSDKASU

Gmp.mpf mpf_log2(Gmp.mpf x) {
	Gmp.mpf y = x;
	Gmp.mpf z = Gmp.mpf(0);
	while (y > 2) {
		z = z + 1;
		y = y / 2;
	}
	Gmp.mpf d = Gmp.mpf(0.5);
	for (int i = 0; i < 53; i++) {
		y = y * y;
		if (!(y < 2)) {
			y = y / 2;
			z = z + d;
		}
		d = d / 2;
	}
	return z;
}

Gmp.mpf mpf_floor(Gmp.mpf x) {
	return Gmp.mpf(Gmp.mpz(x));
}

int main() {
	Gmp.mpf m = Gmp.mpf(Stdio.stdin->gets());
	
	Gmp.mpf lg10 = mpf_log2(Gmp.mpf(10));
	Gmp.mpf b = Gmp.mpf(2);
	Gmp.mpf t = Gmp.mpf(1.0e10);
	
	while (!(b > t)) {
		Gmp.mpf x = mpf_floor((b + t) / 2);
		Gmp.mpf y = mpf_floor(x * mpf_log2(x) / lg10) + 1;
		if (y < m) {
			b = x + 1;
		} else if (y > m) {
			t = x - 1;
		} else {
			write((string)x + "\n");
			return 0;
		}
	}
	
	write("-1\n");
	return 0;
}