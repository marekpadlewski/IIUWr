#lang racket

(define (dist x y)
  (abs (- x y)))

;; funkcje z zajęć

(define (compose f g) (lambda (x) (f (g x))))

(define (identity x) x)

(define (repeated p n)
  (lambda (x)
    (if(= n 0)
    (identity x)
    ((compose (repeated p (- n 1)) p) x))))


;; funkcje z wykładu

(define (close-enough? x y)
  (< (dist x y) 0.00001))

(define (fixed-point f x0)
  (let ((x1 (f x0)))
    (if (close-enough? x0 x1)
        x0
        (fixed-point f x1))))

(define (average-damp f)
  (lambda (x) (/ (+ x (f x)) 2)))

;; funcka licząca logarytm o podstawie 2
;; wprowadzając kolejne liczby naturalne do funkcji nth-root oraz wykonując
;; coraz więcej tłumień zauważyłem że program się zapętla dla kolejnych
;; potęg dwójki,
;; (np. wykonując (nth-root 128 7) przy tłumieniu 2 razy program się wykona
;; dla (nth-root 256 8) się zapętla więc przechodzę do trzykrotnego tłumienia)
;; więc liczba tłumień jaka jest stosowana dla kolejnych
;; pierwiastków jest równa zaokrąglonej w dół liczbie log o podstawie 2 z n

(define (log2 x)
  (/ (log x) (log 2)))


;; szukamy stałego miejsca funkcji x/y^(n-1), na której używamy
;; tłumienia 'log n o podstawie 2' razy

(define (nth-root x n)
  (fixed-point
      ((repeated average-damp (floor (log2 n)))
          (lambda (y) (/ x (expt y (- n 1))))) 1.0))

(nth-root 4 2) (display "Pierwiastek 2 stopnia z 4. Liczba tłumień: ") (floor (log2 4))
(nth-root 128 7) (display "Pierwiastek 7 stopnia z 128. Liczba tłumień: ") (floor (log2 7))
(nth-root 256 8) (display "Pierwiastek 8 stopnia z 256. Liczba tłumień: ") (floor (log2 8))
(nth-root 1024 10) (display "Pierwiastek 10 stopnia z 1024. Liczba tłumień: ") (floor (log2 10))
(nth-root 65536 16) (display "Pierwiastek 16 stopnia z 65536. Liczba tłumień: ") (floor (log2 16))
(nth-root -8 3) (display "Pierwiastek 3 stopnia z -8. Liczba tłumień: ") (floor (log2 3))