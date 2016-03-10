// Try CodeIQ
// author: Leonardone @ NEETSDKASU
(* --------------------------------------------------- *)

let f n =
    let d = float n
    (+) 1L << int64 << floor <| d * (log10 d) // 間違っていたので修正

let g m =
    let rec h b t =
        if b > t then
            -1L
        else
            let x = (b + t) / 2L
            let y = f x
            if y < m then
                h (x + 1L) t
            elif y > m then
                h b (x - 1L)
            else
                x
    h 2L (pown 10L 10)

let m = int64 <| stdin.ReadLine()

printf "%d" <| g m

;;