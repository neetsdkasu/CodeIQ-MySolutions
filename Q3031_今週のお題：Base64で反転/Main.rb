# Try CodeIQ
# author: Leonardone @ NEETSDKASU

require 'base64'
require 'set'

a =('a'..'z').to_a+('A'..'Z').to_a

cen = {}
flg = Set.new
tbl = {}

a.each do |ca|
    a.each do |cb|
        a.each do |cc|
            s = ca + cb + cc
            b = Base64.decode64(Base64.encode64(s).reverse)
            if s == b
                r = s.each_char.to_a.uniq.sort * ''
                cen[r.size] = Hash.new(0) if !cen.include? r.size
                cen[r.size][r] += 1
            elsif b =~ /[a-zA-Z]{3}/
                next if flg.add?(s).nil?
                r = (s + b).each_char.to_a.uniq.sort * ''
                tbl[r.size] = Hash.new(0) if !tbl.include? r.size
                tbl[r.size][r] += 1
            end
        end
    end
end

N = gets.to_i

if N == 1
    puts cen[1].values.inject(:+)
    exit
end

res = {}

(1..N).each do |x|
    if cen.include? x
        res[x] = Hash.new(0) if !res.include? x
        res[x].update(cen[x]) {|k,v1,v2| v1+v2}
    end
    if tbl.include? x
        res[x] = Hash.new(0) if !res.include? x
        res[x].update(tbl[x]) {|k,v1,v2| v1+v2}
    end
end

def upd(tmp, resi, xxx, j)
    return if !xxx.include? j
    xxx[j].each do |kc, vc|
        resi.each do |kr, vr|
            s = (kc + kr).each_char.to_a.uniq.sort * ''
            next if s.size > N
            tmp[s.size] = Hash.new(0) if !tmp.include? s.size
            tmp[s.size][s] += vc * vr
        end
    end
end

[0, (N / 2 - 1)].max.times do
    tmp = {}
    (1..N).each do |i|
        next if !res.include? i
        (1..N).each do |j|
            upd tmp, res[i], cen, j
            upd tmp, res[i], tbl, j
        end
    end
    res = tmp
end

if N.odd?
    tmp = {}
    (1..N).each do |i|
        next if !res.include? i
        (1..N).each do |j|
            upd tmp, res[i], cen, j
        end
    end
    res = tmp
end

if res.include? N
    puts res[N].values.inject(:+)
else
    puts 0
end