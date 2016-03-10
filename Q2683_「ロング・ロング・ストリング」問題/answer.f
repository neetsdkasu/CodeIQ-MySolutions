! Try CodeIQ
! author: Leonardone @ NEETSDKASU

PROGRAM CodeIQ
    REAL(8) :: m, b, t, x, y 
    INTEGER(8) :: ans

    READ(*,*) m
    b = 2.0
    t = 10000000000.0
    ans = -1
    DO WHILE (b <= t)
        x = FLOOR((b + t) / 2.0, 8)
        y = 1 + FLOOR(x * LOG10(x), 8) ! 間違っていたので修正
        IF (y < m) THEN
            b = x + 1.0
        ELSE IF (y > m) THEN
            t = x - 1.0
        ELSE
            ans = FLOOR(x, 8)
            EXIT
        END IF
    END DO
    PRINT '(I0)', ans
    
    STOP
END PROGRAM CodeIQ