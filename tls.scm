(define state-store! (foreign-lambda void "al_store_state" state state-flag))
(define state-restore (foreign-lambda void "al_restore_state" (const state)))
