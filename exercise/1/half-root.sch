
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

(define (average-damp f)
  (define (average x y) (/ (+ x y) 2))
  (lambda (x) (average x (f x))))

(define (my-sqrt x)
  (fixed-point
   (average-damp
    (lambda (y) (/ x y)))
   1.0
   (lambda (prev next)
     (let ((ratio-error (- 1 (/ prev
                                next))))
       (> 0.01 (abs ratio-error))))))

(define (my-cbrt x)
  (fixed-point
   (average-damp
    (lambda (y) (/ x y y)))
   1.0
   (lambda (prev next)
     (let ((ratio-error (- 1 (/ prev
                                next))))
       (> 0.01 (abs ratio-error))))))

(define (deriv f)
  (define dx 0.001)
  (lambda (x)
    (/ (- (f (+ x dx)) (f x))
       dx)))

(define (newtons-method g guess test)
  (define (newton-transform g)
    (lambda (x)
      (- x (/ (g x)
              ((deriv g) x)))))
  (fixed-point (newton-transform g) guess test))

(define (ratio-error ratio)
  (lambda (prev next)
    (let ((ratio-error (- 1 (/ prev
                               next))))
      (> ratio (abs ratio-error)))))

(define (cubic a b c)
  (lambda (x)
    (+ (expt x 3)
       (* a (expt x 2))
       (* b x)
       c)))

(define (double f)
  (lambda (x)
    (f (f x))))

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated f n)
  (define (iter i result)
    (if (= i n)
        result
        (iter (+ i 1) (f result))))
  (define (recur i x)
    (if (= i n)
        x
        (f (recur (+ i 1) x))))
  (lambda (x)
    (iter 1 x)))

(define (smooth f dx)
  (define (average3 a b c)
    (/ (+ a b c) 3.0))
  (lambda (x)
    (average3 (f (+ x dx))
              (f x)
              (f (- x dx)))))

(define (rand-f range length)
  (define (nth n list)
    (define (iter i remaind-list)
      (if (= i n)
          (car remaind-list)
          (iter (+ i 1)
                (cdr remaind-list))))
    (iter 0 list))
  (define rand-seq
    ((repeated (lambda (s)
                 (cons (random range) s))
               length)
     '()))
  (lambda (i)
    (nth (remainder i length)
         rand-seq)))

(let* ((rf (rand-f 1000 100))
       (srf (smooth rf 1))
       (ssrf (smooth srf 1)))
  (define (display-range f start end)
    (display (map f (seq start end)))
    (newline))
  (display-range rf 1 98)
  (display-range srf 2 97)
  (display-range ssrf 3 96))

(define (nth-root n damp-times try-times)
  (lambda (x)
    (fixed-point
     ((repeated average-damp damp-times)
      (lambda (y) (/ x (expt y (- n 1)))))
     1.0
     (let ((i 0))
       (lambda (prev next)
         (display (list prev next)) (newline)
         (< try-times
            (set! i (+ i 1))))))))


(define (iterative-improve f test guess)
  (define (iter x)
    (if (test x)
        x
        (iter (f x))))
  (iter guess))

(define (iter-sqrt x)
  (iterative-improve
   (average-damp
    (lambda (y) (/ x y)))
   (lambda (y)
     (define allow-error 0.1)
     (> allow-error
        (abs (- (square y) x))))
   1.0))
