
(define (sqrt x)
  (sqrt-rec 0 1.0 x improve-sqrt))
(define (sqrt-rec prev-guess guess x improve)
  (if (> 0.1 (distance prev-guess guess))
      guess
      (sqrt-rec guess (improve guess x) x improve)))
(define (improve-sqrt guess x)
  (average guess (/ x guess)))
(define (average x y)
  (/ (+ x y) 2))
(define (distance x y)
  (abs (- x y)))

(define (improve-cube-root guess x)
  (/ (+ (/ x (square guess))
        (* 2 guess))
     3))

(define (square x)
  (* x x))

(define (cube-root x)
  (sqrt-rec 0 1.0 x improve-cube-root))


(define (sqrt x)
  (define (sqrt-rec prev-guess guess)
    (if (> 0.1 (distance prev-guess guess))
        guess
        (sqrt-rec guess (improve guess))))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (average x y)
    (/ (+ x y) 2))
  (define (distance x y)
    (abs (- x y)))
  
  (sqrt-rec 1.0))
