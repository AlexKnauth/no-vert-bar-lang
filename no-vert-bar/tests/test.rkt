#lang no-vert-bar racket

(module+ test
  (require rackunit)

  ;; Bayes' theorem:
  (define (P-A|B P-A P-B P-B|A)
    (* P-B|A (/ P-A P-B)))

  ;; Monty-Hall
  ;; You have chosen door 1
  ;; A = prize behind door 2
  ;; B = door 3 opened after you choose door 1
  (define P-A 1/3)
  (define P-B 1/2)
  ;; If A is true, they will have no choice but to open door 3, since
  ;; you picked door 1 and they know the prize is behind door 2.
  (define P-B|A 1)
  ;; If B is true, what is the probability of A?
  (check-equal? (P-A|B P-A P-B P-B|A) 2/3)
  )
