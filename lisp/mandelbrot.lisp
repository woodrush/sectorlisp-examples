((LAMBDA (u0 umax fracbitsize
          _ addhalf _ addfull _ uaddnofc _ uaddnof _ umultnof
          _ take _ drop _ unegate _ ufixmult _ + _ - _ * _ 0>fix _ < _ > _ <<
          _ ismandel_iter _ ismandel
          _ iter_I _ iter_R _ mandelplot)
   ((LAMBDA () ())
    (mandelplot)))
 (QUOTE (0 0 0 0 0 0 0 0 0 0 0 0 0 0   0 0 0 0))
 (QUOTE (1 1 1 1 1 1 1 1 1 1 1 1 1 1   1 1 1 1))
 (QUOTE (1 1 1 1 1 1 1 1 1 1 1 1 1 1))
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
   ;; ufixmult : Unsigned fixed point multiplication
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
   (COND
     ((< X u0)
      (COND
        ((< Y u0)
         (ufixmult (unegate X) (unegate Y)))
        ((QUOTE T)
         (unegate (ufixmult (unegate X) Y)))))
     ((< Y u0)
      (unegate (ufixmult X (unegate Y))))
     ((QUOTE T)
      (ufixmult X Y)))))
 (QUOTE
   ;; 0>fix
 )
 (QUOTE (LAMBDA (X)
   (EQ (QUOTE 1) (CAR (drop (CDR u0) X)))))
 (QUOTE
   ;; <
 )
 (QUOTE (LAMBDA (X Y)
   (0>fix (- X Y))))
 (QUOTE
   ;; >
 )
 (QUOTE (LAMBDA (X Y)
   (< Y X)))
 (QUOTE
   ;; << : Shift X by Y_u bits, where Y_u is in unary.
   ;;      Note that since the bits are written in reverse order,
   ;;      This works as division and makes the input number smaller.
 )
 (QUOTE (LAMBDA (X Y_u)
   (+ (drop Y_u X) u0)))
 (QUOTE
   ;; ismandel_iter : c_r and c_i are referenced as dynamic variables from ismandel
 )
 (QUOTE (LAMBDA (z_r z_i N_iter_u)
   ((LAMBDA (z_r_sq z_i_sq z_r_z_i)
      (COND
        ((EQ NIL N_iter_u) (QUOTE T))
        ((< 4 (+ z_r_sq z_i_sq)) NIL)
        ((QUOTE T)
         (ismandel_iter
              (+ c_r (- z_r_sq z_i_sq))
              (+ c_i (+ z_r_z_i z_r_z_i))
              (CDR N_iter_u)))))
   (* z_r z_r)
   (* z_i z_i)
   (* z_r z_i)
   )))
 (QUOTE
   ;; ismandel
 )
 (QUOTE (LAMBDA (c_r c_i)
   (ismandel_iter u0 u0 (QUOTE (* * * *  * * * *  * * * *  * * * *)))))
 (QUOTE
   ;; iter_I
 )
 (QUOTE (LAMBDA (c_i)
   (COND
     ((> c_i c_i_max) NIL)
     ((QUOTE T)
      ((LAMBDA () ())
       (iter_R c_r_0)
       (PRINT)
       (iter_I (+ c_i delta_i)))))))
 (QUOTE
   ;; iter_R
 )
 (QUOTE (LAMBDA (c_r)
   (COND
     ((> c_r c_r_max) NIL)
     ((QUOTE T)
      ((LAMBDA () ())
       (PRINT (COND
                ((ismandel c_r c_i) (QUOTE *))
                ((QUOTE T) (QUOTE .))))
       (iter_R (+ c_r delta_r)))))))
 (QUOTE
   ;; mandelplot
 )
 (QUOTE (LAMBDA ()
   ((LAMBDA (c_r_0 c_i_0 c_r_max c_i_max delta_r delta_i 4)
      (iter_I c_i_0))
    (unegate (QUOTE (0 0 0 0 0 0 0 0 0 0 0 0 1 0   0 1 0 0)))
    (unegate (QUOTE (0 0 0 0 0 0 0 0 0 0 0 0 1 0   1 0 0 0)))
    (QUOTE (0 0 0 0 0 0 0 0 0 0 0 0 0 1   0 0 0 0))
    (QUOTE (0 0 0 0 0 0 0 0 0 0 0 0 1 0   1 0 0 0))
    (<< (QUOTE (0 0 0 0 0 0 0 0 0 0 0 0 0 0   1 0 0 0)) (QUOTE (* * * *)))
    (<< (QUOTE (0 0 0 0 0 0 0 0 0 0 0 0 0 0   0 1 0 0)) (QUOTE (* * * *)))
    (QUOTE (0 0 0 0 0 0 0 0 0 0 0 0 0 0   0 0 1 0)))
 ))
 )
