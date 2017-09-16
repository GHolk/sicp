
(define (my-remainder a b)
  (display (list 'my-remainder a b)) (newline)
  (if (< a b)
      a
      (my-remainder (- a b) b)))

(define (my-gcd a b)
  (display (list 'my-gcd a b)) (newline)
  (if (= b 0)
      a
      (my-gcd b (my-remainder a b))))

(gcd 206 40)
(if (= 40 0)
    206
    (gcd 40 (remainder 206 40)))

(gcd 40 (remainder 206 40))
(if (= (remainder 206 40) 0)
    40
    (gcd (remainder 206 40)
         (remainder 40 (remainder 206 40))))

(define (expmod-rec base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod-rec base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod-rec base (- exp 1) m))
                    m))))
(define (expmod-iter base power mod)
  (define (iter base power product)
    (cond
     ((= power 0) product)
     ((even? power)
      (iter (remainder (square base) mod)
            (/ power 2)
            product))
     (else
      (iter base
            (- power 1)
            (remainder (* product base)
                       mod)))))
  
  (iter base power 1))


(define (fermat-test n)
  (define (try-it divisor)
    (= divisor
       (expmod divisor n n)))
  (try-it (+ 1 (random (- n 1)))))

(define (smallest-divisor n)
  (define (iter d)
    (cond
     ((= 0 (remainder n d)) d)
     ((< (square d) n) (iter (+ d 1)))))
  (iter 2))

(define (linear-prime-test n)
  (define (next i)
    (if (= i 2)
        3
        (+ i 2)))
  (define (iter i)
    (cond
     ((> (square i) n) #t)
     ((= 0 (remainder n i)) #f)
     (else (iter (+ 1 i)))))
  
  (iter 2))
     
(define (prime?-time n)
  (let*
      ((start (runtime))
       (is-prime (prime? n))
       (end (runtime)))
    (display (list n is-prime (- end start))) (newline)
    is-prime))
       
(define (search-prime-since start)
  (if (prime?-time start)
      start
      (search-prime-since (+ start 1))))

(define (time todo)
  (let* ((start (runtime))
         (result (todo))
         (end (runtime)))
    (display (- end start)) (newline)
    result))



(define (mr-test n)
  (define (expmod base power mod)
    (define origin-base base)
    (define (test-mr a)
      (let ((a2 (remainder (square a) mod)))
         (and (= a2 1)
              (not (= a 1))
              (not (= a (- origin-base 1))))))
    (define (iter base power product)
      (cond
       ((= power 0) product)
       ((even? power)
        (if (test-mr base)
            (iter 1 0 2)
            (iter (remainder (square base) mod)
                  (/ power 2)
                  product)))
       (else (iter base
                   (- power 1)
                   (remainder (* product base)
                              mod)))))
    (iter base power 1))
  
  (let ((a (+ 1 (random (- n 1)))))
    (= (expmod a (- n 1) n)
       1)))

(define (miller-rabin-expmod base exp m)
  (define (non-trivial-sqrt-1-mod-n a n)
    (if (and (not (= a 1))
             (not (= a (- n 1)))
             (= 1 (remainder (square a) n)))
        0
        (remainder (square a) n)))
  (cond ((= exp 0) 1)
        ((even? exp)
         (non-trivial-sqrt-1-mod-n (miller-rabin-expmod base (/ exp 2) m) m))
        (else
         (remainder (* base (miller-rabin-expmod base (- exp 1) m))
                    m))))

(define (miller-rabin-test n)
  (define (try-it a)
    (= 1 (miller-rabin-expmod a (- n 1) n)))
  (try-it (+ 2 (random-integer (- n 2)))))
