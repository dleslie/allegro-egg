(define event/joystick-axis (foreign-value "ALLEGRO_EVENT_JOYSTICK_AXIS" integer))
(define event/joystick-button-down (foreign-value "ALLEGRO_EVENT_JOYSTICK_BUTTON_DOWN" integer))
(define event/joystick-button-up (foreign-value "ALLEGRO_EVENT_JOYSTICK_BUTTON_UP" integer))
(define event/joystick-configuration (foreign-value "ALLEGRO_EVENT_JOYSTICK_CONFIGURATION" integer))

(define event/key-down (foreign-value "ALLEGRO_EVENT_KEY_DOWN" integer))
(define event/key-up (foreign-value "ALLEGRO_EVENT_KEY_UP" integer))
(define event/key-char (foreign-value "ALLEGRO_EVENT_KEY_CHAR" integer))

(define event/mouse-axis (foreign-value "ALLEGRO_EVENT_MOUSE_AXES" integer))
(define event/mouse-button-down (foreign-value "ALLEGRO_EVENT_MOUSE_BUTTON_DOWN" integer))
(define event/mouse-button-up (foreign-value "ALLEGRO_EVENT_MOUSE_BUTTON_UP" integer))
(define event/mouse-enter (foreign-value "ALLEGRO_EVENT_MOUSE_ENTER_DISPLAY" integer))
(define event/mouse-leave (foreign-value "ALLEGRO_EVENT_MOUSE_LEAVE_DISPLAY" integer))
(define event/mouse-warped (foreign-value "ALLEGRO_EVENT_MOUSE_WARPED" integer))

(define event/timer (foreign-value "ALLEGRO_EVENT_TIMER" integer))

(define event/display-expose (foreign-value "ALLEGRO_EVENT_DISPLAY_EXPOSE" integer))
(define event/display-resize (foreign-value "ALLEGRO_EVENT_DISPLAY_RESIZE" integer))
(define event/display-close (foreign-value "ALLEGRO_EVENT_DISPLAY_CLOSE" integer))
(define event/display-lost (foreign-value "ALLEGRO_EVENT_DISPLAY_LOST" integer))
(define event/display-found (foreign-value "ALLEGRO_EVENT_DISPLAY_FOUND" integer))
(define event/display-switch-in (foreign-value "ALLEGRO_EVENT_DISPLAY_SWITCH_IN" integer))
(define event/display-switch-out (foreign-value "ALLEGRO_EVENT_DISPLAY_SWITCH_OUT" integer))
(define event/display-orientation (foreign-value "ALLEGRO_EVENT_DISPLAY_ORIENTATION" integer))

(define user-event-type? (foreign-lambda* bool ((integer event)) "C_return(ALLEGRO_EVENT_TYPE_IS_USER(event));"))

(define make-event-type (foreign-lambda* integer ((integer a) (integer b) (integer c) (integer d)) "C_return(ALLEGRO_GET_EVENT_TYPE(a, b, c, d));"))

(bind-opaque-type event_source (struct ALLEGRO_EVENT_SOURCE))

(bind-opaque-type event_source (struct ALLEGRO_EVENT_SOURCE))

(bind-rename ALLEGRO_EVENT_TYPE event-type)
(bind-rename ALLEGRO_ANY_EVENT any-event)
(bind-rename ALLEGRO_EVENT_SOURCE event-source)
(bind-rename ALLEGRO_JOYSTICK_EVENT joystick-event)
(bind-rename ALLEGRO_MOUSE_EVENT mouse-event)
(bind-rename ALLEGRO_TIMER_EVENT timer-event)
(bind-rename ALLEGRO_USER_EVENT user-event)

(bind* #<<ENDC
#ifdef CHICKEN
typedef unsigned int ALLEGRO_EVENT_TYPE;

typedef struct ALLEGRO_ANY_EVENT
{
        ALLEGRO_EVENT_TYPE type;
        ALLEGRO_EVENT_SOURCE *source;
        double timestamp;
} ALLEGRO_ANY_EVENT;

typedef struct ALLEGRO_JOYSTICK_EVENT
{
        ALLEGRO_EVENT_TYPE type;
        struct ALLEGRO_JOYSTICK *source;
        double timestamp;
        struct ALLEGRO_JOYSTICK *id;
        int stick;
        int axis;
        float pos;
        int button;
} ALLEGRO_JOYSTICK_EVENT;

typedef struct ALLEGRO_KEYBOARD_EVENT
{
        ALLEGRO_EVENT_TYPE type;
        struct ALLEGRO_KEYBOARD *source;
        double timestamp;
        struct ALLEGRO_DISPLAY *display;
        int keycode;
        int unichar;
        unsigned int modifiers;
        bool repeat;
} ALLEGRO_KEYBOARD_EVENT;

typedef struct ALLEGRO_MOUSE_EVENT
{
        ALLEGRO_EVENT_TYPE type;
        struct ALLEGRO_MOUSE *source;
        double timestamp;
        struct ALLEGRO_DISPLAY *display;
        int x,  y,  z, w;
        int dx, dy, dz, dw;
        unsigned int button;
        float pressure;
} ALLEGRO_MOUSE_EVENT;

typedef struct ALLEGRO_TIMER_EVENT
{
        ALLEGRO_EVENT_TYPE type;
        struct ALLEGRO_TIMER *source;
        double timestamp;
        int64_t count;
        double error;
} ALLEGRO_TIMER_EVENT;

typedef struct ALLEGRO_USER_EVENT ALLEGRO_USER_EVENT;
typedef int32_t intptr_t;

struct ALLEGRO_USER_EVENT
{
        ALLEGRO_EVENT_TYPE type;
        struct ALLEGRO_EVENT_SOURCE *source;
        double timestamp;
        struct ALLEGRO_USER_EVENT_DESCRIPTOR *__internal__descr;
        intptr_t data1;
        intptr_t data2;
        intptr_t data3;
        intptr_t data4;
};

#endif
ENDC
)

(define-foreign-record-type (event-container "ALLEGRO_EVENT")
  (constructor: make-event-container)
  (destructor: free-event-container))

(define event-container-type (foreign-lambda* integer ((event-container cont)) "C_return(cont->type);"))
(define event-container-any (foreign-lambda* (c-pointer (struct ALLEGRO_ANY_EVENT)) ((event-container cont)) "C_return(&cont->any);"))

(define event-container-display (foreign-lambda* (c-pointer (struct ALLEGRO_DISPLAY_EVENT)) ((event-container cont)) "C_return(&cont->display);"))

(define event-container-joystick (foreign-lambda* (c-pointer (struct ALLEGRO_JOYSTICK_EVENT)) ((event-container cont)) "C_return(&cont->joystick);"))

(define event-container-keyboard (foreign-lambda* (c-pointer (struct ALLEGRO_KEYBOARD_EVENT)) ((event-container cont)) "C_return(&cont->keyboard);"))

(define event-container-mouse (foreign-lambda* (c-pointer (struct ALLEGRO_MOUSE_EVENT)) ((event-container cont)) "C_return(&cont->mouse);"))

(define event-container-timer (foreign-lambda* (c-pointer (struct ALLEGRO_TIMER_EVENT)) ((event-container cont)) "C_return(&cont->timer);"))

(define event-container-user (foreign-lambda* (c-pointer (struct ALLEGRO_USER_EVENT)) ((event-container cont)) "C_return(&cont->user);"))

(define init-user-event-source (foreign-lambda void "al_init_user_event_source" (c-pointer event_source)))

(define destroy-user-event-source (foreign-lambda void "al_destroy_user_event_source" (c-pointer event_source)))

(define emit-user-event (foreign-lambda bool "al_emit_user_event" (c-pointer event_source) event-container (function void ((c-pointer (struct ALLEGRO_USER_EVENT))))) )

(define unref-user-event (foreign-lambda void "al_unref_user_event" (c-pointer (struct ALLEGRO_USER_EVENT))))

(define event-source-data-set! (foreign-lambda void "al_set_event_source_data" (c-pointer event_source) integer))

(define event-source-data (foreign-lambda integer "al_get_event_source_data" (c-pointer event_source)))

(bind-opaque-type event_queue (c-pointer (struct ALLEGRO_EVENT_QUEUE)))

(define create-event-queue (foreign-lambda event_queue "al_create_event_queue"))
(define destroy-event-queue (foreign-lambda void "al_destroy_event_queue" event_queue))

(define register-event-source (foreign-lambda void "al_register_event_source" event_queue (c-pointer event_source)))
(define unregister-event-source (foreign-lambda void "al_unregister_event_source" event_queue (c-pointer event_source)))

(define empty-event-queue? (foreign-lambda void "al_is_event_queue_empty" event_queue))

(define next-event (foreign-lambda* event-container ((event_queue q)) "
ALLEGRO_EVENT *ret = malloc(sizeof(ALLEGRO_EVENT));
if (al_get_next_event(q, ret))
  C_return(ret);
else
{
  free(ret);
  C_return (C_SCHEME_FALSE);
}
"))

(define peek-event (foreign-lambda* event-container ((event_queue q)) "
ALLEGRO_EVENT *ret = malloc(sizeof(ALLEGRO_EVENT));
if (al_peek_next_event(q, ret))
  C_return(ret);
else
{
  free(ret);
  C_return (C_SCHEME_FALSE);
}
"))

(define drop-event (foreign-lambda bool "al_drop_next_event" event_queue))
(define flush-event-queue (foreign-lambda void "al_flush_event_queue" event_queue))

(define wait-for-event (foreign-lambda* event-container ((event_queue q)) "
ALLEGRO_EVENT *ret = malloc(sizeof(ALLEGRO_EVENT));
al_wait_for_event(q, ret);
C_return(ret);
"))

(define wait-for-event-timed (foreign-lambda* event-container ((event_queue q) (float s)) "
ALLEGRO_EVENT *ret = malloc(sizeof(ALLEGRO_EVENT));
if (al_wait_for_event_timed(q, ret, s))
  C_return(ret);
else
{
  free(ret);
  C_return (C_SCHEME_FALSE);
}
"))

(define wait-for-event-until (foreign-lambda* event-container ((event_queue q) ((c-pointer (struct ALLEGRO_TIMEOUT)) t)) "
ALLEGRO_EVENT *ret = malloc(sizeof(ALLEGRO_EVENT));
if (al_wait_for_event_until(q, ret, t))
  C_return(ret);
else
{
  free(ret);
  C_return(C_SCHEME_FALSE);
}
"))
