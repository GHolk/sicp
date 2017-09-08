

(define counter
  (let ((i 0))
    (lambda ()
        (set! i (+ 1 i)))))

(define (sine angle)
  (define (cube x) (* x x x))
  (define (p x) (counter) (- (* 3 x)  (* 4 (cube x))))
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0)))))

