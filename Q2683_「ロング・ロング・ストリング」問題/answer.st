"Try CodeIQ"
"author: Leonardone @ NEETSDKASU"

|m b t x y a|

m := (stdin nextLine) asNumber.

b := 2.
t := 10 raisedTo: 10.

a := -1.

[ b <= t and: [ m ~= y ] ]
whileTrue:
[ x := ((b + t) / 2) floor.
  y := 1 + ((x * (x log)) floor).
  y < m
  ifTrue:
  [ b := x + 1. ]
  ifFalse:
  [ y > m
  	ifTrue: [ t := x - 1. ]
  	ifFalse: [ a := x. ].
  ].
].

a printNl.
