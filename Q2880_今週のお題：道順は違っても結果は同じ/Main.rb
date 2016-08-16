#!ruby
# Try CodeIQ
# author: Leonardone @ NEETSDKASU

R = gets.strip

$t = 38.times.map { [0] * 38 }
h = []

x = 18
y = 18
$t[y][x] = 1
h << [y, x]

R.each_char do |ch|
    case ch
    when 'U'
        y -= 1
    when 'L'
        x -= 1
    when 'D'
        y += 1
    when 'R'
        x += 1
    end
    $t[y][x] = 1
    h << [y, x]
end

def seek(y, x, d)
    return 0 if $t[y][x] != 1
    return 0 if !(0...38).include? y
    return 0 if !(0...38).include? x
    return 1 if d == R.size
    $t[y][x] = 2
    c = 0
    [[0,1],[0,-1],[1,0],[-1,0]].each do |dy, dx|
        c += seek y + dy, x + dx, d + 1
    end
    $t[y][x] = 1
    return c
end

c = 0
h.each do |y, x|
    c += seek y, x, 0
end

p c