
(define (cons-lambda car cdr)
  (lambda (f) (f car cdr)))
(define (car-lambda pair)
  (pair (lambda (car cdr) car)))
(define (cdr-lambda pair)
  (pair (lambda (car cdr) cdr)))


(define (cons-23 base2 base3)
  (* (expt 2 base2)
     (expt 3 base3)))
(define (car-23 pair)
  (define (multiple? n x)
    (= 0 (remainder n x)))
  (define (iter x i)
    (if (multiple? x 2)
        (iter (/ x 2) (+ i 1))
        i))
  (iter pair 0))
(define (cdr-23 pair)
  (define (multiple? n x)
    (= 0 (remainder n x)))
  (define (iter x i)
    (if (multiple? x 3)
        (iter (/ x 3) (+ i 1))
        i))
  (iter pair 0))


(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))
(define one
  (lambda (f) (lambda (x) (f x))))
(define two
  (lambda (f) (lambda (x) (f (f x)))))
(define (add a b)
  (lambda (f) (lambda (x) ((a f) ((b f) x)))))
(define (show-n n)
  ((n (lambda (x) (+ x 1)))
   0))
(define (get-n n)
  (define (iter i fn)
    (if (= i 0)
        fn
        (iter (- i 1) (add-1 fn))))
  (iter n zero))

        
