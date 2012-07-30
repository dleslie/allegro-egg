(define state-store! (foreign-lambda void "al_store_state" state integer))
(define state-restore (foreign-lambda void "al_restore_state" (const state)))
