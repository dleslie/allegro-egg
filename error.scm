(define errno (foreign-lambda integer "al_get_errno"))
(define errno-set! (foreign-lambda void "al_set_errno" integer))
