((LAMBDA (DEBUG u0 umax fracbitsize 2 _ addhalf _ addfull _ uaddnofc _ uaddnof _ umultnof
          _ take _ drop _ unegate _ fixmult _ mandelstep _ + _ - _ *)
   ((LAMBDA () ())
    (PRINT (addhalf (QUOTE 0) (QUOTE 0)))
    (PRINT (addhalf (QUOTE 0) (QUOTE 1)))
    (PRINT (addhalf (QUOTE 1) (QUOTE 0)))
    (PRINT (addhalf (QUOTE 1) (QUOTE 1)))
    (PRINT)
    (PRINT (addfull (QUOTE 0) (QUOTE 0) (QUOTE 0)))
    (PRINT (addfull (QUOTE 1) (QUOTE 0) (QUOTE 0)))
    (PRINT (addfull (QUOTE 0) (QUOTE 1) (QUOTE 0)))
    (PRINT (addfull (QUOTE 1) (QUOTE 1) (QUOTE 0)))
    (PRINT (addfull (QUOTE 0) (QUOTE 0) (QUOTE 1)))
    (PRINT (addfull (QUOTE 1) (QUOTE 0) (QUOTE 1)))
    (PRINT (addfull (QUOTE 0) (QUOTE 1) (QUOTE 1)))
    (PRINT (addfull (QUOTE 1) (QUOTE 1) (QUOTE 1)))
    (PRINT)
    (PRINT (uaddnof (QUOTE (1 0 0 1)) (QUOTE (1 0 1 0))))(PRINT)
    (PRINT)
    (PRINT (umultnof (QUOTE (1 0 0 0 0 0 0 0)) (QUOTE (1 0 0 0 0 0 0 0))))(PRINT)
    (PRINT (umultnof (QUOTE (1 0 0 0 0 0 0 0)) (QUOTE (0 1 0 0 0 0 0 0))))(PRINT)
    (PRINT (umultnof (QUOTE (1 0 0 0 0 0 0 0)) (QUOTE (1 1 0 0 0 0 0 0))))(PRINT)
    (PRINT (umultnof (QUOTE (0 1 0 0 0 0 0 0)) (QUOTE (1 1 0 0 0 0 0 0))))(PRINT)
    (PRINT (umultnof (QUOTE (1 1 0 0 0 0 0 0)) (QUOTE (1 1 0 0 0 0 0 0))))(PRINT)
    (PRINT (umultnof (QUOTE (1 1 1 0 0 0 0 0)) (QUOTE (1 1 0 0 0 0 0 0))))(PRINT)
    (PRINT (umultnof (QUOTE (1 1 0 1 0 0 0 0)) (QUOTE (1 1 0 0 0 0 0 0))))(PRINT)
    (PRINT (umultnof (QUOTE (1 1 1 1 0 0 0 0)) (QUOTE (1 1 1 1 0 0 0 0))))(PRINT)
    (PRINT (umultnof (QUOTE (1 1 1 1 1 0 0 0)) (QUOTE (1 1 1 1 1 0 0 0))))(PRINT)
    (PRINT)
    (PRINT (unegate (QUOTE (1 1 1 1 1 0 0 0))))(PRINT)
    (PRINT (unegate (QUOTE (1 0 0 0 0 0 0 0))))(PRINT)
    (PRINT (unegate (QUOTE (0 1 0 0 0 0 0 0))))(PRINT)
    (PRINT)
    (PRINT (+ (QUOTE (0 0 0 0 0 0 0 0   1 0 0 0))
              (QUOTE (0 0 0 0 0 0 0 0   1 0 0 0))))(PRINT)
    (PRINT (+ (QUOTE (0 0 0 0 0 0 0 0   1 1 0 0))
              (QUOTE (0 0 0 0 0 0 0 0   1 0 0 0))))(PRINT)
    (PRINT (- (QUOTE (0 0 0 0 0 0 0 0   1 1 0 0))
              (QUOTE (0 0 0 0 0 0 0 0   1 0 0 0))))(PRINT)
    (PRINT (- (QUOTE (0 0 0 0 0 0 0 0   0 1 0 0))
              (QUOTE (0 0 0 0 0 0 0 0   1 0 0 0))))(PRINT)
    (PRINT (- (QUOTE (0 0 0 0 0 0 0 0   1 0 0 0))
              (QUOTE (0 0 0 0 0 0 0 0   1 0 0 0))))(PRINT)
    (PRINT (* (QUOTE (0 0 0 0 0 0 0 0   1 0 0 0))
              (QUOTE (0 0 0 0 0 0 0 0   1 0 0 0))))(PRINT)
    (PRINT (* (QUOTE (0 0 0 0 0 0 0 1   0 0 0 0))
              (QUOTE (0 0 0 0 0 0 0 0   1 0 0 0))))(PRINT)
    (PRINT (* (QUOTE (0 0 0 0 0 0 1 1   0 0 0 0))
              (QUOTE (0 0 0 0 0 0 0 0   1 1 1 0))))(PRINT)
    (PRINT (* (QUOTE (0 0 0 0 0 0 1 1   1 1 0 0))
              (QUOTE (0 0 0 0 0 0 0 0   1 1 1 0))))(PRINT)
    )
   
 )
 (QUOTE (LAMBDA (X) ((LAMBDA (_ _ _ _ Y) Y) (PRINT (QUOTE [)) (PRINT X) (PRINT (QUOTE ])) (PRINT) X)))
 (QUOTE (0 0 0 0 0 0 0 0   0 0 0 0))
 (QUOTE (1 1 1 1 1 1 1 1   1 1 1 1))
 (QUOTE (1 1 1 1 1 1 1 1))
 (QUOTE (0 0 0 0 0 0 0 0   0 1 0 0))
 (QUOTE
   ;; addhalf : Half adder
   ;;           Output is in reverse ordered binary (the msb is at the end)
   ;;           The same applies to the entire system
 )
 (QUOTE (LAMBDA (X Y)
   (COND
     ((EQ X (QUOTE 1))
      (COND
        ((EQ Y (QUOTE 1)) (CONS (QUOTE 0) (QUOTE 1)))
        ((QUOTE T) (CONS (QUOTE 1) (QUOTE 0)))))
     ((QUOTE T)
      (CONS Y (QUOTE 0))))))
 (QUOTE
   ;; addfull : Full adder
 )
 (QUOTE (LAMBDA (X Y C)
   ((LAMBDA (XY)
    (COND
      ((EQ (QUOTE 1) (CAR XY))
       (COND
         ((EQ (QUOTE 1) C) (CONS (QUOTE 0) (QUOTE 1)))
         ((QUOTE T) (CONS (QUOTE 1) (QUOTE 0)))))
      ((QUOTE T) (CONS C (CDR XY)))))
    (addhalf X Y))))
 (QUOTE
   ;; uaddnofc : Unsigned N-bit add with carry
 )
 (QUOTE (LAMBDA (X Y C)
   (COND
     ((EQ NIL X) Y)
     ((EQ NIL Y) X)
     ((QUOTE T)
      ((LAMBDA (XYC)
         (CONS (CAR XYC) (uaddnofc (CDR X) (CDR Y) (CDR XYC))))
       (addfull (CAR X) (CAR Y) C))))))
 (QUOTE
   ;; uaddnof : Unsigned N-bit add
 )
 (QUOTE (LAMBDA (X Y)
   (uaddnofc X Y (QUOTE 0))))
 (QUOTE
   ;; umultnof : Unsigned N-bit mult
 )
 (QUOTE (LAMBDA (X Y)
   (COND
     ((EQ NIL Y) u0)
     ((QUOTE T)
      (uaddnof (COND
               ((EQ (QUOTE 0) (CAR Y)) u0)
               ((QUOTE T) X))
             (umultnof (CONS (QUOTE 0) X) (CDR Y)))))))
 (QUOTE
   ;; take : Take a list of (len L) atoms from X
 )
 (QUOTE (LAMBDA (L X)
   (COND
     ((EQ NIL L) NIL)
     ((QUOTE T) (CONS (CAR X) (take (CDR L) (CDR X)))))))
 (QUOTE
   ;; drop : Drop the first (len L) atoms from X
 )
 (QUOTE (LAMBDA (L X)
   (COND
     ((EQ NIL X) NIL)
     ((EQ NIL L) X)
     ((QUOTE T) (drop (CDR L) (CDR X))))))
 (QUOTE
   ;; unegate : Two's complement of unsigned int
 )
 (QUOTE (LAMBDA (N)
   (take u0 (umultnof N umax))))
 (QUOTE
   ;; fixmult : Fixed-point multiplication
 )
 (QUOTE (LAMBDA (X Y)
   (take u0 (drop fracbitsize (umultnof X Y)))))
 (QUOTE
   ;; +
 )
 (QUOTE (LAMBDA (X Y)
   (take u0 (uaddnof X Y (QUOTE 0)))))
 (QUOTE
   ;; -
 )
 (QUOTE (LAMBDA (X Y)
   (take u0 (uaddnof X (unegate Y) (QUOTE 0)))))
 (QUOTE
   ;; *
 )
 (QUOTE (LAMBDA (X Y)
   (fixmult X Y)))

 (QUOTE
   ;; mandelstep
 )
 (QUOTE (LAMBDA (z_r z_i c_r c_i)
   (CONS (+ c_r (- (* z_r z_r) (* z_i z_i)))
         (+ c_i (* 2 (* z_r z_i))))))

 )
