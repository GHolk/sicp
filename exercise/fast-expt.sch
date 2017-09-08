(define (even? n) (= 0 (remainder n 2)))

(define (fast-expt n i)
  (display i) (newline)
  (cond
   ((= i 0) 1)
   ((even? i)
    (square (fast-expt n (/ i 2))))
   (else (* n (fast-expt n (- i 1))))))

(define (fast-expt v n)
  (define (fast-expt-iter v i product)
    (display (list v i product)) (newline)
    (cond
     ((= i 0) product)
     ((even? i) (fast-expt-iter (square v)
                                (/ i 2)
                                product))
     (else (fast-expt-iter v
                           (- i 1)
                           (* v product)))))
  (fast-expt-iter v n 1))

(define (my-multiply a b)
  (define (double x) (+ x x))
  (define (halve x) (/ x 2))
  (define (even? x) (= (remainder x 2) 0))
  (define (iter a b sum)
    (display (list a b sum))
    (cond
     ((= b 0) sum)
     ((even? b) (iter (double a)
                      (halve b)
                      sum))
     (else (iter a
                 (- b 1)
                 (+ sum a)))))
  (define (recur a b)
    (display (list a b))
    (cond
     ((= b 0) 0)
     ((even? b) (double (recur a (halve b))))
     (else (+ a (recur a (- b 1))))))
  (recur a b)
  ;; (iter a b 0)
  )

(define (fib n) 
  (define (even? n)
    (= (remainder n 2) 0))
  (define (fib-iter a b c d count)
    (display (list a b c d count)) (newline)
    (cond ((= count 1) b)
          ((even? count)
           (fib-iter (+ (square a) (* b c))
                     (+ (* a b) (* b d))
                     (+ (* c a) (* c d))
                     (+ (* c b) (square d))
                     (/ count 2)))
          (else
           (fib-iter c
                     d
                     (+ a c)
                     (+ b d)
                     (- count 1)))))
  (fib-iter 0 1
            1 1 n))

