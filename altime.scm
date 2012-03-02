(define time-time (foreign-lambda double "al_get_time"))
(define time-rest (foreign-lambda void "al_rest" double))
(define time-init-timeout (foreign-lambda void "al_init_timeout" timeout double))
