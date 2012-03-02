(define mouse-max-extra-axis (foreign-value ALLEGRO_MOUSE_MAX_EXTRA_AXES integer))

(define mouse-cursor-none (foreign-value "ALLEGRO_SYSTEM_MOUSE_CURSOR_NONE" integer))
(define mouse-cursor-default (foreign-value "ALLEGRO_SYSTEM_MOUSE_CURSOR_DEFAULT" integer))
(define mouse-cursor-arrow (foreign-value "ALLEGRO_SYSTEM_MOUSE_CURSOR_ARROW" integer))
(define mouse-cursor-busy (foreign-value "ALLEGRO_SYSTEM_MOUSE_CURSOR_BUSY" integer))
(define mouse-cursor-question (foreign-value "ALLEGRO_SYSTEM_MOUSE_CURSOR_QUESTION" integer))
(define mouse-cursor-edit (foreign-value "ALLEGRO_SYSTEM_MOUSE_CURSOR_EDIT" integer))
(define mouse-cursor-move (foreign-value "ALLEGRO_SYSTEM_MOUSE_CURSOR_MOVE" integer))
(define mouse-cursor-resize-n (foreign-value "ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_N" integer))
(define mouse-cursor-resize-w (foreign-value "ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_W" integer))
(define mouse-cursor-resize-s (foreign-value "ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_S" integer))
(define mouse-cursor-resize-e (foreign-value "ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_E" integer))
(define mouse-cursor-resize-nw (foreign-value "ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_NW" integer))
(define mouse-cursor-resize-sw (foreign-value "ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_SW" integer))
(define mouse-cursor-resize-se (foreign-value "ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_SE" integer))
(define mouse-cursor-resize-ne (foreign-value "ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_NE" integer))
(define mouse-cursor-progress (foreign-value "ALLEGRO_SYSTEM_MOUSE_CURSOR_PROGRESS" integer))
(define mouse-cursor-precision (foreign-value "ALLEGRO_SYSTEM_MOUSE_CURSOR_PRECISION" integer))
(define mouse-cursor-link (foreign-value "ALLEGRO_SYSTEM_MOUSE_CURSOR_LINK" integer))
(define mouse-cursor-alt-select (foreign-value "ALLEGRO_SYSTEM_MOUSE_CURSOR_ALT_SELECT" integer))
(define mouse-cursor-unavailable (foreign-value "ALLEGRO_SYSTEM_MOUSE_CURSOR_UNAVAILABLE" integer))
(define mouse-cursor-count (foreign-value "ALLEGRO_NUM_SYSTEM_MOUSE_CURSORS" integer))

(define mouse-installed? (foreign-lambda bool "al_is_mouse_installed"))
(define mouse-install (foreign-lambda bool "al_install_mouse"))
(define mouse-uninstall (foreign-lambda void "al_uninstall_mouse"))
(define mouse-button-count (foreign-lambda unsigned-integer32 "al_get_mouse_num_buttons"))
(define mouse-axes-count (foreign-lambda unsigned-integer32 "al_get_mouse_num_axes"))
(define mouse-xy-set! (foreign-lambda bool "al_set_mouse_xy" opaque_display_info integer integer))
(define mouse-z-set! (foreign-lambda bool "al_set_mouse_z" integer))
(define mouse-w-set! (foreign-lambda bool "al_set_mouse_w" integer))
(define mouse-axis-set! (foreign-lambda bool "al_set_mouse_axis" integer integer))
(define mouse-state! (foreign-lambda* void ((mouse-state state)) "al_get_mouse_state(state);"))
(define mouse-button-down (foreign-lambda bool "al_mouse_button_down" mouse-state integer))
(define mouse-axis (foreign-lambda integer "al_get_mouse_state_axis" mouse-state integer))

(define mouse-event-source (foreign-lambda opaque_event_source "al_get_mouse_event_source"))

(define mouse-make-cursor (foreign-lambda opaque_cursor "al_create_mouse_cursor" opaque_bitmap integer integer))
(define mouse-free-cursor (foreign-lambda void "al_destroy_mouse_cursor" opaque_mouse_cursor))
(define mouse-cursor-set! (foreign-lambda bool "al_set_mouse_cursor" opaque_display_info opaque_mouse_cursor))
(define mouse-show-cursor (foreign-lambda bool "al_show_mouse_cursor" opaque_display_info))
(define mouse-hide-cursor (foreign-lambda bool "al_hide_mouse_cursor" opaque_display_info))
(define mouse-cursor-xposition (foreign-lambda* integer () "
int x, y;
if (al_get_mouse_cursor_position(&x, &y))
   C_return(x);
else
   C_return(C_SCHEME_FALSE);
"))
(define mouse-cursor-yposition (foreign-lambda* integer () "
int x, y;
if (al_get_mouse_cursor_position(&x, &y))
   C_return(y);
else
   C_return(C_SCHEME_FALSE);
"))
(define mouse-grab (foreign-lambda bool "al_grab_mouse" opaque_display_info))
(define mouse-ungrab (foreign-lambda bool "al_ungrab_mouse"))
