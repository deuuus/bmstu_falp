(defun roll_dices()
    (list (+ (random 6) 1) (+ (random 6) 1)))

(defun sum_points(dices)
    (+ (first dices) (second dices)))

(defun is_absolute_winner(dices)
    (or (= (sum_points dices) 7) (= (sum_points dices) 11)))

(defun need_reroll(dices)
    (or (= (sum_points dices) 2) (= (sum_points dices) 12)))

(defun process(fdices sdices)
    (setq fsum (sum_points fdices))
    (setq ssum (sum_points sdices))

    (if (need_reroll fdices) (print (and (print 'Reroll_for_player_№1) (setq fdices (roll_dices)))))

    (if (is_absolute_winner fdices) 
        'Player_№1_win
        (if (is_absolute_winner sdices) 
            'Player_№2_win
            (if (> (sum_points sdices) (sum_points fdices)) 'Player_№2_win 'Player_№1_win)
        )
    )
)

(defun play()
    (print '=========Roll_dices=========)
    (setq fdices (roll_dices))
    (setq sdices (roll_dices))

    (print 'Player_№1) 
    (print fdices)
    (terpri)
    
    (print 'Player_№2) 
    (print sdices)
    (terpri)

    (print '=========Start_game=========)
    (print (process fdices sdices))
    (terpri)
    )

(play)
