#lang racket/base

(provide (rename-out [no-backslash-read read]
                     [no-backslash-read-syntax read-syntax]
                     [no-backslash-get-info get-info]))

(require (only-in syntax/module-reader make-meta-reader)
         "../reader.rkt")

(define-values (no-backslash-read no-backslash-read-syntax no-backslash-get-info)
  (make-meta-reader
   'no-backslash
   "language path"
   (lambda (bstr)
     (let* ([str (bytes->string/latin-1 bstr)]
            [sym (string->symbol str)])
       (and (module-path? sym)
            (vector
             ;; try submod first:
             `(submod ,sym reader)
             ;; fall back to /lang/reader:
             (string->symbol (string-append str "/lang/reader"))))))
   wrap-reader
   wrap-reader
   (lambda (proc)
     (lambda (key defval)
       (define (fallback) (if proc (proc key defval) defval))
       (case key
         [else (fallback)])))))

