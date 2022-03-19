(in-package #:lab-tests)

(defun get_coeffs()
    (format t "Введите коэффициенты (A, B, C) квадратного уравнения через пробел, затем нажмите Enter:")
    (terpri)
    (let 
        ((coeffs (list (get_num) (get_num) (get_num))))

        (if (nth 0 coeffs) 
            (if (nth 1 coeffs)
                (if (nth 2 coeffs)
                    coeffs
                )
            )
        ) 
    )
)

(defun get_num()
    (let ((x (get_expr))) (if (numberp x) x Nil))
)

(defun get_expr()
    (read)
)

; A*x^2 + B*x + C = 0
; А = 0 & B != 0 => решение одно: -C / B
; A = 0 & B = 0 & C != 0 => решений нет
; A = 0 & B = 0 & C = 0 => решение любое число
(defun solve(a b c)
    (let 
        ((d (sqrt (- (* b b) (* 4 a c))))) 

        (if (= a 0) 
            (if (= b 0)
                (if (= c 0)
                    'any
                    Nil
                )
                (/ (- c) b)
            )
            (if (= d 0)
            	(/ (- b) (* 2 a))
                 (list 
                     (/ (+ (- b) d) (* 2 a))
                     (/ (- (- b) d) (* 2 a))
                 )
            )
        )
    )
)

(defun fprint_quad_eq(res)
    (with-open-file 

        (f (get_filename)
            :direction :output
            :if-exists :supersede
            :if-does-not-exist :create
        )

        (if (null res) 
            (format f "Уравнение не имеет корней.~%")
            (if (equal res 'any)
                (format f "Корнем является любое действительное число.~%")
                (if (numberp res)
                    (fprint_num res f)
                    (fprint_two_nums res f)
                    ;(or (fprint_num (first res) f) (fprint_num (second res) f))
                )
            )
        )
    )
)

(defun fprint_two_nums(args f)
    (fprint_num (first args) f)
    (fprint_num (second args) f)
)

(defun fprint_num(arg f)
    (if (complexp arg)
        (format f "~,2f ~,2fi~%" (realpart arg) (imagpart arg))
        (format f "~,2f~%" arg)
    )
)

(defun get_filename()
    (format t "~%Введите название результирующего файла: ")
    (terpri)
    (read-line)
)

(defun start()
    (let 
        ((coeffs (get_coeffs)))
        
        (if (null coeffs) 
            (format t "~%Ошибка во время ввода коэффициентов.~%")
            (fprint_quad_eq (solve (nth 0 coeffs) (nth 1 coeffs) (nth 2 coeffs)))
        )
    )
)
