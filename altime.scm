(define time (foreign-lambda double "al_get_time"))
(define rest (foreign-lambda void "al_rest" double))

;; typedef struct ALLEGRO_TIMEOUT ALLEGRO_TIMEOUT;
;; struct ALLEGRO_TIMEOUT {
;;    uint64_t __pad1__;
;;    uint64_t __pad2__;
;; };
;; AL_FUNC(void, al_init_timeout, (ALLEGRO_TIMEOUT *timeout, double seconds));
