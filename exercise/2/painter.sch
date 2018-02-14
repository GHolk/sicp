(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((next (up-split painter (- n 1))))
        (below (beside next next)
               painter))))


(define (split first second)
  (lambda (painter)
    (first painter
           (second painter painter))))

(define (split first second)
  (define (split-n painter n)
    (if (= n 0)
        painter
        (let ((next (split-n painter (- n 1))))
          (first painter
                 (second next next)))))
  split-n)

(define (add-vect u v)
  (let ((x (+ (xcor-vect u)
              (xcor-vect v)))
        (y (+ (ycor-vect u)
              (ycor-vect v))))
    (make-vect x y)))
(define (sub-vect u v)
  (let ((x (- (xcor-vect u)
              (xcor-vect v)))
        (y (- (ycor-vect u)
              (ycor-vect v))))
    (make-vect x y)))
(define (scale-vect s v)
  (let ((x (* s (xcor-vect v)))
        (y (* s (ycor-vect v))))
    (make-vect x y)))

(begin
  (define (make-frame origin edge1 edge2)
    (list origin edge1 edge2))
  (define (origin-frame frame)
    (list-ref frame 0))
  (define (edge1-frame frame)
    (list-ref frame 1))
  (define (edge2-frame)
    (list-ref frame 2)))

(begin
  (define (make-frame origin edge1 edge2)
    (cons origin (cons edge1 edge2)))
  (define (origin-frame frame)
    (car frame))
  (define (edge1-frame frame)
    (cadr frame))
  (define (edge2-frame frame)
    (cddr frame)))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))

(define (integer->float integer)
  (+ integer 0.0))

(define (make-segment start end)
  (cons start end))
(define (start-segment segment)
  (car segment))
(define (end-segment segment)
  (cdr segment))

;; ((1 2) (3 4) (5 6))
;; (((1 2) (3 4)) ((3 4) (5 6)))
(define (fragment-line->painter point-list)
  (let* ((point-number (length point-list))
         (edge-number (- point-number 1))
         (start-list (list-head point-list edge-number))
         (end-list (list-tail point-list 1))
         (segment-list (map (lambda (start end)
                               (list start end))
                             start-list
                             end-list)))
    (segment->painter segment-list)))

(define outline-painter
  (fragment-line->painter '((0 0) (0 1) (1 1) (1 0) (0 0))))

(define x-painter
  (segment->painter '(((0 0) (1 1))
                      ((0 1) (1 0)))))
(define diamond-painter
  (segment->painter '((0.5 0)
                      (1   0.5)
                      (0.5 1)
                      (0   0.5))))
(define wave-painter)

