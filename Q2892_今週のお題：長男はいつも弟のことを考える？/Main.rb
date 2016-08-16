#!ruby
# Try CodeIQ
# author: Leonardone @ NEETSDKASU

H, W, C = gets.strip.split(',').map &:to_i


$memo = {}

count = 0

def makeK(h, w, c)
    h * 10000 + w * 100 + c
end

def cut(h, w, c)
    
    return 1 if c == 1
    return 0 if h * w < c
    
    k = makeK h, w, c
    return $memo[k] if $memo.include? k
    
    x = 0
    
    (1 ... w).each do |i|
        x += cut(h, i, c - 1)
    end
    (1 ... h).each do |i|
        x += cut(i, w, c - 1)
    end
    
    $memo[k] = x
    return x
end

p cut(H, W, C)