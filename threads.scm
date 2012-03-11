(define make-thread* (foreign-lambda thread "al_create_thread" (function c-pointer (thread c-pointer)) c-pointer))
(define (make-thread func ptr)
  (let ((th (make-thread* func ptr)))
    (set-finalizer! th free-thread!)
    th))

(define free-thread! (foreign-lambda void "al_destroy_thread" thread))

(define run-detached-thread (foreign-lambda void "al_run_detached_thread" (function c-pointer (c-pointer)) c-pointer))

(define thread-start! (foreign-lambda void "al_start_thread" thread))
(define thread-join! (foreign-lambda void "al_join_thread" thread (c-pointer c-pointer)))
(define thread-should-stop-set! (foreign-lambda void "al_set_thread_should_stop" thread))
(define thread-should-stop? (foreign-lambda bool "al_get_thread_should_stop" thread))

(define make-mutex* (foreign-lambda mutex "al_create_mutex"))
(define (make-mutex)
  (let ((mtx (make-mutex*)))
    (set-finalizer! mtx free-mutex!)
    mtx))

(define free-mutex! (foreign-lambda void "al_destroy_mutex" mutex))

(define make-mutex-recursive* (foreign-lambda mutex "al_create_mutex_recursive"))
(define (make-mutex-recursive)
  (let ((mtx (make-mutex-recursive*)))
    (set-finalizer! mtx free-mutex!)
    mtx))

(define mutex-lock! (foreign-lambda void "al_lock_mutex" mutex))
(define mutex-unlock! (foreign-lambda void "al_unlock_mutex" mutex))

(define make-condition* (foreign-lambda condition "al_create_cond"))
(define (make-condition)
  (let ((cnd (make-condition*)))
    (set-finalizer! cnd free-condition!)
    cnd))

(define free-condition! (foreign-lambda void "al_destroy_cond" condition))

(define condition-wait (foreign-lambda void "al_wait_cond" condition mutex))
(define condition-wait-until (foreign-lambda int "al_wait_cond_until" condition mutex timeout))
(define condition-broadcast (foreign-lambda void "al_broadcast_cond" condition))
(define condition-signal (foreign-lambda void "al_signal_cond" condition))
