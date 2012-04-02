(define error-number (foreign-lambda integer "al_get_errno"))
(define error-number-set! (foreign-lambda void "al_set_errno" integer))






