
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))


(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define (union-set set1 set2)
  (if (null? set2)
      set1
      (let ((first (car set2)))
        (if (element-of-set? first set1)
            (union-set set1 (cdr set2))
            (union-set (cons first set1)
                       (cdr set2))))))


;; for order set
(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((= x (car set)) #t)
        ((< x (car set)) #f)
        (else (element-of-set? x (cdr set)))))

(define (intersection-set set1 set2)
  (define (iter new-set set1 set2)
    (if (or (null? set1) (null? set2))
        new-set
        (let ((x1 (car set1)) (x2 (car set2)))
          (cond
           ((= x1 x2)
            (iter (cons x1 new-set)
                  (cdr set1)
                  (cdr set2)))
          ((< x1 x2)
           (iter new-set
                 (cdr set1)
                 set2))
          ((< x2 x1)
           (iter new-set
                 set1
                 (cdr set2)))))))
  (iter '() set1 set2))

(define (adjoin-set set1 set2)
  (cond
   ((null? set1) set2)
   ((null? set2) set1)
   (else
    (let ((item1 (car set1))
          (item2 (car set2)))
      (cond
       ((= item1 item2)
        (adjoin-set set1
                    (cdr set2)))
       ((> item1 item2)
        (cons item2
              (adjoin-set set1
                          (cdr set2))))
       ((< item1 item2)
        (cons item1
              (adjoin-set (cdr set1)
                          set2))))))))


;; binary tree
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set? x set)
       (cond ((null? set) false)
             ((= x (entry set)) true)
             ((< x (entry set))
              (element-of-set? x (left-branch set)))
             ((> x (entry set))
              (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
       (cond ((null? set) (make-tree x '() '()))
             ((= x (entry set)) set)
             ((< x (entry set))
              (make-tree (entry set)
                         (adjoin-set x (left-branch set))
                         (right-branch set)))
             ((> x (entry set))
              (make-tree (entry set)
                         (left-branch set)
                         (adjoin-set x (right-branch set))))))

(define (tree->list-1 tree)
  ;; (c)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define c (counter))
  (define (copy-to-list tree result-list)
    (c)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

(define (list->tree elements)
  (define (partial-tree elts n)
    (if (= n 0)
        (cons '() elts)
        (let* ((left-size (quotient (- n 1) 2))
               (left-result (partial-tree elts left-size))
               (left-tree (car left-result))
               (non-left-elts (cdr left-result))
               (right-size (- n (+ left-size 1)))
               (this-entry (car non-left-elts))
               (right-result (partial-tree (cdr non-left-elts)
                                           right-size))
               (right-tree (car right-result))
               (remaining-elts (cdr right-result)))
          (cons (make-tree this-entry
                           left-tree
                           right-tree)
                remaining-elts))))
  (car (partial-tree elements (length elements))))

(define (union-set set1 set2)
  (if (null? set2)
      set1
      (let ((item (entry set2)))
        (union-set (adjoin-set item set1)
                   (union-set (left-branch set2)
                              (right-branch set2))))))

(define (union-set set1 set2)
  (cond
   ((null? set1) set2)
   ((null? set2) set1)
   (else
    (let ((entry1 (entry set1))
          (entry2 (entry set2)))
      (cond
       ((= entry1 entry2)
        (make-tree entry1
                   (union-set (left-branch set1)
                              (left-branch set2))
                   (union-set (right-branch set1)
                              (right-branch set2))))
       ((< entry1 entry2)
        (union-set (adjoin-set entry2
                               (make-tree entry1
                                          (left-branch set1)
                                          (union-set (right-branch set1)
                                                     (right-branch set2))))
                   (left-branch set2)))
       ((< entry2 entry1)
        (union-set (adjoin-set entry1
                               (make-tree entry2
                                          (left-branch set2)
                                          (union-set (right-branch set2)
                                                     (right-branch set1))))
                   (left-branch set1))))))))
      

(define (counter)
  (let ((count 0))
    (lambda ()
      (display count) (newline)
      (set! count (+ count 1)))))
