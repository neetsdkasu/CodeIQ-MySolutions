// Try CodeIQ
// author: Leonardone @ NEETSDKASU
(* --------------------------------------------------- *)
// 最初F#で答えを書いたがF#は受け付けてなかったのでHaskellに移植した

let g x y v (c, m) =
    if y = 1 then
        (c + v, m)
    else
        let k2 = (x + 1, y - 1)
        let v2 =
            match Map.tryFind k2 m with
            | Some z -> z + v
            | None   -> v
        (c, Map.add k2 v2 m)

let f (a, b) v s = g a b v <| g b a v s

let rec solve n (c, m) =
    if n = 0 then
        c
    else
        solve (n - 1) <| Map.foldBack f m (c, m)

let [|a; b; n|] = Array.map int <| stdin.ReadLine().Split [|','|]
let ans = solve n (0, Map.ofArray [|((a,b), 1)|])

printfn "%A" ans

;;