(define-record version
  major sub wip release-number string date-string date int)

(define-foreign-record-type (system "ALLEGRO_SYSTEM"))
(define-foreign-record-type (config "ALLEGRO_CONFIG"))
(define-foreign-record-type (path "ALLEGRO_PATH"))
(define-foreign-record-type (file "ALLEGRO_FILE"))
(define-foreign-record-type (config-section "ALLEGRO_CONFIG_SECTION"))
(define-foreign-record-type (config-entry "ALLEGRO_CONFIG_ENTRY"))
(define-foreign-record-type (utf-string "ALLEGRO_USTR"))
(define-foreign-record-type (event-queue "ALLEGRO_EVENT_QUEUE"))
(define-foreign-record-type (mouse "ALLEGRO_MOUSE"))
(define-foreign-record-type (display "ALLEGRO_DISPLAY"))
(define-foreign-record-type (mouse-cursor "ALLEGRO_MOUSE_CURSOR"))
(define-foreign-record-type (timer "ALLEGRO_TIMER"))
(define-foreign-record-type (bitmap "ALLEGRO_BITMAP"))
(define-foreign-record-type (cursor "ALLEGRO_CURSOR"))
(define-foreign-record-type (file-interface "ALLEGRO_FILE_INTERFACE"))
(define-foreign-record-type (vertex-declaration "ALLEGRO_VERTEX_DECL"))
(define-foreign-record-type (thread "ALLEGRO_THREAD"))
(define-foreign-record-type (mutex "ALLEGRO_MUTEX"))
(define-foreign-record-type (condition "ALLEGRO_COND"))
(define-foreign-record-type (joystick "ALLEGRO_JOYSTICK"))
(define-foreign-record-type (display "ALLEGRO_DISPLAY"))
(define-foreign-record-type (keyboard "ALLEGRO_KEYBOARD"))
(define-foreign-record-type (event-source "ALLEGRO_EVENT_SOURCE"))

(define-foreign-record-type (vertex "ALLEGRO_VERTEX")
  (constructor: make-vertex)
  (destructor: free-vertex)
  (float x vertex-x)
  (float y vertex-y)
  (float z vertex-z)
  (float u vertex-u)
  (float v vertex-v))

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

(define-foreign-record-type (monitor "ALLEGRO_MONITOR_INFO")
  (constructor: make-monitor)
  (destructor: free-monitor)
  (int x1 monitor-x1)
  (int y1 monitor-y1)
  (int x2 monitor-x2)
  (int y2 monitor-y2))

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

(define-foreign-record-type (keyboard-state "ALLEGRO_KEYBOARD_STATE")
  (constructor: make-keyboard-state)
  (destructor: free-keyboard-state)
  (display display keyboard-state-display))

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
  (display display mouse-state-display))

(define-foreign-record-type (driver "_AL_DRIVER_INFO")
  (constructor: make-driver)
  (destructor: free-driver)
  (int id driver-id)
  (c-pointer driver driver-driver)
  (int autodetect driver-autodetect))

(define-foreign-record-type (any-event "ALLEGRO_ANY_EVENT")
  (constructor: make-any-event)
  (destructor: free-any-event)
  (event-type type any-event-type)
  (event-source source any-event-source)
  (double timestamp any-event-timestamp))

(define-foreign-record-type (joystick-event "ALLEGRO_JOYSTICK_EVENT")
  (constructor: make-joystick-event)
  (destructor: free-joystick-event)
  (event-type type joystick-event-type)
  (joystick source joystick-event-source)
  (double timestamp joystick-event-timestamp)
  (joystick id joystick-event-id)
  (int stick joystick-event-stick)
  (int axis joystick-event-axis)
  (float pos joystick-event-position)
  (int button joystick-event-button))

(define-foreign-record-type (keyboard-event "ALLEGRO_KEYBOARD_EVENT")
  (constructor: make-keyboard-event)
  (destructor: free-keyboard-event)
  (event-type type keyboard-event-type)
  (keyboard source keyboard-event-source)
  (double timestamp keyboard-event-timestamp)
  (display display keyboard-event-display)
  (int keycode keyboard-event-keycode)
  (int unichar keyboard-event-unichar)
  (unsigned-integer32 modifiers keyboard-event-modifiers)
  (bool repeat keyboard-event-repeat))

(define-foreign-record-type (mouse-event "ALLEGRO_MOUSE_EVENT")
  (constructor: make-mouse-event)
  (destructor: free-mouse-event)
  (event-type type mouse-event-type)
  (mouse source mouse-event-source)
  (double timestamp mouse-event-timestamp)
  (display display mouse-event-display)
  (int x mouse-event-x)
  (int y mouse-event-y)
  (int z mouse-event-z)
  (int w mouse-event-w)
  (int dx mouse-event-dx)
  (int dy mouse-event-dy)
  (int dz mouse-event-dz)
  (int dw mouse-event-dw)
  (unsigned-integer32 button mouse-event-button)
  (float pressure mouse-event-pressure))

(define-foreign-record-type (timer-event "ALLEGRO_TIMER_EVENT")
  (constructor: make-timer-event)
  (destructor: free-timer-event)
  (event-type type timer-event-type)
  (timer source timer-event-source)
  (double timestamp timer-event-timestamp)
  (integer64 count timer-event-count)
  (double error timer-event-error))

(define-foreign-record-type (user-event "ALLEGRO_USER_EVENT")
  (constructor: make-user-event)
  (destructor: free-user-event)
  (event-type type user-event-type)
  (event-source source user-event-source)
  (double timestamp user-event-timestamp)
  (integer32 data1 user-event-data1)
  (integer32 data2 user-event-data2)
  (integer32 data3 user-event-data3)
  (integer32 data4 user-event-data4))
