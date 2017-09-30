(define register-bitmap-loader (foreign-lambda bool "al_register_bitmap_loader" c-string (function bitmap ((const c-string) int))))
(define register-bitmap-file-loader (foreign-lambda bool "al_register_bitmap_loader_f" c-string (function bitmap (file int))))

(define register-bitmap-saver (foreign-lambda* bool (((const c-string) ext) ((function bool ((const c-string) bitmap)) saver)) "
C_return(al_register_bitmap_saver(ext, (ALLEGRO_IIO_SAVER_FUNCTION)saver));"))

(define register-bitmap-file-saver (foreign-lambda* bool (((const c-string) ext) ((function bool (file bitmap)) saver)) "
C_return(al_register_bitmap_saver_f(ext, (ALLEGRO_IIO_FS_SAVER_FUNCTION)saver));"))

(define load-bitmap* (foreign-lambda bitmap "al_load_bitmap" c-string))
(define (load-bitmap filename)
  (let ((bmp (load-bitmap* filename)))
    (set-finalizer! bmp free-bitmap!)
    bmp))
(define load-bitmap-from-file* (foreign-lambda bitmap "al_load_bitmap_f" file c-string))
(define (load-bitmap-from-file file name)
  (let ((bmp (load-bitmap-from-file* file name)))
    (set-finalizer! bmp free-bitmap!)
    bmp))

(define (bitmap-save b s) ((foreign-lambda bool "al_save_bitmap" c-string bitmap) s b))
(define (bitmap-save-to-file b f s) ((foreign-lambda bool "al_save_bitmap_f" file c-string bitmap) f s b))






