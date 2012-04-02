(define mouse-addon-installed? (foreign-lambda bool "al_is_mouse_installed"))
(define mouse-addon-install (foreign-lambda bool "al_install_mouse"))
(define mouse-addon-uninstall (foreign-lambda void "al_uninstall_mouse"))

(define mouse-button-count (foreign-lambda unsigned-integer32 "al_get_mouse_num_buttons"))
(define mouse-axes-count (foreign-lambda unsigned-integer32 "al_get_mouse_num_axes"))
(define mouse-xy-set! (foreign-lambda bool "al_set_mouse_xy" display integer integer))
(define mouse-z-set! (foreign-lambda bool "al_set_mouse_z" integer))
(define mouse-w-set! (foreign-lambda bool "al_set_mouse_w" integer))
(define mouse-axis-set! (foreign-lambda bool "al_set_mouse_axis" integer integer))
(define mouse-event-source (foreign-lambda event-source "al_get_mouse_event_source"))

(define mouse-state-init! (foreign-lambda* void ((mouse-state state)) "al_get_mouse_state(state);"))
(define mouse-state-button-down (foreign-lambda bool "al_mouse_button_down" mouse-state integer))
(define mouse-state-axis (foreign-lambda integer "al_get_mouse_state_axis" mouse-state integer))

(define make-cursor* (foreign-lambda cursor "al_create_mouse_cursor" bitmap integer integer))
(define (make-cursor bmp i1 i2)
  (let ((c (make-cursor* bmp i1 i2)))
    (set-finalizer! c free-cursor!)
    c))

(define free-cursor! (foreign-lambda void "al_destroy_mouse_cursor" mouse-cursor))

(define mouse-cursor-position (foreign-safe-lambda* scheme-object () "
int x, y;
if (al_get_mouse_cursor_position(&x, &y))
{
   C_word *ptr = C_alloc(C_SIZEOF_LIST (2));
   C_return(C_list(&ptr, 2, C_fix(x), C_fix(y)));
}
else
   C_return(C_SCHEME_FALSE);
"))

(define mouse-ungrab (foreign-lambda bool "al_ungrab_mouse"))

(define display-grab-mouse! (foreign-lambda bool "al_grab_mouse" display))
(define display-cursor-set! (foreign-lambda bool "al_set_mouse_cursor" display mouse-cursor))
(define display-show-cursor! (foreign-lambda bool "al_show_mouse_cursor" display))
(define display-hide-cursor! (foreign-lambda bool "al_hide_mouse_cursor" display))

(define display-system-mouse-cursor-set! (foreign-lambda bool "al_set_system_mouse_cursor" display cursor-type))
