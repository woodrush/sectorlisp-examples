((LAMBDA (_ U2DEC _ U2RDEC _ UDIGIT2DEC _ APPEND _ REVERSE
          _ + _ - _ * _ / _ % _ <= 15 10 5 3 1 DECSET)
    ((LAMBDA (NMAX LOOP) (LOOP LOOP 1))
     (* 15 10)
     (QUOTE (LAMBDA (LOOP N)
              (COND
                ((<= NMAX (- N 1)) NIL)
                ((QUOTE T)
                 (CONS
                   (COND
                     ((EQ NIL (% N 15)) (QUOTE (FIZZBUZZ)))
                     ((EQ NIL (% N 5)) (QUOTE (BUZZ)))
                     ((EQ NIL (% N 3)) (QUOTE (FIZZ)))
                     ((QUOTE T) (U2DEC N)))
                   (LOOP LOOP (+ N 1)))))))))
 (QUOTE
   ;; U2DEC
 )
 (QUOTE (LAMBDA (N)
          (REVERSE (U2RDEC N))))
 (QUOTE
   ;; U2RDEC
 )
 (QUOTE (LAMBDA (N)
          ((LAMBDA (N10)
             (COND
               ((EQ NIL N10) (CONS (UDIGIT2DEC N DECSET) NIL))
               ((QUOTE T) (CONS (UDIGIT2DEC (% N 10) DECSET) (U2RDEC N10)))))
           (/ N 10))))
 (QUOTE
   ;; UDIGIT2DEC
 )
 (QUOTE (LAMBDA (N DECSET)
          (COND
            ((EQ N NIL) (CAR DECSET))
            ((QUOTE T) (UDIGIT2DEC (CDR N) (CDR DECSET))))))
 (QUOTE
   ;; APPEND
 )
 (QUOTE (LAMBDA (L ITEM)
                    (COND
                      ((EQ NIL L) ITEM)
                      ((QUOTE T) (CONS (CAR L) (APPEND (CDR L) ITEM))))))
 (QUOTE
   ;; REVERSE
 )
 (QUOTE (LAMBDA (L)
           (COND
             ((EQ NIL L) NIL)
             ((QUOTE T) (APPEND (REVERSE (CDR L)) (CONS (CAR L) NIL))))))
 (QUOTE
   ;; +
 )
 (QUOTE (LAMBDA (N M)
         (COND
           ((EQ NIL M) N)
           ((QUOTE T) (+ (CONS (QUOTE *) N) (CDR M))))))
 (QUOTE
   ;; -
 )
 (QUOTE (LAMBDA (N M)
         (COND
           ((EQ NIL N) ())
           ((EQ NIL M) N)
           ((QUOTE T) (- (CDR N) (CDR M))))))
 (QUOTE
   ;; *
 )
 (QUOTE (LAMBDA (N M)
         (COND
           ((EQ NIL M) NIL)
           ((QUOTE T) (+ N (* N (CDR M)))))))
 (QUOTE
   ;; /
 )
 (QUOTE (LAMBDA (N M)
         (COND
           ((<= N (- M (QUOTE (*)))) NIL)
           ((QUOTE T) (CONS (QUOTE *) (/ (- N M) M))))))
 (QUOTE
   ;; %
 )
 (QUOTE (LAMBDA (N M)
         (COND
           ((<= N (- M (QUOTE (*)))) N)
           ((QUOTE T) (% (- N M) M)))))
 (QUOTE
   ;; <=
 )
 (QUOTE (LAMBDA (N M)
          (EQ NIL (- N M))))
 (QUOTE (* * * * * * * * * * * * * * *))
 (QUOTE (* * * * * * * * * *))
 (QUOTE (* * * * *))
 (QUOTE (* * *))
 (QUOTE (*))
 (QUOTE (0 1 2 3 4 5 6 7 8 9)))
