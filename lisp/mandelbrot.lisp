((LAMBDA (DEBUG _ addh _ addf _ uaddn _ + - *)
   ((LAMBDA () ())
    (PRINT (addh (QUOTE 0) (QUOTE 0)))
    (PRINT (addh (QUOTE 0) (QUOTE 1)))
    (PRINT (addh (QUOTE 1) (QUOTE 0)))
    (PRINT (addh (QUOTE 1) (QUOTE 1)))
    (PRINT)
    (PRINT (addf (QUOTE 0) (QUOTE 0) (QUOTE 0)))
    (PRINT (addf (QUOTE 1) (QUOTE 0) (QUOTE 0)))
    (PRINT (addf (QUOTE 0) (QUOTE 1) (QUOTE 0)))
    (PRINT (addf (QUOTE 1) (QUOTE 1) (QUOTE 0)))
    (PRINT (addf (QUOTE 0) (QUOTE 0) (QUOTE 1)))
    (PRINT (addf (QUOTE 1) (QUOTE 0) (QUOTE 1)))
    (PRINT (addf (QUOTE 0) (QUOTE 1) (QUOTE 1)))
    (PRINT (addf (QUOTE 1) (QUOTE 1) (QUOTE 1)))
    (PRINT)
    (PRINT (+ (QUOTE (1 0 0 1)) (QUOTE (1 0 1 0)))))
   
   
 )
 (QUOTE (LAMBDA (X) ((LAMBDA (_ _ _ Y) Y) (PRINT (QUOTE [)) (PRINT X) (PRINT (QUOTE ])) X)))
 (QUOTE
   ;; addh : Half adder
   ;;        Output is in binary in reverse order (msb at the end)
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
   ;; addf : Full adder
 )
 (QUOTE (LAMBDA (X Y C)
   ((LAMBDA (XY)
    (COND
      ((EQ (QUOTE 1) (CAR XY))
       (COND
         ((EQ (QUOTE 1) C) (CONS (QUOTE 0) (QUOTE 1)))
         ((QUOTE T) (CONS (QUOTE 1) (QUOTE 0)))))
      ((QUOTE T) (CONS C (CDR XY)))))
    (addh X Y))))
 (QUOTE
   ;; uaddn : Unsigned N-bit add
 )
 (QUOTE (LAMBDA (X Y C)
   (COND
     ((EQ NIL X) NIL)
     ((QUOTE T)
      ((LAMBDA (XYC)
         (CONS (CAR XYC) (uaddn (CDR X) (CDR Y) (CDR XYC))))
       (addf (CAR X) (CAR Y) C))))))
 (QUOTE
   ;; +
 )
 (QUOTE (LAMBDA (X Y)
   (uaddn X Y (QUOTE 0))
 ))
 (QUOTE
   ;; -
 )
 (QUOTE (LAMBDA (X Y)
   ()
 ))
 (QUOTE
   ;; *
 )
 (QUOTE (LAMBDA (X Y)
   ()
 ))

 )
