(setf *random-state* (make-random-state t))

(defun roll_dices()
    (list (+ (random 6) 1) (+ (random 6) 1)))

(defun sum_points(dices)
    (+ (first dices) (second dices)))

(defun abs_winnerp(dices)
    (or (= (sum_points dices) 7) (= (sum_points dices) 11)))

(defun rerollp(dices)
    (or (= (sum_points dices) 2) (= (sum_points dices) 12)))

(defun define_winner(fdices sdices)
    (let* ((fsum (sum_points fdices))
           (ssum (sum_points sdices)))

        (cond 
            ((abs_winnerp fdices) 1)
            ((abs_winnerp sdices) 2)
            (T 
                (cond 
                    ((= fsum ssum) 0)
                    ((> fsum ssum) 1)
                    (T 2)
                )
            )
        )
    )
)

(defun play()

    (let* ((fdices (roll_dices))
           (sdices (roll_dices)))
        
        (print 'Player_1) 
        (print fdices)
        (terpri)

        (print 'Check_reroll)

        (if (rerollp fdices) (progn (setq fdices (roll_dices)) (print 'True.)(print 'Player_1)(print fdices) (terpri)) (progn (print 'False.) (terpri)))

        (print 'Player_2) 
        (print sdices)
        (terpri)
        
        (let ((res (define_winner fdices sdices)))
            (cond 
                ((= res 0) (print 'Draw.))
                ((= res 1) (print 'Player_1_WIN))
                (T (print 'Player_2_WIN))
            )
        )
        (terpri)
    )   
)

(play)
