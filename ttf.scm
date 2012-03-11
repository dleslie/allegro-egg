(define load-ttf (foreign-lambda font "al_load_ttf_font" (const c-string) integer integer))
(define load-ttf-from-file (foreign-lambda font "al_load_ttf_font_f" file (const c-string) integer font-align))

(define ttf-addon-install (foreign-lambda bool "al_init_ttf_addon"))
(define ttf-addon-uninstall (foreign-lambda void "al_shutdown_ttf_addon"))
(define ttf-addon-version (foreign-lambda unsigned-integer32 "al_get_allegro_ttf_version"))
