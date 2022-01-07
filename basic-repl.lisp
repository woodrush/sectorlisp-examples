((LAMBDA (_ PRINTHELP _ LISTINGLOOP _ PRINTLISTING
          _ PROGN _ APPEND _ BASICINTERPRETER)
   (LISTINGLOOP NIL))

 (
   QUOTE ;; PRINTHELP
 )
 (QUOTE (LAMBDA () (PROGN (PRINT (QUOTE (PLEASE ENTER A
                                         BASIC PROGRAM LISTING,
                                         `LIST`, `RUN`, OR `DISCARD`.)))
                          (PRINT))))

 (
   QUOTE ;; LISTINGLOOP
 )
 (QUOTE (LAMBDA (LISTING)
          (PROGN
            (COND ((EQ NIL LISTING) (PRINTHELP)) ((QUOTE T) NIL))
            (PRINT (QUOTE BASIC>))
            ((LAMBDA (INPUT)
               (COND ((EQ (QUOTE LIST) INPUT)
                      (PROGN (PRINTLISTING LISTING)
                             (LISTINGLOOP LISTING)))
                     ((EQ (QUOTE RUN) INPUT)
                      (PROGN (COND ((EQ NIL LISTING) NIL)
                                   ((QUOTE T) (BASICINTERPRETER LISTING)))
                             (LISTINGLOOP LISTING)))
                     ((EQ (QUOTE DISCARD) INPUT) (LISTINGLOOP NIL))
                     ((ATOM INPUT)
                      (PROGN (PRINTHELP)
                             (LISTINGLOOP LISTING)))
                     ((QUOTE T)
                      (LISTINGLOOP (APPEND LISTING (CONS INPUT NIL))))))
             (READ)))))

 (
   QUOTE ;; PRINTLISTING
 )
 (QUOTE (LAMBDA (LISTING)
          (COND ((EQ NIL LISTING) NIL)
                ((QUOTE T)
                 (PROGN (PRINT (CAR LISTING))
                        (PRINT)
                        (PRINTLISTING (CDR LISTING)))))))

 (
   QUOTE ;; PROGN
 )
 (QUOTE (LAMBDA () NIL))

 (
   QUOTE ;; APPEND
 )
 (QUOTE (LAMBDA (L ITEM)
          (COND
          ((EQ NIL L) ITEM)
          ((QUOTE T) (CONS (CAR L) (APPEND (CDR L) ITEM))))))

 (
   QUOTE ;; BASICINTERPRETER
 )
 (QUOTE (LAMBDA (FULLLISTING)
          ((LAMBDA (_ EXECLINE _ CONSSTATE _ FINDLABELLISTING _ + - % _ <=
                    _ RESOLVEVAR _ VARENVPREPEND _ EVALEXPR _ PARSEIF)
            ((LAMBDA (STATE LOOP) (LOOP STATE LOOP))
              (CONSSTATE NIL FULLLISTING NIL)
              (QUOTE (LAMBDA (STATE LOOP)
                (COND
                  ((EQ NIL (CAR (CDR STATE))) (CAR (CDR (CDR STATE))))
                  ((QUOTE T) (LOOP (EXECLINE STATE) LOOP)))))))

           (
             QUOTE ;; EXECLINE : STATE -> STATE: EXECUTE LINE
                   ;; AND RETURN THE NEXT STATE
           )
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
                                          (CAR (CONS ((LAMBDA (X)
                                                        (CAR
                                                          (CONS (CONS X NIL)
                                                                (PRINT X))))
                                                      (EVALEXPR BODY VARENV))
                                                     (PRINT))
                                                NIL))))
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

           (
             QUOTE ;; CONSSTATE : VARENV, CURLISTING, OUTPUT -> STATE
           )
           (QUOTE (LAMBDA (VARENV CURLISTING OUTPUT)
                    (CONS VARENV (CONS CURLISTING (CONS OUTPUT ())))))

           (
             QUOTE ;; FINDLABELLISTING : LABEL, FULLLISTING -> CURLISTING
           )
           (QUOTE (LAMBDA (LABEL CURLISTING)
                    (COND
                      ((EQ NIL CURLISTING) NIL)
                      ((EQ (CAR (CAR CURLISTING)) LABEL) CURLISTING)
                      ((QUOTE T) (FINDLABELLISTING LABEL (CDR CURLISTING))))))

           (QUOTE ARITHMETIC)
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

           (
             QUOTE ;; <=: INT -> INT: LESS THAN
           )
           (QUOTE (LAMBDA (N M)
                    (COND
                      ((EQ NIL (- N M)) (QUOTE (1)))
                      ((QUOTE T) NIL))))

           (
             QUOTE ;; RESOLVEVAR : VAR/INT, VARENV -> INT:
                   ;; RESOLVE THE INTEGER VALUE OF A VARIABLE
           )
           (QUOTE (LAMBDA (VARNAME VARENV)
                    (COND
                      ((EQ (ATOM VARNAME) NIL) VARNAME)
                      ((EQ NIL VARENV) ())
                      ((EQ VARNAME (CAR (CAR VARENV))) (CDR (CAR VARENV)))
                      ((QUOTE T) (RESOLVEVAR VARNAME (CDR VARENV))))))

           (
             QUOTE ;; VARENVPREPEND : VARNAME, INT, VARENV -> VARENV: 
                   ;; UPDATE THE VARIABLE VALUE IN THE VARENV
           )
           (QUOTE (LAMBDA (VARNAME N VARENV)
                    (CONS (CONS VARNAME N) VARENV)))

           (
             QUOTE ;; EVALEXPR : EXPR, VARENV -> INT:
                   ;; EVALUATE INTEGER EXPRESSIONS.
                   ;; EXPR IS A LIST EVEN IF THE INPUT IS A
                   ;; SINGLE VARIABLE OR AN INTEGER LITERAL.
           )
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

           (
             QUOTE ;; PARSEIF : PARSES `IF` STATEMENTS
           )
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
                        (CAR (CDR (CDR (CDR (CDR BODY))))))))))))))
(10   REM FIND AND PRINT PRIME NUMBERS BELOW N_MAX.   )
(20   LET N_MAX = (1 1 1 1 1   1 1 1 1 1   1 1 1 1 1) )
LIST
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
LIST
RUN
