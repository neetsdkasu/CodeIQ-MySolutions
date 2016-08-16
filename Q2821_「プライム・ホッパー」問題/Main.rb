#!ruby
# Try CodeIQ
# author: Leonardone @ NEETSDKASU

def chk(h, g, c, s, r, cQ)
    if h.include? s
        return h[s] + c
    elsif !g.include?(s)
        n = s.to_i
        if n < cQ && n.prime?
            g[s] = c
            r << s
        end
    end
    0
end
    
def f(pp, qq)
    require 'prime'
    
    cQ = qq.to_i
    
    cp = 0
    cq = 0
    
    hp = {}
    hq = {}
    hp[pp] = cp
    hq[qq] = cq
    
    w1 = [pp]
    u1 = [qq]

    while !w1.empty? && !u1.empty?
        
        [[w1, hp, hq], [u1, hq, hp]].each do |r1, g, h|
            r2 = []
            r1.each do |s|
                c = g[s] + 1
                if s.size > 1
                    [s[1..-1], s[0..-2]].each do |ss|
                        next if ss[0] == '0'
                        a = chk h, g, c, ss, r2, cQ
                        return a if a > 0
                    end
                end
                9.times do |i|
                    ss = '123456789'[i] + s
                    a = chk h, g, c, ss, r2, cQ
                    return a if a > 0
                end
                4.times do |i|
                    ss = s + '1379'[i]
                    a = chk h, g, c, ss, r2, cQ
                    return a if a > 0
                end
            end
            r1.reject!{ true }.concat r2
        end
        
    end
    
    return -1

end


pp, qq = gets.strip.split

puts f(pp, qq)