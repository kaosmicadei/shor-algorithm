(import [math [gcd]])

(defmacro do-until [condition &rest body]
  `(while True 
      ~body
      (if ~condition 
        (break))))

(defmacro incv [variable]
  `(setv ~variable (+ ~variable 1)))

(defn solve [number]
  (setv p 1
        q number
        coprime 1)
  (do-until (and (< p number) (< p number))
    (setv coprime (next-coprime number coprime)
          period  (find-even-period number coprime)
          [p q]   (get-factors number coprime period)))
    (, p q))

(defn next-coprime [number last-coprime]
  (setv coprime last-coprime)
  (do-until (= (gcd number coprime) 1)
    (incv coprime))
  coprime)

(defn find-even-period [number base]
  (setv period 2)
  (do-until (-> base (** period) (% number) (= 1))
    (setv period (+ period 2)))
  period)

(defn get-factors [number base period]
  (setv w (** base (// period 2))
        p (gcd (+ w 1) number)
        q (gcd (- w 1) number))
  (, p q))


;; TEST
(for [x [15 35 65 91]]
  (print x (solve x)))