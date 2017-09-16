
(defun cc(amount coin-type list)
  (cond
   ((= amount 0) (push list my-set))
   ((or (< amount 0) (= coin-type 0)) nil)
   (t (progn (cc (- amount (value-of-coin coin-type))
                 coin-type
                 (cons coin-type list))
            (cc amount
                (- coin-type 1)
                list)))))

(defun value-of-coin(type)
  (case type
    (1 1)
    (2 5)
    (3 10)
    (4 25)
    (5 50)))
