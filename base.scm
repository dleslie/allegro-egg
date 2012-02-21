;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Types
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-record version
  major sub wip release-number string date-string date int)

(bind-rename _AL_DRIVER_INFO driver-info)
(bind* #<<ENDC
#ifdef CHICKEN
typedef struct _AL_DRIVER_INFO      /* info about a hardware driver */
{
   int id;                          /* integer ID */
   void *driver;                    /* the driver structure */
   int autodetect;                  /* set to allow autodetection */
} _AL_DRIVER_INFO;
#endif
ENDC
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Methods
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define base/version 
  (make-version 
   (foreign-value "ALLEGRO_VERSION" integer)
   (foreign-value "ALLEGRO_SUB_VERSION" integer)
   (foreign-value "ALLEGRO_WIP_VERSION" integer)
   (foreign-value "ALLEGRO_RELEASE_NUMBER" integer)
   (foreign-value "ALLEGRO_VERSION_STR" c-string)
   (foreign-value "ALLEGRO_DATE_STR" c-string)
   (foreign-value "ALLEGRO_DATE" integer)
   (foreign-value "ALLEGRO_VERSION_INT" unsigned-integer32)))

(define base/pi (foreign-value "ALLEGRO_PI" integer32))

(define base/make-id (foreign-lambda* unsigned-integer32 ((unsigned-integer32 a) (unsigned-integer32 b) (unsigned-integer32 c) (unsigned-integer32 d)) "C_return(AL_ID(a, b, c, d));"))

(define base/run-main (foreign-safe-lambda int "al_run_main" integer (c-pointer c-string) (function integer (integer (c-pointer c-string)))))
