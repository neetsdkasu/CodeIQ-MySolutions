; Try CodeIQ
; author: Leonardone @ NEETSDKASU

(define (f_ n)
	(1+ (floor (* n (log10 n)))))

(define (g_ m)
	(define (h_ b z)
		(if (> b z) -1
			(let* ((x (floor (/ (+ b z) 2)))
				   (y (f_ x)))
				(if (> y m) (h_ b (1- x))
				(if (< y m) (h_ (1+ x) z)
					x)))))
	(h_ 2 (expt 10 10)))

(display (g_ (read)))