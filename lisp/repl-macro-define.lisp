((LAMBDA (ASSOC EVCON PAIRLIS EVLIS APPLY TAIL EVAL)
   (CDR (EVAL
          (QUOTE 
            ((lambda (loop) (loop loop))
               (quote
                 (lambda (loop)
                   (print (quote REPL>))
                   (define input (read))
                   (print (quote =>))
                   (print (eval input))
                   (print)
                   (print)
                   (loop loop)))))
          ())))
 (QUOTE (LAMBDA (X Y)
          (COND ((EQ Y ()) ())
                ((EQ X (CAR (CAR Y)))
                       (CDR (CAR Y)))
                ((QUOTE T)
                 (ASSOC X (CDR Y))))))
 (QUOTE (LAMBDA (C A)
          ((LAMBDA (S)
             (COND ((CAR S)
                    (EVAL (CAR (CDR (CAR C))) (CDR S)))
                   ((QUOTE T) (EVCON (CDR C) (CDR S)))))
           (EVAL (CAR (CAR C)) A))))
 (QUOTE (LAMBDA (X Y A)
          (COND ((EQ X ()) A)
                ((QUOTE T) (CONS (CONS (CAR X) (CAR Y))
                                 (PAIRLIS (CDR X) (CDR Y) A))))))
 (QUOTE (LAMBDA (M A)
          (COND ((EQ M ()) (CONS () A))
                ((QUOTE T)
                 ((LAMBDA (NEWSTATE)
                    ((LAMBDA (NEWEVLISSTATE)
                       (CONS (CONS (CAR NEWSTATE) (CAR NEWEVLISSTATE))
                             (CDR NEWEVLISSTATE)))
                     (EVLIS (CDR M) (CDR NEWSTATE))))
                  (EVAL (CAR M) A))))))
 (QUOTE (LAMBDA (FN XRAW A)
          (COND
            ((ATOM FN)
               (COND ((EQ FN (QUOTE car))
                      ((LAMBDA (S) (CONS (CAR (CAR S)) (CDR S)))
                       (EVAL (CAR XRAW) A)))
                     ((EQ FN (QUOTE cdr))
                      ((LAMBDA (S) (CONS (CDR (CAR S)) (CDR S)))
                       (EVAL (CAR XRAW) A)))
                     ((EQ FN (QUOTE atom)) 
                      ((LAMBDA (S) (CONS (ATOM (CAR S)) (CDR S)))
                       (EVAL (CAR XRAW) A)))
                     ((EQ FN (QUOTE eval))
                      ((LAMBDA (S)
                         ((LAMBDA (U)
                            (CONS (CAR U) (CDR U)))
                          (EVAL (CAR S) (CDR S))))
                       (EVAL (CAR XRAW) A)))
                     ((EQ FN (QUOTE cons))
                      ((LAMBDA (CARS)
                         ((LAMBDA (CDRS)
                            (CONS (CONS (CAR CARS) (CAR CDRS))
                                  (CDR CDRS)))
                          (EVAL (CAR (CDR XRAW)) (CDR CARS))))
                       (EVAL (CAR XRAW) A)))
                     ((EQ FN (QUOTE eq))
                      ((LAMBDA (CARS)
                         ((LAMBDA (CDRS)
                            (CONS (EQ (CAR CARS) (CAR CDRS))
                                  (CDR CDRS)))
                          (EVAL (CAR (CDR XRAW)) (CDR CARS))))
                       (EVAL (CAR XRAW) A)))
                     ((EQ FN (QUOTE read)) (CONS (READ) A))
                     ((EQ FN (QUOTE print))
                      (COND
                        ((EQ NIL XRAW) ((LAMBDA (X Y) Y) (PRINT) (CONS NIL A)))
                        ((QUOTE T)
                         ((LAMBDA (S)
                            ((LAMBDA (_ X) X)
                             (PRINT (CAR S))
                             (CONS (CAR S) (CDR S))))
                          (EVAL (CAR XRAW) A)))))
                     ((QUOTE T)
                      ((LAMBDA (NEWSTATE)
                         (APPLY (CAR NEWSTATE) XRAW (CDR NEWSTATE)))
                       (EVAL FN A)))))
            ((EQ (CAR FN) (QUOTE lambda))
             (CONS
               (TAIL (CAR (EVLIS (CDR (CDR FN))
                                 ((LAMBDA (NEWEVLISSTATE)
                                    (PAIRLIS (CAR (CDR FN))
                                             (CAR NEWEVLISSTATE)
                                             (CDR NEWEVLISSTATE)))
                                  (EVLIS XRAW A)))))
               A))
            ((EQ (CAR FN) (QUOTE macro))
             (EVAL (TAIL (CAR (EVLIS (CDR (CDR FN))
                                     (PAIRLIS (CAR (CDR FN)) XRAW A))))
                   A)))))
 (QUOTE (LAMBDA (X)
          (COND
            ((EQ () (CDR X)) (CAR X))
            ((QUOTE T) (TAIL (CDR X))))))
 (QUOTE (LAMBDA (E A)
          (COND
            ((ATOM E) (CONS (ASSOC E A) A))
            ((ATOM (CAR E))
             (COND ((EQ (CAR E) (QUOTE quote)) (CONS (CAR (CDR E)) A))
                   ((EQ (CAR E) (QUOTE cond)) (EVCON (CDR E) A))
                   ((EQ (CAR E) (QUOTE define))
                    ((LAMBDA (NEWSTATE)
                       (CONS (CAR NEWSTATE)
                             (PAIRLIS (CONS (CAR (CDR E)) ())
                                 (CONS (CAR NEWSTATE) ())
                                 (CDR NEWSTATE))))
                     (EVAL (CAR (CDR (CDR E))) A)))
                   ((EQ (CAR E) (QUOTE progn))
                    ((LAMBDA (STATE)
                        (CONS (TAIL (CAR STATE)) (CDR STATE)))
                     (EVLIS (CDR E) A)))
                   ((QUOTE T) (APPLY (CAR E) (CDR E) A))))
            ((QUOTE T) (APPLY (CAR E) (CDR E) A))))))
(define ` (quote (macro (body)
  (define `-helper (quote (lambda (body)
    (cond
      ((atom body)
         (cons (quote quote) (cons body ())))
      ((eq (quote ~) (car body))
         (car (cdr body)))
      ((quote t)
         (cons (quote cons)
         (cons (`-helper (car body))
         (cons (`-helper (cdr body))
               ()))))))))
  (`-helper body))))
(` (a b (~ (quote c))))
(define x (quote a))
x
(define defmacro (quote (macro (name vars body)
  (` (define (~ name) (quote (macro (~ vars) (~ body))))))))
(defmacro repquote (x)
  (` (quote ((~ x) (~ x)))))
(repquote (1 2 3))