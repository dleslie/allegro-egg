(define user-event-type? (foreign-lambda* bool ((integer event)) "C_return(ALLEGRO_EVENT_TYPE_IS_USER(event));"))

(define make-event-type (foreign-lambda* integer ((integer a) (integer b) (integer c) (integer d)) "C_return(ALLEGRO_GET_EVENT_TYPE(a, b, c, d));"))

(define event-container-type (foreign-lambda* event-type ((event-container cont)) "C_return(cont->type);"))
(define event-container-any (foreign-lambda* (c-pointer (struct ALLEGRO_ANY_EVENT)) ((event-container cont)) "C_return(&cont->any);"))
(define event-container-display (foreign-lambda* (c-pointer (struct ALLEGRO_DISPLAY_EVENT)) ((event-container cont)) "C_return(&cont->display);"))
(define event-container-joystick (foreign-lambda* (c-pointer (struct ALLEGRO_JOYSTICK_EVENT)) ((event-container cont)) "C_return(&cont->joystick);"))
(define event-container-keyboard (foreign-lambda* (c-pointer (struct ALLEGRO_KEYBOARD_EVENT)) ((event-container cont)) "C_return(&cont->keyboard);"))
(define event-container-mouse (foreign-lambda* (c-pointer (struct ALLEGRO_MOUSE_EVENT)) ((event-container cont)) "C_return(&cont->mouse);"))
(define event-container-timer (foreign-lambda* (c-pointer (struct ALLEGRO_TIMER_EVENT)) ((event-container cont)) "C_return(&cont->timer);"))
(define event-container-user (foreign-lambda* (c-pointer (struct ALLEGRO_USER_EVENT)) ((event-container cont)) "C_return(&cont->user);"))

(define init-user-event-source (foreign-lambda void "al_init_user_event_source" event-source))

(define destroy-user-event-source (foreign-lambda void "al_destroy_user_event_source" event-source))

(define emit-user-event (foreign-lambda bool "al_emit_user_event" event-source event-container (function void ((c-pointer (struct ALLEGRO_USER_EVENT))))) )

(define unref-user-event (foreign-lambda void "al_unref_user_event" (c-pointer (struct ALLEGRO_USER_EVENT))))

(define event-source-data-set! (foreign-lambda void "al_set_event_source_data" event-source integer))

(define event-source-data (foreign-lambda integer "al_get_event_source_data" event-source))

(define create-event-queue (foreign-lambda event-queue "al_create_event_queue"))
(define destroy-event-queue (foreign-lambda void "al_destroy_event_queue" event-queue))

(define register-event-source (foreign-lambda void "al_register_event_source" event-queue event-source))
(define unregister-event-source (foreign-lambda void "al_unregister_event_source" event-queue event-source))

(define empty-event-queue? (foreign-lambda void "al_is_event_queue_empty" event-queue))

(define next-event! (foreign-lambda* bool ((event-container container) (event-queue q)) "
if (al_get_next_event(q, container))
  C_return(C_SCHEME_TRUE);
else
  C_return (C_SCHEME_FALSE);
"))

(define peek-event! (foreign-lambda* bool ((event-container container) (event-queue q)) "
if (al_peek_next_event(q, container))
  C_return(C_SCHEME_TRUE);
else
  C_return (C_SCHEME_FALSE);
"))

(define drop-event (foreign-lambda bool "al_drop_next_event" event-queue))
(define flush-event-queue (foreign-lambda void "al_flush_event_queue" event-queue))

(define wait-for-event! (foreign-lambda* void ((event-container container) (event-queue q)) "al_wait_for_event(q, container);"))

(define wait-for-event-timed! (foreign-lambda* bool ((event-container container)(event-queue q) (float s)) "
if (al_wait_for_event_timed(q, container, s))
  C_return(C_SCHEME_TRUE);
else
  C_return (C_SCHEME_FALSE);
"))

(define wait-for-event-until! (foreign-lambda* bool ((event-container container) (event-queue q) ((c-pointer (struct ALLEGRO_TIMEOUT)) t)) "
if (al_wait_for_event_until(q, container, t))
  C_return(C_SCHEME_TRUE);
else
  C_return(C_SCHEME_FALSE);
"))
