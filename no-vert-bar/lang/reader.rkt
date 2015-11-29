#lang racket/base

(provide (rename-out [no-vert-bar-read read]
                     [no-vert-bar-read-syntax read-syntax]
                     [no-vert-bar-get-info get-info]))

(require (only-in syntax/module-reader make-meta-reader)
         "../reader.rkt")

(define-values (no-vert-bar-read no-vert-bar-read-syntax no-vert-bar-get-info)
  (make-meta-reader
   'no-vert-bar
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

