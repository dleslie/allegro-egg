(define debug-trace-prefix (foreign-lambda bool "_al_trace_prefix" c-string int c-string int c-string))

(define debug-trace-level-debug (foreign-lambda* void () "ALLEGRO_DEBUG;"))
(define debug-trace-level-info (foreign-lambda* void () "ALLEGRO_INFO;"))
(define debug-trace-level-warn (foreign-lambda* void () "ALLEGRO_WARN;"))
(define debug-trace-level-error (foreign-lambda* void () "ALLEGRO_ERROR;"))

(define debug-assert (foreign-lambda void "ALLEGRO_ASSERT" bool))
