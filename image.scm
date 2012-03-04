(define image-addon-init (foreign-lambda bool "al_init_image_addon"))
(define image-addon-shutdown (foreign-lambda void "al_shutdown_image_addon"))
(define image-addon-version (foreign-lambda unsigned-integer32 "al_get_allegro_image_version"))
