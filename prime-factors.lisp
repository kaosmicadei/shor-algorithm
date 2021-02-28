(defun solve (number)
  (let ((p 1) (q number) (coprime 1))
    (loop until (and (< p number) (< q number))
      do (progn (setf coprime (next-coprime number coprime))
                (let ((result (factors number coprime (even-period number coprime))))
                  (setf p (pop result))
                  (setf q (pop result)))))
    (list p q)))

(defun next-coprime (number last-coprime)
  (loop for coprime from (1+ last-coprime) to number
    until (= (gcd number coprime) 1)
    finally (return coprime)))

(defun even-period (number coprime)
  (loop for period from 2 by 2
    until (= (rem (expt coprime period) number) 1)
    finally (return period)))

(defun factors (number coprime period)
  (let ((aux (expt coprime (/ period 2))))
    (list (gcd number (1+ aux)) (gcd number (1- aux)))))

(defun main ()
  (print (mapcar #'solve '(15 35 65 91))))

;;(quit)
