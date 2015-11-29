#lang racket/base

(provide make-no-vert-bar-readtable wrap-reader)

(module+ test
  (require rackunit))

;; make-no-bar-readtable : [(U #false Readtable)] -> Readtable
(define (make-no-vert-bar-readtable [rt (current-readtable)])
  (make-readtable rt
    #\|  ; The vertical bar will behave
    #\a  ; the same way a normal character (such as a)
    #f)) ; behaves in the default readtable.

;; wrap-reader : (arg ... -> result) -> (arg ... -> result)
(define (wrap-reader orig-reader)
  (define (no-vert-bar-reader . args)
    (parameterize ([current-readtable (make-no-vert-bar-readtable)])
      (apply orig-reader args)))
  no-vert-bar-reader)

(module+ test
  (define no-vert-bar-reader (wrap-reader read))
  (define (rd str)
    (no-vert-bar-reader (open-input-string str)))
  ;; test case from:
  ;; https://stackoverflow.com/questions/33936505/can-a-vertical-bar-be-used-as-part-of-an-identifier-in-racket
  (check-equal? (rd "|0>") '\|0>)
  )
