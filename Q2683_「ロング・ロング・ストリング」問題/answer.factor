! Try CodeIQ
! author: Leonardone @ NEETSDKASU

USING: kernel combinators
       io prettyprint
       math math.parser math.functions ;
IN: codeiq

: f ( n -- x ) dup log10 * floor 1 + ; ! 間違っていたので修正
: g ( m -- x )
    : h ( m b t -- x )
        2dup > ! b > t
        [ 3drop -1 ]
        [ 3dup + 2 / ceiling dup f swapd ! m b t x m y
          2dup
          { ! m <=> y
          { [ < ] [ 2drop 1 - swap drop h ] }
          { [ > ] [ 1 + -rot nip h ] }
                  [ nip 2nip ]
          } cond
        ]
        if ;
    2 10 10^ h ;

readln string>number g .