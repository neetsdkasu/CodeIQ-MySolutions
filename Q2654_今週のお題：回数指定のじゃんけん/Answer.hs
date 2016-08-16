-- Try CodeIQ
-- author: Leonardone @ NEETSDKASU

import qualified Data.Map as Map

split _ [] = []
split f xs =
    case break f xs of
        (ws, []) -> [ws]
        (ws, ts) -> [ws] ++ (split f $ tail ts)

main = print . solve . map read . split (== ',') =<< getLine

solve [a, b, n] = loop n (0, Map.singleton (a, b) 1) where
    loop 0 (c, _) = c
    loop n (c, m) = loop (n - 1) $ Map.foldrWithKey f (c, m) m
    f (a, b) v s = g a b v $ g b a v s
    g _ 1 v (c, m) = (c + v, m)
    g x y v (c, m) = (c, Map.insert k2 v2 m) where
        k2 = (x + 1, y - 1)
        v2 = (+) v $ Map.findWithDefault 0 k2 m