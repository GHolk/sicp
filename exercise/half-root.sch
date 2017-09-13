
(define (search f negative-point positive-point allow-error)
  (define (average x y)
    (/ (+ x y) 2))
  (define (positive? x) (> x 0))
  (define (negative? x) (< x 0))
  (define (close-enough? x y)
      (> allow-error (abs (- x y))))
  (define (iter negative-point positive-point)
    (let ((midpoint (average negative-point positive-point)))
      (if (close-enough? negative-point positive-point)
          midpoint
          (let ((test-value (f midpoint)))
            (cond ((positive? test-value)
                   (iter negative-point midpoint))
                  ((negative? test-value)
                   (iter midpoint positive-point))
                  (else midpoint))))))
  (iter negative-point positive-point))

(define (fixed-point f first-guess test)
  (define (try guess)
    (let ((next (f guess)))
      (if (test guess next)
          next
          (try next))))
  (try first-guess))

;; golden ratio
;; x = 1 + 1/x
(define (golden-ratio allow-error)
  (fixed-point
   (lambda (x)
     (+ 1 (/ 1 x)))
   1.0
   (lambda (prev next)
     (> allow-error
        (abs (- next prev))))))

(define (close-enough tolerance)
  (lambda (x y)
    (> tolerance
       (abs (- x y)))))
   
(define (square-root allow-error)
  (fixed-point
   (lambda (x)
     (display x) (newline)
     (/ (log 1000)
        (log x)))
   3.0
   (close-enough allow-error)))

(define (cont-frac upper lower term)
  (define (recur i)
    (if (= i term)
        (/ (upper i)
           (lower i))
        (/ (upper i)
           (+ (lower i)
              (recur (+ i 1))))))
  (define (iter i prev-lower product)
    "no first prev-lower detect, cannot use."
    (if (= i term)
        product
        (let ((current-lower (lower i)))
          (iter (+ i 1)
                (/ (* product prev-lower)
                   (+ prev-lower
                      (/ (upper i)
                         current-lower)))))))
  (recur 1))

(define (tan-cf x k)
  (cont-frac
   (lambda (i)
     (if (= i 1)
         x
         (- (square x))))
   (lambda (i)
     (- (* i 2) 1))
   k))
