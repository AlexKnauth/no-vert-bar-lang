#lang racket/base

(provide make-no-backslash-readtable wrap-reader)

(module+ test
  (require rackunit))

;; make-no-backslash-readtable : [(U #false Readtable)] -> Readtable
(define (make-no-backslash-readtable [rt (current-readtable)])
  (make-readtable rt
    #\\  ; The backslash will behave
    #\a  ; the same way a normal character (such as a)
    #f)) ; behaves in the default readtable.

;; wrap-reader : (arg ... -> result) -> (arg ... -> result)
(define (wrap-reader orig-reader)
  (define (no-backslash-reader . args)
    (parameterize ([current-readtable (make-no-backslash-readtable)])
      (apply orig-reader args)))
  no-backslash-reader)

(module+ test
  (define no-backslash-reader (wrap-reader read))
  (define (rd str)
    (no-backslash-reader (open-input-string str)))
  (check-equal? (rd (string #\\ #\/)) '|\/|)
  (check-equal? (rd (string #\/ #\\)) '|/\|)
  )
