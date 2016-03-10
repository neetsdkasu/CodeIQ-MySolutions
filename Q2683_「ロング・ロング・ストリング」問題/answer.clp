; Try CodeIQ
; author: Leonardone @ NEETSDKASU

(deffunction tostr(?v)
	(bind ?s (str-cat ?v))
	(bind ?i (str-index "." ?s))
	(sub-string 0 (- ?i 1) ?s))

(deffunction floor(?v) (- ?v (mod ?v 1.0)))
(deffunction ceil(?v)
	(bind ?x (floor ?v))
	(if (> ?v ?x) then (+ ?x 1.0) else ?x))

(deffunction f(?n) (+ 1 (floor (* ?n (log10 ?n))))) ; 間違っていたので修正

(deffunction h(?b ?t ?m)
	(if (> ?b ?t) then -1.0 else
	(bind ?x (floor (/ (+ ?b ?t) 2)))
	(bind ?y (f ?x))
	(if (< ?y ?m) then (h (+ ?x 1) ?t ?m)
		else (if (> ?y ?m) then (h ?b (- ?x 1) ?m)
			else ?x))))

(deffunction g(?m) (h 2 (** 10 10) ?m))

(progn
	(bind ?m (string-to-field (str-cat (readline) ".0")))
	(printout t (tostr (g ?m)) crlf))

(exit)
;