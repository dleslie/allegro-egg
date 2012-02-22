(define-record version
  major sub wip release-number string date-string date int)

(define-foreign-record-type (timeout "ALLEGRO_TIMEOUT")
  (constructor: make-timeout)
  (destructor: free-timeout))

(define-foreign-record-type (event-container "ALLEGRO_EVENT")
  (constructor: make-event-container)
  (destructor: free-event-container))

(define-foreign-record-type (mouse-state "ALLEGRO_MOUSE_STATE")
  (constructor: make-mouse-state)
  (destructor: free-mouse-state)
  (int x x)
  (int y y)
  (int z z)
  (int w w)
  (int (more_axes mouse/max-extra-axis) more-axis)
  (int buttons buttons)
  (float pressure pressure)
  (display_info display display))

(bind-rename _AL_DRIVER_INFO driver-info)
(bind* #<<ENDC
#ifdef CHICKEN
typedef struct _AL_DRIVER_INFO      /* info about a hardware driver */
{
   int id;                          /* integer ID */
   void *driver;                    /* the driver structure */
   int autodetect;                  /* set to allow autodetection */
} _AL_DRIVER_INFO;
#endif
ENDC
)

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

(bind-opaque-type system (c-pointer (struct ALLEGRO_SYSTEM)))
(bind-opaque-type config (c-pointer (struct ALLEGRO_CONFIG)))
(bind-opaque-type path (c-pointer (struct ALLEGRO_PATH)))
(bind-opaque-type file (c-pointer (struct ALLEGRO_FILE)))
(bind-opaque-type config_section (c-pointer (struct ALLEGRO_CONFIG_SECTION)))
(bind-opaque-type config_entry (c-pointer (struct ALLEGRO_CONFIG_ENTRY)))
;(bind-opaque-type utf_string (c-pointer (struct ALLEGRO_USTR)))
(bind-opaque-type utf_string (c-pointer (struct _al_tagbstring)))
(bind-opaque-type utf_string_info (c-pointer (struct _al_tagbstring)))
(bind-opaque-type event_source (struct ALLEGRO_EVENT_SOURCE))
(bind-opaque-type event_queue (c-pointer (struct ALLEGRO_EVENT_QUEUE)))
(bind-opaque-type mouse_info (c-pointer (struct ALLEGRO_MOUSE)))
(bind-opaque-type display_info (c-pointer (struct ALLEGRO_DISPLAY)))
(bind-opaque-type mouse_cursor (c-pointer (struct ALLEGRO_MOUSE_CURSOR)))
