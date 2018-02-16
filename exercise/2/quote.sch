
(define false #f)

(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

(define (equal? a b)
  (if (and (pair? a)
           (pair? b))
      (and (equal? (car a)
                   (car b))
           (equal? (cdr a)
                   (cdr b)))
      (eq? a b)))
