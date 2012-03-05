(define-record version
  major sub wip release-number string date-string date int)

(define-foreign-record-type (vertex "ALLEGRO_VERTEX")
  (constructor: make-vertex)
  (destructor: free-vertex)
  (float x vertex-x)
  (float y vertex-y)
  (float z vertex-z)
  (float u vertex-u)
  (float v vertex-v))

(define-foreign-record-type (vertex-declaration "ALLEGRO_VERTEX_DECL"))

(define-foreign-record-type (vertex-element "ALLEGRO_VERTEX_ELEMENT")
  (constructor: make-vertex-element)
  (destructor: free-vertex-element)
  (integer attribute vertex-element-attribute)
  (integer storage vertex-element-storage)
  (integer offset vertex-element-offset))

(define-foreign-record-type (font "ALLEGRO_FONT")
  (destructor: free-font)
  (c-pointer data font-data)
  (int height font-height))

(define-foreign-record-type (memory-interface "ALLEGRO_MEMORY_INTERFACE")
  (constructor: make-memory-interface)
  (destructor: free-memory-interface)
  ((function c-pointer (integer32 integer (const c-string) (const c-string))) mi_malloc memory-interface-malloc)
  ((function void (c-pointer integer (const c-string) (const c-string))) mi_free memory-interface-free)
  ((function c-pointer (c-pointer integer32 integer (const c-string) (const c-string))) mi_realloc memory-interface-realloc)
  ((function c-pointer (integer32 integer32 integer (const c-string) (const c-string))) mi_calloc memory-interface-calloc))

(define-foreign-record-type (fs-interface "ALLEGRO_FS_INTERFACE")
;  (constructor: make-fs-interface)
  (destructor: free-fs-interface)
  ((function fs-entry ((const c-string))) fs_create_entry fs-interface-create-entry)
  ((function void (fs-entry)) fs_destroy_entry fs-interface-destroy-entry)
  ((function (const c-string) (fs-entry)) fs_entry_name fs-interface-entry-name)
  ((function bool (fs-entry)) fs_update_entry fs-interface-update-entry)
  ((function unsigned-integer32 (fs-entry)) fs_entry_mode fs-interface-entry-mode)
  ((function time_t (fs-entry)) fs_entry_atime fs-interface-entry-atime)
  ((function time_t (fs-entry)) fs_entry_mtime fs-interface-entry-mtime)
  ((function time_t (fs-entry)) fs_entry_ctime fs-interface-entry-ctime)
  ((function off_t (fs-entry)) fs_entry_size fs-interface-entry-size)
  ((function bool (fs-entry)) fs_entry_exists fs-interface-entry-exists?)
  ((function bool (fs-entry)) fs_remove_entry fs-interface-remove-entry)
  ((function bool (fs-entry)) fs_open_directory fs-interface-open-directory)
  ((function fs-entry (fs-entry)) fs_read_directory fs-interface-read-directory)
  ((function bool (fs-entry)) fs_close_directory fs-interface-close-directory)
  ((function bool ((const c-string))) fs_filename_exists fs-interface-filename-exists?)
  ((function bool ((const c-string))) fs_remove_filename fs-interface-remove-filename)
  ((function c-string ()) fs_get_current_directory fs-interface-current-directory)
  ((function bool ((const c-string))) fs_change_directory fs-interface-change-directory)
  ((function bool ((const c-string))) fs_make_directory fs-interface-make-directory)
  ((function file (fs-entry (const c-string))) fs_open_file fs-interface-open-file))

(define-foreign-record-type (fs-entry "ALLEGRO_FS_ENTRY")
;  (constructor: make-fs-entry)
;  (destructor: free-fs-entry)
  ((const c-pointer) vtable fs-entry-vtable))

(define-foreign-record-type (state "ALLEGRO_STATE")
  (constructor: make-state)
  (destructor: free-state))

(define-foreign-record-type (thread "ALLEGRO_THREAD"))
(define-foreign-record-type (mutex "ALLEGRO_MUTEX"))
(define-foreign-record-type (condition "ALLEGRO_COND"))

(define-foreign-record-type (transform "ALLEGRO_TRANSFORM")
  (constructor: make-transform)
  (destructor: free-transform))
(define transform-value (foreign-lambda* float ((transform t) (int i) (int j)) "C_return(t->m[i][j]);"))

(define-foreign-record-type (locked-region "ALLEGRO_LOCKED_REGION")
  (constructor: make-locked-region)
  (destructor: free-locked-region)
  (c-pointer data locked-region-data)
  (pixel-format format locked-region-format)
  (int pitch locked-region-pitch)
  (int pixel_size locked-region-pixel-size))

(define-foreign-record-type (color "ALLEGRO_COLOR")
  (constructor: make-color)
  (destructor: free-color)
  (float r color-red)
  (float g color-green)
  (float b color-blue)
  (float a color-alpha))

(define-foreign-record-type (display-mode "ALLEGRO_DISPLAY_MODE")
  (constructor: make-display-mode)
  (destructor: free-display-mode)
  (int width display-mode-width)
  (int height display-mode-height)
  (int format display-mode-format)
  (int refresh_rate display-mode-refresh-rate))

(define-foreign-record-type (monitor-info "ALLEGRO_MONITOR_INFO")
  (constructor: make-monitor-info)
  (destructor: free-monitor-info)
  (int x1 monitor-info-x1)
  (int y1 monitor-info-y1)
  (int x2 monitor-info-x2)
  (int y2 monitor-info-y2))

(define-foreign-record-type (display "ALLEGRO_DISPLAY"))

(define-foreign-record-type (joystick "ALLEGRO_JOYSTICK"))
(define-foreign-record-type (joystick-state "ALLEGRO_JOYSTICK_STATE")
  (constructor: make-joystick-state)
  (destructor: free-joystick-state)
  ;((float joystick-max-axes) (axis joystick-max-sticks) joystick-state-axis)
  (int (button joystick-max-buttons) jostick-state-button))
(define joystick-state-axis (foreign-lambda* float ((joystick-state jstate) (int which_stick) (int which_axis)) "
if (which_stick < 0 || which_stick >= _AL_MAX_JOYSTICK_STICKS || which_axis < 0 || which_axis >= _AL_MAX_JOYSTICK_AXES)
  C_return(C_SCHEME_FALSE);
else
  C_return(jstate->stick[which_stick].axis[which_axis]);
")) 

(define-foreign-record-type (keyboard "ALLEGRO_KEYBOARD"))
(define-foreign-record-type (keyboard-state "ALLEGRO_KEYBOARD_STATE")
  (constructor: make-keyboard-state)
  (destructor: free-keyboard-state)
  (opaque_display_info display keyboard-state-display))

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
  (int (more_axes mouse-max-extra-axis) mouse-state-axis)
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
(bind-opaque-type opaque_file_interface (c-pointer (struct ALLEGRO_FILE_INTERFACE)))
