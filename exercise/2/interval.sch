
(define (make-interval lower upper)
  (cons lower upper))
(define (upper-bound interval)
  (cdr interval))
(define (lower-bound interval)
  (car interval))

(define (div-interval x y)
  (let ((upper (upper-bound y))
        (lower (lower-bound y)))
    (if (or (= 0 upper)
            (= 0 lower))
        (error "devide by zero!")
        (mul-interval x
                      (make-interval
                       (/ 1.0 upper)
                       (/ 1.0 lower))))))

(define (mul-interval x y)
  (define (multiply-all)
    (let ((p1 (* (lower-bound x) (lower-bound y)))
          (p2 (* (lower-bound x) (upper-bound y)))
          (p3 (* (upper-bound x) (lower-bound y)))
          (p4 (* (upper-bound x) (upper-bound y))))
      (make-interval (min p1 p2 p3 p4)
                     (max p1 p2 p3 p4))))
  ;; (define (test-all)
  ;;   (let ((lower-x (lower-bound x))
  ;;         (upper-x (upper-bound x))
  ;;         (lower-y (lower-bound y))
  ;;         (upper-y (upper-bound y)))
  ;;     (cond
  ;;      ((and (positive? lower-x)
  ;;            (positive? lower-y))
  ;;       (make-interval (* lower-y lower-x)
  ;;                      (* upper-y upper-x)))
       
  ;;      ((and (negative? upper-x)
  ;;            (negative? upper-y))
  ;;       (make-interval (* upper-x upper-y)
  ;;                      (* lower-x lower-y)))
       
  ;;      ((and (negative? upper-x)
  ;;            (positive? lower-y))
  ;;       (make-interval (* upper-y lower-x)
  ;;                      (* upper-x lower-y)))
  ;;      ((and (negative? upper-y)
  ;;            (positive? lower-x))
  ;;       (make-interval (* upper-x lower-y)
  ;;                      (* upper-y lower-x)))
       
  ;;       ((and (
  (multiply-all))
  

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(define (print-interval x)
  (newline)
  (display
   (list (upper-bound x)
         (lower-bound x))))
   
(define (width x)
  (- (upper-bound x)
     (lower-bound x)))
(define (center x)
  (define (average a b)
    (/ (+ a b) 2))
  (average (upper-bound x)
           (lower-bound x)))
(define (make-center-percent center percentage)
  (let ((error (* center percentage)))
    (make-interval (- center error)
                   (+ center error))))
(define (percent x)
  (/ (width x) (center x) 2))

(define (remove-error x)
  (make-center-percent (center x) 0))

(define (parallel-resistors r1 r2)
  (let ((one (make-center-percent 1 0)))
    (div-interval
     one
     (add-interval (div-interval one r1)
                   (div-interval one r2)))))
