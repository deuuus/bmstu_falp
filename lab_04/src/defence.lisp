(start)

(defun start()
    (get_num_of_fields)
    (get_num_of_seeds)
)


(defun get_num_of_fields()
    (terpri)
    (format t "Введите количество полей: ")
    (terpri)
    (get_num)
)

(defun get_num_of_seeds()
    (terpri)
    (format t "Введите количество зёрнышек: ")
    (terpri)
    (get_num)
)

(defun get_num()
    (let ((x (get_expr))) (if (numberp x) x Nil))
)

(defun get_expr()
    (read)
)

(defun solve()

)

(defun put_seeds(fields seeds)
    
)