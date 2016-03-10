(* Try CodeIQ                                 *)
(* author: Leonardone @ NEETSDKASU            *)
(* ****************************************** *)

let f n = 1.0 +. (floor (n *. (log10 n))) in

let g m =
	let rec h b t =
		if b > t then -1.0
		else
			let x = floor ((b +. t) /. 2.0) in
			let y = f x in
			if y < m then h (x +. 1.0) t
			else if y > m then h b (x -. 1.0)
			else x
	in h 2.0 (10.0 ** 10.0) in
				
let m = read_float () in
let ans = Int64.to_string (Int64.of_float (g m)) in

print_newline (print_string ans)

;;