(define trace-prefix (foreign-lambda bool "_al_trace_prefix" c-string int c-string int c-string))

(define trace-level-debug (foreign-lambda* void () "ALLEGRO_DEBUG;"))
(define trace-level-info (foreign-lambda* void () "ALLEGRO_INFO;"))
(define trace-level-warn (foreign-lambda* void () "ALLEGRO_WARN;"))
(define trace-level-error (foreign-lambda* void () "ALLEGRO_ERROR;"))

(define debug-assert (foreign-lambda void "ALLEGRO_ASSERT" bool))
