(define display/default-refresh-rate-set! (foreign-lambda void "al_set_new_display_refresh_rate" integer))
(define display/default-display-flags-set! (foreign-lambda void "al_set_new_display_flags" integer))
(define display/default-refresh-rate (foreign-lambda integer "al_get_new_display_refresh_rate"))
(define display/default-display-flags (foreign-lambda integer "al_get_new_display_flags"))

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

;; AL_FUNC(bool, al_acknowledge_resize, (ALLEGRO_DISPLAY *display));
;; AL_FUNC(bool, al_resize_display,     (ALLEGRO_DISPLAY *display, int width, int height));
;; AL_FUNC(void, al_flip_display,       (void));
;; AL_FUNC(void, al_update_display_region, (int x, int y, int width, int height));
;; AL_FUNC(bool, al_is_compatible_bitmap, (ALLEGRO_BITMAP *bitmap));

;; AL_FUNC(int, al_get_num_display_modes, (void));
;; AL_FUNC(ALLEGRO_DISPLAY_MODE*, al_get_display_mode, (int index,
;;         ALLEGRO_DISPLAY_MODE *mode));

;; AL_FUNC(bool, al_wait_for_vsync, (void));

;; AL_FUNC(ALLEGRO_EVENT_SOURCE *, al_get_display_event_source, (ALLEGRO_DISPLAY *display));

;; /* Primitives */
;; AL_FUNC(void, al_clear_to_color, (ALLEGRO_COLOR color));
;; AL_FUNC(void, al_draw_pixel, (float x, float y, ALLEGRO_COLOR color));

;; AL_FUNC(void, al_set_display_icon, (ALLEGRO_DISPLAY *display, ALLEGRO_BITMAP *icon));

;; /* Stuff for multihead/window management */
;; AL_FUNC(int, al_get_num_video_adapters, (void));
;; AL_FUNC(bool, al_get_monitor_info, (int adapter, ALLEGRO_MONITOR_INFO *info));
;; AL_FUNC(int, al_get_new_display_adapter, (void));
;; AL_FUNC(void, al_set_new_display_adapter, (int adapter));
;; AL_FUNC(void, al_set_new_window_position, (int x, int y));
;; AL_FUNC(void, al_get_new_window_position, (int *x, int *y));
;; AL_FUNC(void, al_set_window_position, (ALLEGRO_DISPLAY *display, int x, int y));
;; AL_FUNC(void, al_get_window_position, (ALLEGRO_DISPLAY *display, int *x, int *y));

;; AL_FUNC(void, al_set_window_title, (ALLEGRO_DISPLAY *display, const char *title));

;; /* Defined in display_settings.c */
;; AL_FUNC(void, al_set_new_display_option, (int option, int value, int importance));
;; AL_FUNC(int, al_get_new_display_option, (int option, int *importance));
;; AL_FUNC(void, al_reset_new_display_options, (void));
;; AL_FUNC(int, al_get_display_option, (ALLEGRO_DISPLAY *display, int option));

;; /*Deferred drawing*/
;; AL_FUNC(void, al_hold_bitmap_drawing, (bool hold));
;; AL_FUNC(bool, al_is_bitmap_drawing_held, (void));
