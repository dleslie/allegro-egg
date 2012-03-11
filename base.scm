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
  (init-this (list 'allegro 'audio 'font 'image 'joystick 'keyboard 'mouse 'primitives 'ttf)))

(define (init-symbol x)
  (cond
   ((eq? 'allegro x) (init))
   ((eq? 'audio x) (audio-addon-install))
   ((eq? 'font x) (font-addon-install))
   ((eq? 'image x) (image-addon-install))
   ((eq? 'joystick x) (joystick-addon-install))
   ((eq? 'keyboard x) (keyboard-addon-install))
   ((eq? 'mouse x) (mouse-addon-install))
   ((eq? 'primitives x) (primitives-addon-install))
   ((eq? 'ttf x) (ttf-addon-install))
   (else #f)))

(define (init-this x)
  (cond
   ((list? x) (map init-this x))
   ((symbol? x) (list x (init-symbol x)))
   (else #f)))

(define (uninstall-everything)
  (uninstall-this (list 'system 'audio 'font 'image 'joystick 'keyboard 'mouse 'primitives 'ttf)))

(define (uninstall-this x)
  (cond
   ((list? x) (map uninstall-this x))
   ((symbol? x) (list x (uninstall-symbol x)))
   (else #f)))

(define (uninstall-symbol x)
  (cond
   ((eq? 'system x) (system-addon-uninstall))
   ((eq? 'audio x) (audio-addon-uninstall))
   ((eq? 'font x) (font-addon-uninstall))
   ((eq? 'image x) (image-addon-uninstall))
   ((eq? 'joystick x) (joystick-addon-uninstall))
   ((eq? 'keyboard x) (keyboard-addon-uninstall))
   ((eq? 'mouse x) (mouse-addon-uninstall))
   ((eq? 'primitives x) (primitives-addon-uninstall))
   ((eq? 'ttf x) (ttf-addon-uninstall))
   (else #f)))
