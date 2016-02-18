# Try CodeIQ
# author: Leonardone @ NEETSDKASU
# ==================================================================

solve <- function() {
    k <- 7
    ub <- as.integer(10 ^ k)
    fmt <- paste("%0", toString(k), "d", sep="")
    n <- as.integer(readLines("stdin")[1])
    a <- array(vector("integer", 4000))
    aa <- a
    b <- a
    bb <- b
    fa <- function(x,y) {
        a[x] <<- a[x] + b[y]
        aa[x] <<- aa[x] + bb[y]
        if (a[x] > ub) { aa[x] <<- aa[x] + 1; a[x] <<- a[x] - ub }
    }
    fb <- function(x,y) {
        b[x] <<- b[x] + a[y]
        bb[x] <<- bb[x] + aa[y]
        if (b[x] > ub) { bb[x] <<- bb[x] + 1; b[x] <<- b[x] - ub }
    }
    a[2000] = 1
    for ( i in 1:n )
        if (i %% 2 == 0) 
            for ( j in 1:4000 ) {
                if (b[j] == 0) next
                fa(j + i, j)
                fa(j - i, j)
                b[j] = 0
                bb[j] = 0
            }
        else 
            for ( j in 1:4000 ) {
                if (a[j] == 0) next
                fb(j + i, j)
                fb(j - i, j)
                a[j] = 0
                aa[j] = 0
            }
    pr <- function(x,y) if (x > 0) cat(x, sprintf(fmt, y), sep="") else cat(y)
    if (n %% 2 == 0)
        pr(aa[2000],a[2000])
    else
        pr(bb[2000],b[2000])
    cat("\n")
}

solve()
