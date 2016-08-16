#!ruby
# Try CodeIQ
# author: Leonardone @ NEETSDKASU

N = gets.to_i

X = ([0, 1, 5, 10, 20] * 4).sort.combination(4).to_a.uniq.map{|a| a.inject(:+)}.uniq.sort

h1 = [1] + [0] * 600

N.times do 
  h2 = [0] * 600
  h1.each_with_index do |v, i|
      next if v == 0
      X.each do |x|
          h2[x + i] += v
      end
  end
  h1 = h2
end

ans = 0
h1.each_with_index do |v, i|
   next if i % 8 > 0
   ans += v
end

p ans