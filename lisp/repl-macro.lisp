((LAMBDA (ASSOC EVCON PAIRLIS EVLIS APPLY EVAL)
   (EVAL 
     (QUOTE 
       ((lambda (loop) (loop loop))
          (quote (lambda (loop)
            ((lambda () ())
             (print (quote REPL>))
             ((lambda (input)
                ((lambda () ())
                 (print (quote =>))
                 (print (eval input))
                 (print)))
              (read))
             (loop loop))))))
     ()))
 (QUOTE (LAMBDA (X Y)
          (COND ((EQ Y ()) ())
                ((EQ X (CAR (CAR Y)))
                       (CDR (CAR Y)))
                ((QUOTE T)
                 (ASSOC X (CDR Y))))))
 (QUOTE (LAMBDA (C A)
          (COND ((EVAL (CAR (CAR C)) A)
                 (EVAL (CAR (CDR (CAR C))) A))
                ((QUOTE T) (EVCON (CDR C) A)))))
 (QUOTE (LAMBDA (X Y A)
          (COND ((EQ X ()) A)
                ((QUOTE T) (CONS (CONS (CAR X) (CAR Y))
                                 (PAIRLIS (CDR X) (CDR Y) A))))))
 (QUOTE (LAMBDA (M A)
          (COND ((EQ M ()) ())
                ((QUOTE T) (CONS (EVAL (CAR M) A)
                                 (EVLIS (CDR M) A))))))
 (QUOTE (LAMBDA (FN XRAW A)
          (COND
            ((ATOM FN)
               (COND ((EQ FN (QUOTE car))  (CAR  (EVAL (CAR XRAW) A)))
                     ((EQ FN (QUOTE cdr))  (CDR  (EVAL (CAR XRAW) A)))
                     ((EQ FN (QUOTE atom)) (ATOM (EVAL (CAR XRAW) A)))
                     ((EQ FN (QUOTE eval)) (EVAL (EVAL (CAR XRAW) A) A))
                     ((EQ FN (QUOTE cons)) (CONS (EVAL (CAR XRAW) A) (EVAL (CAR (CDR XRAW)) A)))
                     ((EQ FN (QUOTE eq))   (EQ   (EVAL (CAR XRAW) A) (EVAL (CAR (CDR XRAW)) A)))
                     ((EQ FN (QUOTE read)) (READ))
                     ((EQ FN (QUOTE print))
                      (COND
                        ((EQ NIL XRAW) (PRINT))
                        ((QUOTE T) (PRINT (EVAL (CAR XRAW) A)))))
                     ((QUOTE T) (APPLY (EVAL FN A) XRAW A))))
            ((EQ (CAR FN) (QUOTE lambda))
             (EVAL (CAR (CDR (CDR FN)))
                   (PAIRLIS (CAR (CDR FN)) (EVLIS XRAW A) A)))
            ((EQ (CAR FN) (QUOTE macro))
             (EVAL (EVAL (CAR (CDR (CDR FN)))
                   (PAIRLIS (CAR (CDR FN)) XRAW A)) A)))))
 (QUOTE (LAMBDA (E A)
          (COND
            ((ATOM E) (ASSOC E A))
            ((ATOM (CAR E))
             (COND ((EQ (CAR E) (QUOTE quote)) (CAR (CDR E)))
                   ((EQ (CAR E) (QUOTE cond)) (EVCON (CDR E) A))
                   ((QUOTE T) (APPLY (CAR E) (CDR E) A))))
            ((QUOTE T) (APPLY (CAR E) (CDR E) A))))))
(quote a)
((lambda (`)
        (` (a b (~ (cons (quote c) (cons (quote d) ()))))))
      (quote (macro (body)
        ((lambda (`-helper)
           (`-helper body))
          (quote (lambda (body)
            (cond
              ((atom body)
                 (cons (quote quote) (cons body ())))
              ((eq (quote ~) (car body))
                 (car (cdr body)))
              ((quote t)
                 (cons (quote cons)
                 (cons (`-helper (car body))
                 (cons (`-helper (cdr body))
                       ())))))))))))