(define (sum-integer a b)
  (if (> a b)
      0
      (+ a
         (sum-integer (+ a 1)
                      b))))

(define (sum somewhat a step b)
  (define (recur i)
    (if (> i b)
        0
        (+ (somewhat i)
           (recur (step i)))))
  (recur a))

(define (product f a step b)
  (define (recur i)
    (if (> i b)
        1.0
        (* (f i)
           (recur (step i)))))
  (define (iter i product)
    (if (> i b)
        product
        (iter (step i)
              (* product (f i)))))
  ;; (iter a 1.0)
  (recur a))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

(define (simpson-rule f a b n)
  (define dx (/ (- b a) n))
  (define (xn i) (+ a (* dx i)))
  (define (yn i) (f (xn i)))
  (define (iter i sum)
    (cond
     ((= i n) (+ sum (yn i)))
     ((= i 0) (iter 1 (+ sum (yn 0))))
     ((= (remainder i 2) 1)
      (iter (+ i 1)
            (+ sum (* 4 (yn i)))))
     ((= (remainder i 2) 0)
      (iter (+ i 1)
            (+ sum (* 2 (yn i)))))))
  (/ (* dx (iter 0 0.0))
     3))
      

(define (product-pi n)
  (* 4 (product
        (lambda (i)
          (if (= 1 (remainder i 2))
              (/ (+ i 1)
                 (+ i 2))
              (/ (+ i 2)
                 (+ i 1))))
        1
        (lambda (i) (+ i 1))
        n)))

(define (reduce-from f init a step b)
  (define (iter i all)
    (if (> i b)
        all
        (iter (step i) (f all i))))
  (iter a init))

(define (prime-square-sum n)
  (reduce-from
   (lambda (all x)
     (if (prime? x)
         (+ all (square x))
         all))
   0
   1
   (lambda (i) (+ i 1))
   n))

(define (product-prime-to a n)
  (reduce-from
   (lambda (all x)
     (if (= (gcd x a) 1)
         (* all x)
         all))
   1
   1
   (lambda (i) (+ i 1))
   n))
