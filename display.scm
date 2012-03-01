(define display/new-refresh-rate-set! (foreign-lambda void "al_set_new_display_refresh_rate" integer))
(define display/new-display-flags-set! (foreign-lambda void "al_set_new_display_flags" integer))
(define display/new-refresh-rate (foreign-lambda integer "al_get_new_display_refresh_rate"))
(define display/new-display-flags (foreign-lambda integer "al_get_new_display_flags"))

(define display/width (foreign-lambda integer "al_get_display_width" display))
(define display/height (foreign-lambda integer "al_get_display_height" display))
(define display/format (foreign-lambda integer "al_get_display_format" display))
(define display/refresh-rate (foreign-lambda integer "al_get_display_refresh_rate" display))
(define display/display-flags (foreign-lambda integer "al_get_display_flags" display))
(define display/toggle-flag! (foreign-lambda bool "al_toggle_display_flag" display display-flag bool))

(define make-display (foreign-lambda display "al_create_display" integer integer))
(define free-display (foreign-lambda void "al_destroy_display" display))
(define display/current (foreign-lambda display "al_get_current_display"))
(define display/target-bitmap-set! (foreign-lambda void "al_set_target_bitmap" opaque_bitmap))
(define display/target-backbuffer-set! (foreign-lambda void "al_set_target_backbuffer" display))
(define display/backbuffer (foreign-lambda opaque_bitmap "al_get_backbuffer" display))
(define display/target-bitmap (foreign-lambda opaque_bitmap "al_get_target_bitmap"))

(define display/acknowledge-resize (foreign-lambda bool "al_acknowledge_resize" display))
(define display/resize (foreign-lambda bool "al_resize_display" display int int))
(define display/update-region (foreign-lambda void "al_update_display_region" int int int int))
(define display/compatible-bitmap? (foreign-lambda bool "al_is_compatible_bitmap" opaque_bitmap))

(define display/display-mode-count (foreign-lambda int "al_get_num_display_modes"))
(define display/mode (foreign-lambda display-mode "al_get_display_mode" int display-mode))

(define display/wait-for-vsync (foreign-lambda bool "al_wait_for_vsync"))

(define display/event-source (foreign-lambda opaque_event_source "al_get_display_event_source" display))

(define display/clear-to-color (foreign-lambda* void ((color c)) "al_clear_to_color(*c);"))

(define display/draw-pixel (foreign-lambda* void ((float x) (float y) (color c)) "al_draw_pixel(x, y, *c);"))

(define display/icon-set! (foreign-lambda void "al_set_display_icon" display opaque_bitmap))

(define display/video-adapter-count (foreign-lambda int "al_get_num_video_adapters"))
(define display/monitor-info! (foreign-lambda* bool ((monitor-info info) (int adapter)) #<<ENDC
if (al_get_monitor_info(adapter, info))
  C_return(C_SCHEME_TRUE);
else
  C_return(C_SCHEME_FALSE);
ENDC
))

(define display/new-display-adapter (foreign-lambda int "al_get_new_display_adapter"))
(define display/new-display-adapter-set! (foreign-lambda void "al_set_new_display_adapter" int))
(define display/new-window-position-x (foreign-lambda* int () #<<ENDC
int x, y;
al_get_new_window_position(&x, &y);
C_return(x);
ENDC
))
(define display/new-window-position-y (foreign-lambda* int () #<<ENDC
int x, y;
al_get_new_window_position(&x, &y);
C_return(y);
ENDC
))
(define display/new-window-position-set! (foreign-lambda void "al_set_new_window_position" int int))

(define display/window-title-set! (foreign-lambda void "al_set_window_title" display c-string))

(define display/new-display-option-set! (foreign-lambda void "al_set_new_display_option" display-option int display-option-importance))

(define display/new-display-option-value (foreign-lambda* int ((display-option opt)) #<<ENDC
int importance;
C_return(al_get_new_display_option(opt, &importance));
ENDC
))
(define display/new-display-option-importance (foreign-lambda* display-option-importance ((display-option opt)) #<<ENDC
int importance = 0;
al_get_new_display_option(opt, &importance);
C_return(importance);
ENDC
))

(define display/new-display-reset-options (foreign-lambda void "al_reset_new_display_options"))

(define display/display-option (foreign-lambda int "al_get_display_option" display display-option))

(define display/hold-bitmap-drawing (foreign-lambda void "al_hold_bitmap_drawing" bool))

(define display/bitmap-drawing-held? (foreign-lambda bool "al_is_bitmap_drawing_held"))
