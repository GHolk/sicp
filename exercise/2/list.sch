
(define (last-pair list)
  (let ((remaind-list (cdr list)))
    (if (null? remaind-list)
        (car list)
        (last-pair remaind-list))))

(define (reverse list)
  (define (recur remaind-list)
    (if (null? remaind-list)
        '()
        (cons (car remaind-list)
              (recur (cdr remaind-list)))))
  (define (iter remaind-list new-list)
    (if (null? remaind-list)
        new-list
        (iter (cdr remaind-list)
              (cons (car remaind-list) new-list))))
  ;; (iter list '())
  (recur list))

(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(define (count-change amount coin-list)
  (define (no-more? coin-values)
    (null? coin-values))
  (define (except-first-denomination coin-values)
    (cdr coin-values))
  (define (first-denomination coin-values)
    (car coin-values))
  (define (cc amount coin-values)
    (cond ((= amount 0) 1)
          ((or (< amount 0)
               (no-more? coin-values))
           0)
          (else
           (+ (cc amount
                  (except-first-denomination coin-values))
              (cc (- amount
                     (first-denomination coin-values))
                  coin-values)))))
  (cc amount coin-list))
(count-change 28 uk-coins)

(define (filter f list)
  (define (recur list)
    (if (null? list)
        list
        (let ((next (car list))
              (other (cdr list)))
          (if (f next)
              (cons next (recur other))
              (recur other)))))
  (define (iter old new)
    (if (null? old)
        new
        (let ((next (car old))
              (other (cdr old)))
          (iter other
                (if (f next)
                    (cons next new)
                    new)))))
  ;; (iter list '())
  (recur list))

(define (same-parity . number-list)
  (let* ((first-number (car number-list))
         (indicator (remainder first-number 2)))
    (filter
     (lambda (x)
       (= indicator (remainder x 2)))
     number-list)))

(define (show-rest . rest)
  (newline)
  (display rest))

(define (my-map f list)
  (define (iter old new)
    (if (null? old)
        new
        (iter (cdr old)
              (cons (f (car old))
                    new))))
  (define (recur list)
    (if (null? list)
        list
        (cons (f (car list))
              (recur (cdr list)))))
  ;; (reverse (iter list '()))
  (recur list))

(define (for-each f list)
  (define (iter other)
    (if (null? other)
        other
        (begin
          (f (car other))
          (iter (cdr other)))))
  (iter list))
