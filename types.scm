(define-record version
  major sub wip release-number string date-string date int)

(define-foreign-record-type (keyboard "ALLEGRO_KEYBOARD"))
(define-foreign-record-type (keyboard-state "ALLEGRO_KEYBOARD_STATE")
  (constructor: make-keyboard-state)
  (destructor: free-keyboard-state)
  (opaque_display_info display keyboard-state/display))

(define-foreign-record-type (timeout "ALLEGRO_TIMEOUT")
  (constructor: make-timeout)
  (destructor: free-timeout))

(define-foreign-record-type (event-container "ALLEGRO_EVENT")
  (constructor: make-event-container)
  (destructor: free-event-container))

(define-foreign-record-type (mouse-state "ALLEGRO_MOUSE_STATE")
  (constructor: make-mouse-state)
  (destructor: free-mouse-state)
  (int x mouse-state-x)
  (int y mouse-state-y)
  (int z mouse-state-z)
  (int w mouse-state-w)
  (int (more_axes mouse/max-extra-axis) mouse-state-axis)
  (int buttons mouse-state-buttons)
  (float pressure mouse-state-pressure)
  (opaque_display_info display mouse-state-display))

(define-foreign-record-type (driver-info "_AL_DRIVER_INFO")
  (constructor: make-driver-info)
  (destructor: free-driver-info)
  (int id driver-info-id)
  (c-pointer driver driver-info-driver)
  (int autodetect driver-info-autodetect))

(bind-rename/pattern "ALLEGRO_EVENT_TYPE" "event-type")
(bind-rename/pattern "ALLEGRO_ANY_EVENT" "any-event")
(bind-rename/pattern "ALLEGRO_EVENT_SOURCE" "event-source")
(bind-rename/pattern "ALLEGRO_JOYSTICK_EVENT" "joystick-event")
(bind-rename/pattern "ALLEGRO_KEYBOARD_EVENT" "keyboard-event")
(bind-rename/pattern "ALLEGRO_MOUSE_EVENT" "mouse-event")
(bind-rename/pattern "ALLEGRO_TIMER_EVENT" "timer-event")
(bind-rename/pattern "ALLEGRO_USER_EVENT" "user-event")
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

(bind-opaque-type opaque_system (c-pointer (struct ALLEGRO_SYSTEM)))
(bind-opaque-type opaque_config (c-pointer (struct ALLEGRO_CONFIG)))
(bind-opaque-type opaque_path (c-pointer (struct ALLEGRO_PATH)))
(bind-opaque-type opaque_file (c-pointer (struct ALLEGRO_FILE)))
(bind-opaque-type opaque_config_section (c-pointer (struct ALLEGRO_CONFIG_SECTION)))
(bind-opaque-type opaque_config_entry (c-pointer (struct ALLEGRO_CONFIG_ENTRY)))
(bind-opaque-type opaque_utf_string (c-pointer (struct _al_tagbstring)))
(bind-opaque-type opaque_utf_string_info (c-pointer (struct _al_tagbstring)))
(bind-opaque-type opaque_event_source (c-pointer (struct ALLEGRO_EVENT_SOURCE)))
(bind-opaque-type opaque_event_queue (c-pointer (struct ALLEGRO_EVENT_QUEUE)))
(bind-opaque-type opaque_mouse_info (c-pointer (struct ALLEGRO_MOUSE)))
(bind-opaque-type opaque_display_info (c-pointer (struct ALLEGRO_DISPLAY)))
(bind-opaque-type opaque_mouse_cursor (c-pointer (struct ALLEGRO_MOUSE_CURSOR)))
(bind-opaque-type opaque_timer (c-pointer (struct ALLEGRO_TIMER)))
(bind-opaque-type opaque_bitmap (c-pointer (struct ALLEGRO_BITMAP)))
(bind-opaque-type opaque_cursor (c-pointer (struct ALLEGRO_CURSOR)))






