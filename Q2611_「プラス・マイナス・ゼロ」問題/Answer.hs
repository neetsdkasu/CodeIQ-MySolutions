-- Try CodeIQ
-- author: Leonardone @ NEETSDKASU

import qualified Data.IntMap as IntMap

main = print . solve . read =<< getLine where
    solve n = loop n $ IntMap.fromList [(0,1)]
    loop 0 xm = IntMap.findWithDefault 0 0 xm
    loop i xm = loop (i - 1) nx where
        nx = IntMap.foldrWithKey f IntMap.empty xm
        f k v rm = res where
            tmp = IntMap.insertWith (+) (k + i) v rm
            res = IntMap.insertWith (+) (k - i) v tmp