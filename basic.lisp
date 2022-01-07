((LAMBDA (BASICINTERPRETER)
   (BASICINTERPRETER
     (QUOTE (
       (10   REM FIND AND PRINT PRIME NUMBERS BELOW N_MAX.   )
       (20   LET N_MAX = (1 1 1 1 1   1 1 1 1 1   1 1 1 1 1) )
       (30   LET I = (1 1)                                   )
       (40   IF N_MAX <= I THEN 200                          )
       (50       LET J = (1 1)                               )
       (60       IF I <= J THEN 110                          )
       (70           LET R = I % J                           )
       (80           IF R <= () THEN 120                     )
       (90           LET J = J + (1)                         )
       (100      GOTO 60                                     )
       (110      PRINT I                                     )
       (120      LET I = I + (1)                             )
       (130  GOTO 40                                         )
     ))))
 (QUOTE (LAMBDA (FULLLISTING)
          ((LAMBDA (EXECLINE CONSSTATE FINDLABELLISTING + - % <=
                    RESOLVEVAR VARENVPREPEND EVALEXPR PARSEIF APPEND)
            ((LAMBDA (STATE LOOP) (LOOP STATE LOOP))
              (CONSSTATE NIL FULLLISTING NIL)
              (QUOTE (LAMBDA (STATE LOOP)
                (COND
                  ((EQ NIL (CAR (CDR STATE))) (CAR (CDR (CDR STATE))))
                  ((QUOTE T) (LOOP (EXECLINE STATE) LOOP)))))))
           (QUOTE (LAMBDA (STATE)
                    ((LAMBDA (CURSTATEMENT VARENV CURLISTING OUTPUT)
                       ((LAMBDA (LABEL STATEMENT BODY)
                          (COND
                            ((EQ STATEMENT (QUOTE REM))
                             (CONSSTATE VARENV (CDR CURLISTING) OUTPUT))
                            ((EQ STATEMENT (QUOTE LET))
                             (CONSSTATE ((LAMBDA (VARNAME EXPR)
                                           (VARENVPREPEND
                                             VARNAME
                                             (EVALEXPR EXPR VARENV)
                                             VARENV))
                                         (CAR BODY) (CDR (CDR BODY)))
                                        (CDR CURLISTING)
                                        OUTPUT))
                            ((EQ STATEMENT (QUOTE IF))
                             (CONSSTATE VARENV
                                        ((LAMBDA (IFBODY)
                                           ((LAMBDA (N DESTLABEL)
                                             (COND
                                               ((EQ NIL N)
                                                 (CDR CURLISTING))
                                               ((QUOTE T)
                                                 (FINDLABELLISTING
                                                   DESTLABEL
                                                   FULLLISTING))))
                                           (EVALEXPR (CAR IFBODY) VARENV)
                                           (CDR IFBODY)))
                                         (PARSEIF BODY))
                                        OUTPUT))
                            ((EQ STATEMENT (QUOTE PRINT))
                             (CONSSTATE VARENV
                                        (CDR CURLISTING)
                                        (APPEND
                                          OUTPUT
                                          (CONS (EVALEXPR BODY VARENV) NIL))))
                            ((EQ STATEMENT (QUOTE GOTO))
                             (CONSSTATE VARENV
                                        (FINDLABELLISTING
                                          (CAR BODY) FULLLISTING)
                                        OUTPUT))))
                        (CAR CURSTATEMENT)
                        (CAR (CDR CURSTATEMENT))
                        (CDR (CDR CURSTATEMENT))))
                     (CAR (CAR (CDR STATE)))
                     (CAR STATE)
                     (CAR (CDR STATE))
                     (CAR (CDR (CDR STATE))))))
           (QUOTE (LAMBDA (VARENV CURLISTING OUTPUT)
                    (CONS VARENV (CONS CURLISTING (CONS OUTPUT ())))))
           (QUOTE (LAMBDA (LABEL CURLISTING)
                    (COND
                      ((EQ NIL CURLISTING) NIL)
                      ((EQ (CAR (CAR CURLISTING)) LABEL) CURLISTING)
                      ((QUOTE T) (FINDLABELLISTING LABEL (CDR CURLISTING))))))
           (QUOTE (LAMBDA (N M)
                    (COND
                      ((EQ NIL M) N)
                      ((QUOTE T) (+ (CONS (QUOTE 1) N) (CDR M))))))
           (QUOTE (LAMBDA (N M)
                    (COND
                      ((EQ NIL N) ())
                      ((EQ NIL M) N)
                      ((QUOTE T) (- (CDR N) (CDR M))))))
           (QUOTE (LAMBDA (N M)
                    (COND
                      ((<= N (- M (QUOTE (1)))) N)
                      ((QUOTE T) (% (- N M) M)))))
           (QUOTE (LAMBDA (N M)
                    (COND
                      ((EQ NIL (- N M)) (QUOTE (1)))
                      ((QUOTE T) NIL))))
           (QUOTE (LAMBDA (VARNAME VARENV)
                    (COND
                      ((EQ (ATOM VARNAME) NIL) VARNAME)
                      ((EQ NIL VARENV) ())
                      ((EQ VARNAME (CAR (CAR VARENV))) (CDR (CAR VARENV)))
                      ((QUOTE T) (RESOLVEVAR VARNAME (CDR VARENV))))))
           (QUOTE (LAMBDA (VARNAME N VARENV)
                    (CONS (CONS VARNAME N) VARENV)))
           (QUOTE (LAMBDA (EXPR VARENV)
                    (COND
                      ((EQ NIL (CDR EXPR)) (RESOLVEVAR (CAR EXPR) VARENV))
                      ((QUOTE T)
                        ((LAMBDA (X OPERAND Y)
                          (COND
                            ((EQ OPERAND (QUOTE +)) (+ X Y))
                            ((EQ OPERAND (QUOTE -)) (- X Y))
                            ((EQ OPERAND (QUOTE %)) (% X Y))
                            ((EQ OPERAND (QUOTE <=)) (<= X Y))))
                        (RESOLVEVAR (CAR EXPR) VARENV)
                        (CAR (CDR EXPR))
                        (RESOLVEVAR (CAR (CDR (CDR EXPR))) VARENV))))))
           (QUOTE (LAMBDA (BODY)
                    (COND
                      ((EQ (CAR (CDR BODY)) (QUOTE THEN))
                      (CONS (CONS (CAR BODY) NIL)
                            (CAR (CDR (CDR BODY)))))
                      ((QUOTE T)
                      (CONS
                        (CONS (CAR BODY)
                        (CONS (CAR (CDR BODY))
                        (CONS (CAR (CDR (CDR BODY)))
                              ())))
                        (CAR (CDR (CDR (CDR (CDR BODY))))))))))
           (QUOTE (LAMBDA (L ITEM)
                    (COND
                      ((EQ NIL L) ITEM)
                      ((QUOTE T) (CONS (CAR L) (APPEND (CDR L) ITEM))))))))))
