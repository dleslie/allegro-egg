(define current-time (foreign-lambda double "al_get_time"))
(define rest (foreign-lambda void "al_rest" double))
(define init-timeout (foreign-lambda void "al_init_timeout" timeout double))
