-- Try CodeIQ
-- author: Leonardone @ NEETSDKASU

function f(n)
	return 1 + math.floor(n * math.log10(n))
end

g = function (m)
		h = function (b, t)
				if b > t then return -1 end
				x = math.floor((b + t) / 2)
				y = f(x)
				if y > m then
					return h(b, x - 1)
				elseif y < m then
					return h(x + 1, t)
				else
					return x
				end
			end
		return h(2, 10 ^ 10)
	end

m = tonumber(io.read())
ans = g(m)
print(ans)
