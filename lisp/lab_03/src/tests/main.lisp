(in-package #:lab-tests)

(def-suite all-tests
    :description "Suite tests for lab_03.")

(in-suite all-tests)

(defun test-lab ()
  (run! 'all-tests))
  
(defun check_real_eq6(a b)
  (<= (abs (- a b)) 1e6)
)

(defun check_complex_eq6(a b)
  (and (check_real_eq6 (realpart a) (realpart b)) (check_real_eq6 (imagpart a) (imagpart b)))
)
  
(test quas-eq-abcnz-tests
  "Set of tests for SOLVE func: all of the coeffs are not zero."
  (is (check_real_eq6 1 (solve 1 -2 1)))
  (is (equalp (list 6 2) (solve 1 -8 12)))
  (is (and (check_real_eq6 3/2 (nth 0 (solve 4 -8 3))) (check_real_eq6 3/2 (nth 1 (solve 4 -8 3)))))
  (is (and (check_real_eq6 (- 2 (sqrt 3)) (nth 0 (solve -1 4 -1))) (check_real_eq6 (- 2 (sqrt 3)) (nth 1 (solve -1 4 -1)))))
  (is (and (check_complex_eq6 #c(3/2 5/2) (nth 0 (solve 1 -3 8.5))) 
  	(check_complex_eq6 #c(3/2 -5/2) (nth 1 (solve 1 -3 8.5)))))
)

(test quad-eq-Az-Bnz-tests
  "Set of tests for SOLVE func: A is zero and B is not zero."
  (is (check_real_eq6 2    (solve 0 4 -8)))
  (is (check_real_eq6 -2   (solve 0 4 8)))
  (is (check_real_eq6 3/2  (solve 0 4 -6)))
  (is (check_real_eq6 -3/2 (solve 0 4 6)))
  (is (check_real_eq6 1/2  (solve 0 4 -2)))
  (is (check_real_eq6 -1/2 (solve 0 4 2)))
  (is (check_real_eq6 -2   (solve 0 4.5 9)))
  (is (check_real_eq6 0    (solve 0 4 0)))
)

(test quad-eq-Az-Bz-tests
  "Set of tests for SOLVE func: A and B is zero."
  (is (equal 'any (solve 0 0 0)))
  (is (not (solve 0 0 5)))
)
