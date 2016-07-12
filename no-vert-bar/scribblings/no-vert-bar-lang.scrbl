#lang scribble/manual

@title{no-vert-bar-lang}

source code: @url{https://github.com/AlexKnauth/no-vert-bar-lang}

@section{#lang no-vert-bar}

@defmodule[no-vert-bar #:lang]{
A racket lang-extension that reads @litchar{|} as a normal character.

It takes another language as an argument, so that @hash-lang[]
@racketmodname[no-vert-bar] @racketmodname[racket] is a language like
@racketmodname[racket] but without the special behavior for
@litchar{|}.
}

@codeblock{
#lang no-vert-bar racket

(define (P-A|B P-A P-B P-B|A)
  (* P-B|A (/ P-A P-B)))

(define (|| a b)
  (or a b))

(define |0>
  (vector-immutable 1 0))
(define |1>
  (vector-immutable 0 1))
}

These all treat the @litchar{|} like it was any other character, so
that it doesn't interfere with how you name your identifiers.

@section{#lang no-backslash}

@defmodule[no-backslash #:lang]{
A racket lang-extension that reads @litchar{\} as a normal character.

Just like with @racketmodname[no-vert-bar], @hash-lang[]
@racketmodname[no-backslash] @racketmodname[racket] would declare a
language like @racketmodname[racket] but without the special behavior
for @litchar{\}.
}

@codeblock{
#lang no-backslash racket

(define (/\ a b)
  (and a b))

(define (\/ a b)
  (or a b))
}
