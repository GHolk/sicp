

(list 1 (list 2 (list 3 4)))
'(1 (2 (3 4)))
'(1 . ((2 . ((3 . (4 . ())) . ()))))

(define (list . l) l)

(define (extract-last tree)
  (define (make-leaf value depth)
    (cons value depth))
  (define (value leaf) (car leaf))
  (define (depth leaf) (cdr leaf))
  (define (recur-hand tree depth)
    (if (pair? tree)
        (deeper (recur-hand (car tree) (+ depth 1))
                (recur-hand (cdr tree) depth))
        (make-leaf tree depth)))
  (define (deeper x y)
    (cond
     ((null? (value x)) y)
     ((null? (value y)) x)
     ((> (depth x) (depth y)) x)
     (else y)))
  (value (recur-hand tree 0)))

(define extract-sample
  ;; above function extract-last
  ;; should extract 7 for all sample.
  '(
    (1 3 (5 7) 9)
    ((7))
    (1 (2 (3 (4 (5 (6 7))))))
    ))

(let ((x '(1 2 3))
      (y '(4 5 6)))
  (define (print-ln value)
    (newline)
    (display value))
  (print-ln (append x y))               ; (1 2 3 4 5 6)
  (print-ln (cons x y))                 ; ((1 2 3) . (4 5 6))
                                        ; ((1 2 3) 4 5 6)
  (print-ln (list x y)))                ; ((1 2 3) (4 5 6))
  
(define (deep-reverse tree)
  (map
   (lambda (x)
     (if (list? x) (deep-reverse x) x))
   (reverse tree)))
  
(define (fringe tree)
  (define (my-reduce f init list)
    "I do not know why scheme reduce not work like this."
    (reduce f init (cons init list)))
  (define (push-leaf-to-list list leaf)
    (if (list? leaf)
        (my-reduce push-leaf-to-list list leaf)
        (else (cons leaf list))))
  
  (deep-reverse
   (my-reduce
    push-leaf-to-list
    '()
    tree)))

;; constructor
(define (make-mobile left right)
  (list left right))
(define (make-branch length structure)
  (list length structure))

;; selector
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (car (cdr mobile)))
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (car (cdr branch)))
(define (mobile? m)
  (not (number? m)))

;; lib
(define (mobile-weight mobile)
  (let ((left (left-branch mobile))
        (right (right-branch mobile)))
    (+ (branch-weight left)
       (branch-weight right))))
(define (branch-weight branch)
  (let ((structure (branch-structure branch)))
    (if (mobile? structure)
        (mobile-weight structure)
        structure)))

(define (balanced? mobile)
  (define (torque branch)
    (* (branch-length branch)
       (branch-weight branch)))
  (define (balanced-branch? branch)
    (let ((structure (branch-structure branch)))
      (if (mobile? structure)
          (balanced-mobile? structure)
          #t)))
  (define (balanced-mobile? mobile)
    (let ((left (left-branch mobile))
          (right (right-branch mobile)))
      (and (= (torque left)
              (torque right))
           (balanced-branch? left)
           (balanced-branch? right))))
  (balanced-mobile? mobile))

(define m0
  (make-mobile
   (make-branch 3 7)
   (make-branch 3 7)))
(define m1
  (make-mobile
   (make-branch 4 2)
   (make-branch
    3
    (make-mobile
     (make-branch 2 3)
     (make-branch
      3
      (make-mobile
       (make-branch 2 3)
       (make-branch 2 5)))))))

(define (square-tree tree)
  (define (map-square tree)
    (map
     (lambda (x)
       (if (list? x)
           (map-square x)
           (square x)))
     tree))
  (define (hand-square tree)
    (cond
     ((pair? tree)
      (cons (hand-square (car tree))
            (hand-square (cdr tree))))
     ((null? tree) '())
     (else (square tree))))
  (map-square tree))

(define (tree-map f tree)
  (define (recur tree)
    (cond
     ((pair? tree)
      (cons (recur (car tree))
            (recur (cdr tree))))
     ((null? tree) tree)
     (else (f tree))))
  (define (recur-map tree)
    (map
     (lambda (leaf)
       (if (list? leaf)
           (recur-map leaf)
           (f leaf)))
     tree))
  (recur tree))
     
