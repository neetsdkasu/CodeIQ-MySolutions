# Try CodeIQ
# author: Leonardone @ NEETSDKASU

require 'prime'

N = gets.to_i

x = [0] * (N + 1)

(1..N).each do |i|
    Prime.prime_division(i).each do |pr, c|
        x[pr] += c
    end
end

ans = 1
(1..N).each do |i|
    next if x[i] == 0
    c = 1
    t = i
    (x[i] * N).times do
        c += t
        t = (t * i) % 1000003
    end
    ans = (ans * c) % 1000003
end

puts ans