
(define counter
  (let ((i 0))
    (lambda () (set! i (+ i 1)))))

(define (fib-tree n)
  (cond
   ((= n 0) 0)
   ((= n 1) 1)
   (else (+ (fib (- n 1))
            (fib (- n 2))))))

(define (fib-iter n)
  (define (fib-count a b count)
    (if (= count n)
        a
        (fib-count b (+ a b)
                   (+ count 1))))
  (fib-count 0 1 0))
