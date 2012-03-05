(define acodec-addon-init (foreign-lambda bool "al_init_acodec_addon"))
(define acodec-addon-version (foreign-lambda unsigned-integer32 "al_get_allegro_acodec_version"))
