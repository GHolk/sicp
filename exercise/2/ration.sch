
(define (make-rat upper lower)
  (let ((g (gcd upper lower)))
    (if (> 0 lower)
        (cons (/ (- upper) g)
              (/ (- lower) g))
        (cons (/ upper g)
              (/ lower g)))))

(define (numer ration)
  (car ration))
(define (denom ration)
  (cdr ration))
(define (print-rat ration)
  (newline)
  (display (numer ration))
  (display "/")
  (display (denom ration)))

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

