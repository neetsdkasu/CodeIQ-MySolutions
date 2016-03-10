# Try CodeIQ
# author: Leonardone @ NEETSDKASU

set m [gets stdin]
set b 2
set t [expr {10 ** 10}]

while {$b <= $t} {
	set x [expr {floor(($b + $t) / 2.0)}]
	set y [expr {1 + floor($x * log10($x))}]
	if {$y < $m} {
		set b [expr {$x + 1}]
	} elseif {$y > $m} {
		set t [expr {$x - 1}]
	} else {
		puts [expr {int($x)}]
		exit
	}
}

puts -1