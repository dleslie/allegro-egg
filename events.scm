(define user-event-type? (foreign-lambda* bool ((integer event)) "C_return(ALLEGRO_EVENT_TYPE_IS_USER(event));"))
(define make-event-type (foreign-lambda* event-type ((integer a) (integer b) (integer c) (integer d)) "C_return(ALLEGRO_GET_EVENT_TYPE(a, b, c, d));"))

(define event-type (foreign-lambda* event-type ((event cont)) "C_return(cont->type);"))
(define event->any-event (foreign-lambda* any-event ((event cont)) "C_return(&cont->any);"))
(define event->display-event (foreign-lambda* display-event ((event cont)) "C_return(&cont->display);"))
(define event->joystick-event (foreign-lambda* joystick-event ((event cont)) "C_return(&cont->joystick);"))
(define event->keyboard-event (foreign-lambda* keyboard-event ((event cont)) "C_return(&cont->keyboard);"))
(define event->mouse-event (foreign-lambda* mouse-event ((event cont)) "C_return(&cont->mouse);"))
(define event->timer-event (foreign-lambda* timer-event ((event cont)) "C_return(&cont->timer);"))
(define event->user-event (foreign-lambda* user-event ((event cont)) "C_return(&cont->user);"))

(define user-event-source-init! (foreign-lambda void "al_init_user_event_source" event-source))
(define free-user-event-source! (foreign-lambda void "al_destroy_user_event_source" event-source))

(define emit-user-event! (foreign-lambda bool "al_emit_user_event" event-source event (function void (user-event))))
(define user-event-unref! (foreign-lambda void "al_unref_user_event" user-event))

(define event-source-data-set! (foreign-lambda void "al_set_event_source_data" event-source integer))
(define event-source-data (foreign-lambda integer "al_get_event_source_data" event-source))

(define make-event-queue* (foreign-lambda event-queue "al_create_event_queue"))
(define (make-event-queue)
  (let ((q (make-event-queue*)))
    (set-finalizer! q free-event-queue!)
    q))
(define free-event-queue! (foreign-lambda void "al_destroy_event_queue" event-queue))

(define event-queue-register-event-source! (foreign-lambda void "al_register_event_source" event-queue event-source))
(define event-queue-unregister-event-source! (foreign-lambda void "al_unregister_event_source" event-queue event-source))

(define event-queue-empty? (foreign-lambda void "al_is_event_queue_empty" event-queue))

(define event-queue-next*! (foreign-lambda* event ((event-queue q)) "
ALLEGRO_EVENT *evt = (ALLEGRO_EVENT *)C_alloc(sizeof(ALLEGRO_EVENT));
if (al_get_next_event(q, evt))
  C_return(evt);
else
{
  C_free (evt);
  C_return (C_SCHEME_FALSE);
}
"))
(define (event-queue-next! q)
  (let ((evt (event-queue-next*! q)))
    (if (not evt)
        #f
        (begin
          (set-finalizer! evt free-event!)
          evt))))

(define event-queue-peek* (foreign-lambda* event ((event-queue q)) "
ALLEGRO_EVENT *evt = (ALLEGRO_EVENT *)C_alloc(sizeof(ALLEGRO_EVENT));
if (al_peek_next_event(q, evt))
  C_return(evt);
else
{
  C_free (evt);
  C_return (C_SCHEME_FALSE);
}
"))
(define (event-queue-peek q)
  (let ((evt (event-queue-peek* q)))
    (if (not evt)
        #f
        (begin
          (set-finalizer! evt free-event!)
          evt))))

(define event-queue-drop-next! (foreign-lambda bool "al_drop_next_event" event-queue))
(define event-queue-flush! (foreign-lambda void "al_flush_event_queue" event-queue))
(define event-queue-wait! (foreign-lambda* void ((event container) (event-queue q)) "al_wait_for_event(q, container);"))

(define event-queue-timed-wait! (foreign-lambda* bool ((event container)(event-queue q) (float s)) "
if (al_wait_for_event_timed(q, container, s))
  C_return(C_SCHEME_TRUE);
else
  C_return (C_SCHEME_FALSE);
"))

(define event-queue-wait-until! (foreign-lambda* bool ((event container) (event-queue q) ((c-pointer (struct ALLEGRO_TIMEOUT)) t)) "
if (al_wait_for_event_until(q, container, t))
  C_return(C_SCHEME_TRUE);
else
  C_return(C_SCHEME_FALSE);
"))
