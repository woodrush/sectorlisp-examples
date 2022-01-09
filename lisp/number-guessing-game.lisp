((LAMBDA (
           MAIN GAMELOOP HELPMESSAGE - <= AND CMP PROGN ;;
         )
   ((LAMBDA () (QUOTE (THE GAME HAS FINISHED.)))
    (MAIN)))
 (QUOTE
   (LAMBDA ()
     (PROGN
       ;; (QUOTE - PROGN IS IMPLEMENTED BY PASSING EXPRESSIONS AS ARGUMENTS
       ;;          TO AN EMPTY LAMBDA, WHICH ARE EVALUATED SEQUENTIALLY.
       ;;        - NOTE THAT PROGN ALWAYS RETURNS NIL, NOT ITS FINAL VALUE.
       ;;          TO EXTRACT THE EVALUATION RESULTS WITHIN A SEQUENCE,
       ;;          CONS CAN BE USED INSTEAD OF PROGN.
       ;;        - SINCE ALL VALUES ARE DISCARDED INSIDE PROGN,
       ;;          COMMENTS CAN BE WRITTEN IN THIS MANNER.
       ;;        - NOTE THAT `;;` IS A VALID VARIABLE BOUND TO NIL.)
       (PRINT (QUOTE (LET'S PLAY A NUMBER GUESSING GAME.
                      I'M THINKING OF A CERTAIN NUMBER BETWEEN 1 AND 10.
                      SAY A NUMBER, AND I'LL TELL YOU IF IT'S
                      LESS THAN, GREATER THAN, OR EQUAL TO MY NUMBER.
                      CAN YOU GUESS WHICH NUMBER I'M THINKING OF?)))
       ;; (QUOTE - CALLING PRINT WITHOUT ARGUMENTS PRINTS A NEWLINE)
       (PRINT)
       (HELPMESSAGE)
       (GAMELOOP ())
       (PRINT)
       (PRINT (QUOTE (DO YOU WISH TO PLAY AGAIN? Y/N:)))
       (PRINT)
       (PRINT (QUOTE >))
       (COND ((EQ (READ) (QUOTE Y))
              (PROGN (PRINT (QUOTE (ALRIGHT!)))
                     ;; (QUOTE - INFINITE LOOPS ARE DONE USING RECURSION)
                     (MAIN)))
             ((QUOTE T)
              (PROGN (PRINT (QUOTE (THANK YOU FOR PLAYING!)))
                     (PRINT)))))))
 (QUOTE
   (LAMBDA (NUMTRIES)
     (PROGN
       (PRINT)
       (PRINT (QUOTE NUMBER>))
       ((LAMBDA (GUESS ANSWER NUMTRIES)
          (COND ((ATOM GUESS)
                 (PROGN
                   ;; (QUOTE - WHEN THE USER INPUTS AN ATOM, SHOW USAGE TEXT.
                   ;;          NUMTRIES DO NOT INCREASE IN THIS CASE.)
                   (HELPMESSAGE)
                   (GAMELOOP (CDR NUMTRIES))))
                ((EQ (QUOTE <) (CMP GUESS ANSWER))
                 (PROGN
                   (PRINT (QUOTE (YOUR GUESS IS LESS THAN MY NUMBER.)))
                   (GAMELOOP NUMTRIES)))
                ((EQ (QUOTE >) (CMP GUESS ANSWER))
                 (PROGN
                   (PRINT (QUOTE (YOUR GUESS IS GREATER THAN MY NUMBER.)))
                   (GAMELOOP NUMTRIES)))
                ((QUOTE T)
                 (PROGN
                   (PRINT (QUOTE (THAT'S RIGHT! MY NUMBER IS:)))
                   (PRINT ANSWER)
                   (PRINT)
                   (PRINT (QUOTE (YOU GUESSED CORRECTLY! CONGRATULATIONS!)))
                   (PRINT)
                   (PRINT (QUOTE (NUMBER OF TRIES:)))
                   (PRINT NUMTRIES)
                   (PRINT)))))
        (READ)
        (QUOTE (* * * * * * *))
        (CONS (QUOTE *) NUMTRIES)))))
 (QUOTE (LAMBDA ()
          (PRINT (QUOTE (PLEASE INPUT YOUR NUMBER IN UNARY.
                         FOR EXAMPLE, 1 IS (*), 3 IS (* * *), ETC.)))))
 (QUOTE (LAMBDA (N M)
          (COND ((EQ N NIL) NIL)
                ((EQ M NIL) N)
                ((QUOTE T) (- (CDR N) (CDR M))))))
 (QUOTE (LAMBDA (N M) (EQ NIL (- N M))))
 (QUOTE (LAMBDA (X Y) (COND (X Y) ((QUOTE T) NIL))))
 (QUOTE (LAMBDA (N M)
          (COND ((AND (<= N M) (<= M N)) (QUOTE ==))
                ((<= N M) (QUOTE <))
                ((<= M N) (QUOTE >)))))
 (QUOTE (LAMBDA () NIL))
 NIL)
(* * * * *)
*
(* * * * * * * *)
(* * * * * * *)
N
