; Try CodeIQ
; author: Leonardone @ NEETSDKASU

(defun f(n) (+ 1.0d0 (ffloor (* n (log n 1.0d1)))))

(defun h(b z m)
	(if (> b z) -1.0d0
		(let* ((x (ffloor (/ (+ b z) 2.0d0)))
			  (y (f x)))
		(cond ((< y m) (h (+ x 1.0d0) z m))
			  ((> y m) (h b (- x 1.0d0) m))
			  (t x)))))

(defun g(m) (h 2.0d0 1.0d10 m))

(princ (floor (g (+ 0.0d0 (read)))))
(princ "
")

