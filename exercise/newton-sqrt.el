
(defun sqrt(x)
  (defun sqrt-rec(prev-guess guess x)
    (if (< 100
           (/ guess
              (distance guess prev-guess)))
        guess
      (sqrt-rec guess (improve guess x) x)))
  (defun distance(x y)
    (let ((e (- x y)))
      (if (> 0 e)
          (- e)
        e)))
  (defun improve(guess x)
    (average guess (/ x guess)))
  (defun average(x y)
    (/ (+ x y) 2))
  (sqrt-rec 0 1.0 x))
