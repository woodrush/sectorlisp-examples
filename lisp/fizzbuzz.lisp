((LAMBDA (- % <= NMAX 15 5 3)
    ((LAMBDA (LOOP) (LOOP LOOP (QUOTE (*))))
     (QUOTE (LAMBDA (LOOP N)
              (COND
                ((<= NMAX (- N (QUOTE (*)))) NIL)
                ((QUOTE T)
                 (CONS
                   (COND
                     ((EQ NIL (% N 15)) (QUOTE (FIZZBUZZ)))
                     ((EQ NIL (% N 5)) (QUOTE (BUZZ)))
                     ((EQ NIL (% N 3)) (QUOTE (FIZZ)))
                     ((QUOTE T) N))
                   (LOOP LOOP (CONS (QUOTE *) N)))))))))
 (QUOTE (LAMBDA (N M)
         (COND
           ((EQ NIL N) ())
           ((EQ NIL M) N)
           ((QUOTE T) (- (CDR N) (CDR M))))))
 (QUOTE (LAMBDA (N M)
         (COND
           ((<= N (- M (QUOTE (*)))) N)
           ((QUOTE T) (% (- N M) M)))))
 (QUOTE (LAMBDA (N M) (EQ NIL (- N M))))
 (QUOTE (* * * * * * * * * *
         * * * * * * * * * *
         * * * * * * * * * *))
 (QUOTE (* * * * * * * * * *
         * * * * *))
 (QUOTE (* * * * *))
 (QUOTE (* * *)))
