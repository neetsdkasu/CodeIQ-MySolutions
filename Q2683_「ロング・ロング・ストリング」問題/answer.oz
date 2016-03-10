% Try CodeIQ
% author: Leonardone @ NEETSDKASU

functor
import
	Application
	System
	Open

define
	fun {F N}
		1.0 + {Float.floor N * {Float.log N} / {Float.log 10.0}}
	end
	fun {H B T M}
		if B > T then
			~1.0
		else
			local X Y in
				X = {Float.floor (B + T) / 2.0}
				Y = {F X}
				if Y < M then
					{H X + 1.0 T M}
				elseif Y > M then
					{H B X - 1.0 M}
				else
					X
				end
			end
		end
	end
	fun {G M}
		{H 2.0 1.0e10 M}
	end
	local Z S M in
		Z = {New Open.file init(name:stdin flags:[read])}
		{Z read(list:S)}
		M = {Int.toFloat {String.toInt S}}
		{System.showInfo {Float.toInt {G M}}}
	end
	{Application.exit 0}
end