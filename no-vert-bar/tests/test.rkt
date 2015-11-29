#lang no-vert-bar racket

(module+ test
  (require rackunit)

  (define |0> 3)
  (check-equal? |0> 3)
  )
