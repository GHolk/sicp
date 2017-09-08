
(define (pascal n)
  (define (pascal. i row)
    (if (= i n)
        row
        (pascal. (+ i 1)
                 (next-row row))))
  (define (next-row row)
    (let ((prev-item 0))
      (append (map (lambda (x)
                     (+ x (set! prev-item x)))
                   row)
              '(1))))
  (pascal. 1 '(1)))

(define (pascal-i-j i j)
  (cond
   ((= i 1) 1)
   ((= j 1) 1)
   ((= j i) 1)
   ((< i j) #f)
   (else (let ((prev-i (- i 1)))
           (+ (pascal-i-j prev-i (- j 1))
              (pascal-i-j prev-i j))))))



(define (float-fib n)
  (define phi
    (/ (+ 1
          (sqrt 5))
       2))
  (/ (expt phi n)
     (sqrt 5)))
