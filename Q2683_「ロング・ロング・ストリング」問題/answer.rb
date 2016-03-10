#!ruby
# Try CodeIQ
# author: Leonardone @ NEETSDKASU

def f(x)
    (x * Math.log10(x)).floor + 1 # 間違っていたので修正
end

def g(x)
    def h(b, t, m)
        return -1 if b > t
        i = ((t + b) / 2).floor
        j = f(i)
        if m > j
            h(i + 1, t, m)
        elsif m < j
            h(b, i - 1, m)
        else
            i
        end
    end
    h(2, 10 ** 10, x)
end

m = gets.to_i
p g(m)