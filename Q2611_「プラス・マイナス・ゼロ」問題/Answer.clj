; Try CodeIQ
; author: Leonardone @ NEETSDKASU
; ============================================
(loop [n (read) a (assoc {} 0 1)]
      (if (zero? n) (println (get a 0 0))
          (let [h (reduce #(let [k (key %2) 
                                 v (val %2)
                                 k1 (+ k n)
                                 k2 (- k n)
                                 v1 (+ v (get %1 k1 0))
                                 v2 (+ v (get %1 k2 0))]
                             (assoc %1 k1 v1 k2 v2)) {} a)]
          (recur (dec n) h))))

