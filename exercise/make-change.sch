(define (count-change amount)
  (define (cc amount coin-type list)
    (cond
     ((= amount 0) 1)
     ((or (< amount 0)
          (= coin-type 0))
      0)
     (else (+ (cc (- amount
                     (value-of-coin coin-type))
                  coin-type)
              (cc amount
                  (- coin-type 1))))))
    (define (value-of-coin coin-type)
      (cond
       ((= coin-type 1) 1)
       ((= coin-type 2) 5)
       ((= coin-type 3) 10)
       ((= coin-type 4) 25)
       ((= coin-type 5) 50)))
  (cc amount 5))
                     

(define (f n)
  (if (< n 3)
      n
      (+ (* 1 (f (- n 1)))
         (* 2 (f (- n 2)))
         (* 3 (f (- n 3))))))

(define (f-iter n)
  (define (f. i f1 f2 f3)
      (if (= n i)
          f1
          (f. (+ i 1)
              f2
              f3
              (+ (* 3 f1)
                 (* 2 f2)
                 (* 1 f3)))))
  (f. 0 0 1 2))
