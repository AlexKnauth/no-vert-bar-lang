no-vert-bar-lang
===
a racket meta-language that reads `|` as a normal character

```racket
#lang no-vert-bar racket
(define (P-A|B P-A P-B P-B|A)
  (* P-B|A (/ P-A P-B)))
```
