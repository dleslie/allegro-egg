(define build-version 
  (make-version 
   (foreign-value "ALLEGRO_VERSION" integer)
   (foreign-value "ALLEGRO_SUB_VERSION" integer)
   (foreign-value "ALLEGRO_WIP_VERSION" integer)
   (foreign-value "ALLEGRO_RELEASE_NUMBER" integer)
   (foreign-value "ALLEGRO_VERSION_STR" c-string)
   (foreign-value "ALLEGRO_DATE_STR" c-string)
   (foreign-value "ALLEGRO_DATE" integer)
   (foreign-value "ALLEGRO_VERSION_INT" unsigned-integer32)))

(define pi (foreign-value "ALLEGRO_PI" integer32))

(define make-id (foreign-lambda* unsigned-integer32 ((unsigned-integer32 a) (unsigned-integer32 b) (unsigned-integer32 c) (unsigned-integer32 d)) "C_return(AL_ID(a, b, c, d));"))

(define run-main (foreign-safe-lambda int "al_run_main" integer (c-pointer c-string) (function integer (integer (c-pointer c-string)))))

(define (init-everything)
  (init)
  (system-addon-install)
  (audio-addon-install)
  (font-addon-install)
  (image-addon-install)
  (joystick-addon-install)
  (keyboard-addon-install)
  (mouse-addon-install)
  (primitives-addon-install)
  (ttf-addon-install))
