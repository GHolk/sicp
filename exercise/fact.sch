(define (factorial n)
  (if (= n 0)
      0
      (* n (factorial (- n 1)))))

(define (factorial-from-1 n)
  (define (fact-1 i)
    (if (= n i)
        i
        (* i (fact-1 (+ i 1)))))
  (fact-1 1))

(define (fact-tail n)
  (define (fact-iter prod i)
    (if (= i n)
        (* prod i)
        (fact-iter (* prod i) (+ i 1))))
  (fact-iter 1 1))

