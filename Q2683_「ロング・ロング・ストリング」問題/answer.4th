\ Try CodeIQ
\ author: Leonardone @ NEETSDKASU

: ceil ( f -- f ) fdup floor fswap fover f> if 1e f+ endif ;
: f2dup ( f1 f2 -- f1 f2 f1 f2 )  fover fover ;
: f2drop ( f1 f2 -- ) fdrop fdrop ;

: _f ( F: n -- F: x ) 
    fdup flog f* floor 1e f+ \ 間違っていたので修正
;

: _h ( F: m F: b F: t -- F: x ) recursive
    f2dup
    f>
    if
        fdrop f2drop -1e
    else
        f2dup f+ 2e f/ floor fdup _f 4 fpick \ m b t x y m
        f2dup
        f< if
            f2drop 1e f+     \ m b t x+1
            frot fdrop fswap \ m x+1 t
            recurse
        else
            f> if
                1e f-       \ m b t x-1
                fswap fdrop \ m b x-1
                recurse
            else
                fnip fnip fnip
            endif
        endif
    endif
;

: _g ( F: m -- F: x )
    2e 1e+10 _h
;

: solve ( F: m -- )
    _g f>d d.
;

( ********************************************* )
: new-str ( size -- straddr size )
    chars dup allocate drop swap
;

: gets ( straddr size -- straddr strlen )
    over swap stdin read-line 2drop
;

( ********************************************* )
: main ( -- )
    255 new-str over swap
    gets >float drop
    solve
    free drop
;

main

\ End of Source