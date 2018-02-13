
(define (accumulate f value list)
  (if (null? list)
      value
      (accumulate f
                  (f (car list) value)
                  (cdr list))))

(define (map p sequence)
  (accumulate (lambda (current all)
                (cons (p current)all))
              '()
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
      '()
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

(define (accumulate-n f init . seqs)
  (define (iter value seqs)
    (if (null? (car seqs))
        value
        (iter (apply f (cons value (map car seqs)))
              (map cdr seqs))))
  (iter init seqs))
     

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (row)
         (dot-product row v))
         m))

(define (transpose mat)
  (map reverse
       (accumulate-n cons '() mat)))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row)
           (map (lambda (col) (dot-product row col))
                cols))
         m)))


(define (reverse sequence)
  (fold-right (lambda (x y) (cons x y)) '() sequence))

(define (reverse sequence)
  (fold-left (lambda (x y) (cons y x) '() sequence)))


(define (flatmap f list)
  (fold-right
   (lambda (sub-list total)
     (fold-right (lambda (x list) (cons x list))
                 total
                 sub-list))
   '()
   (map f list)))

(define (permutations s)
  (define (remove x list)
    (filter (lambda (y) (not (eq? x y)))
            list))
  (define (recur s)
    (if (null? s)                    ; empty set?
        (list s)                     ; sequence containing empty set
        (flatmap (lambda (x)
                   (map (lambda (p) (cons x p))
                        (recur (remove x s))))
                 s)))
    (recur s))

(define (unique-pairs n)
  (define (seq x y)
    (if (> x y)
        '()
        (cons x (seq (+ x 1) y))))
  (flatmap
   (lambda (i)
     (map
      (lambda (j) (cons i j))
      (seq 1 (- i 1))))
   (seq 1 n)))

(define (pair-2d n m)
  (define (seq x y)
    (if (> x y)
        '()
        (cons x (seq (+ x 1) y))))
  (flatmap
   (lambda (i)
     (map (lambda (j) (cons i j))
          (seq 1 m)))
   (seq 1 n)))

(define (prime-sum-pairs n)
  (define (prime? x)
    (define (iter i)
      (if (> (square i) x)
          #f
          (or (= (remainder x i) 0)
              (iter (+ i 1)))))
    (iter 2))
  (filter
   (lambda (ij)
     (not
      (prime?
       (+ (car ij)
          (cdr ij)))))
   (unique-pairs n)))

(define (specific-sum-triples n s)
  (define (seq x y)
    (if (> x y)
        '()
        (cons x (seq (+ x 1) y))))
  (define (unique-triples n)
    (flatmap
     (lambda (i)
       (flatmap
        (lambda (j)
          (map
           (lambda (k) (list i j k))
           (seq 1 j)))
        (seq 1 i)))
     (seq 1 n)))
  (filter
   (lambda (triple)
     (= (fold + 0 triple) s))
   (unique-triples n)))


(define (queens queen-number board-size)
  (define (queen-cols k)
    ;; return value should be:
    ;; ((q1 q2 ... )
    ;;  (q1 q2 ... ))
    ;;
    ;; q1 = (row col)
    (if (= k 0)
        empty-board
        (filter
         safe?
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (row)
                   (adjoin-position row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (define (queen-k k)
    ;; return value should be:
    ;; ((q1 q2 ... )
    ;;  (q1 q2 ... ))
    ;;
    ;; q1 = (row col)
    (if (= k 0)
        empty-board
        (filter
         safe?
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-cell)
                   (cons new-cell rest-of-queens))
                 all-cell))
          (queen-cols (- k 1))))))
  (define (safe? queen-positions)
    ;; (display queen-positions) (newline)
    (define (diff q1 q2)
      (cons (- (car q1) (car q2))
            (- (cdr q1) (cdr q2))))
    (define (slash? diff)
      (= (car diff)
         (cdr diff)))
    (define (backslash? diff)
      (= 0 (+ (car diff)
              (cdr diff))))
    (define (same-row? diff)
      (= 0 (car diff)))
    (define (same-col? diff)
      (= 0 (cdr diff)))
    (let ((queen (car queen-positions))
          (rest-queen (cdr queen-positions)))
      (every (lambda (other-queen)
               (let ((q-diff (diff other-queen queen)))
                 (and (not (slash? q-diff))
                      (not (backslash? q-diff))
                      (not (same-row? q-diff))
                      (not (same-col? q-diff)))))
             rest-queen)))
  (define (enumerate-interval n m)
    (if (> n m)
        '()
        (cons n (enumerate-interval (+ n 1) m))))
  (define (adjoin-position row col rest-of-queens)
    (cons (cons row col)
          rest-of-queens))
  (define empty-board '(()))
  (define all-cell
    (flatmap
     (lambda (row)
       (map (lambda (col) (cons row col))
            (enumerate-interval 1 board-size)))
     (enumerate-interval 1 board-size)))
  (queen-cols queen-number))

(define (print-point xy)
  (let ((x (car xy))
        (y (cdr xy)))
    (define (iter i string)
      (if (> i 8)
          string
      (iter (+ i 1)
            (string-append string
                           (if (= i x)
                               "〇"
                               "十")))))
    (iter 1 "")))

(define (print-board board)
  (for-each (lambda (xy-list)
              (for-each (lambda (point)
                          (display (print-point point))
                          (newline))
                        xy-list)
              (newline))
            board))


(define (pipe value . function-list)
  (fold-left (lambda (value function)
               (function value))
             value
             function-list))
