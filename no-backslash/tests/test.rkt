#lang no-backslash racket

(module+ test
  (require rackunit)

  (define (/\ a b)
    (and a b))
  (define (\/ a b)
    (or a b))

  (test-case "and"
    (check-equal? (/\ #true #true) #true)
    (check-equal? (/\ #true #false) #false)
    (check-equal? (/\ #false #true) #false)
    (check-equal? (/\ #false #false) #false))

  (test-case "or"
    (check-equal? (\/ #true #true) #true)
    (check-equal? (\/ #true #false) #true)
    (check-equal? (\/ #false #true) #true)
    (check-equal? (\/ #false #false) #false))
  )
