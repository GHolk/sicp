
(define (accumulate f value list)
  (if (null? list)
      value
      (accumulate f
                  (f (car list) value)
                  (cdr list))))

(define (map p sequence)
  (accumulate (lambda (current all)
                (cons (p current)all))
              ()
              (reverse sequence)))

(define (append seq1 seq2)
  (accumulate cons
              seq2
              (reverse seq1)))

(define (length seq)
  (accumulate (lambda (x length) (+ length 1))
              0
              seq))

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
                (+ this-coeff
                   (* x higher-terms)))
              0
              coefficient-sequence))


(define (count-leaves t)
  (accumulate (lambda (number total)
                (+ number total))
              0
              (map (lambda (x)
                     (if (list? x)
                         (count-leaves x)
                         1))
                   t)))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      ()
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))


(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (row)
         (dot-product row v))
         m))

(define (transpose mat)
  (map reverse
       (accumulate-n cons () mat)))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row)
           (map (lambda (col) (dot-product row col))
                cols))
         m)))


(define (reverse sequence)
  (fold-right (lambda (x y) (cons x y)) () sequence))

(define (reverse sequence)
  (fold-left (lambda (x y) (cons y x) () sequence))

