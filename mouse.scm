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

(define make-cursor (foreign-lambda opaque_cursor "al_create_mouse_cursor" opaque_bitmap integer integer))
(define free-cursor (foreign-lambda void "al_destroy_mouse_cursor" opaque_mouse_cursor))

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

(define mouse-cursor-set! (foreign-lambda bool "al_set_mouse_cursor" opaque_display_info opaque_mouse_cursor))
(define mouse-show-cursor (foreign-lambda bool "al_show_mouse_cursor" opaque_display_info))
(define mouse-hide-cursor (foreign-lambda bool "al_hide_mouse_cursor" opaque_display_info))
