(define register-bitmap-loader (foreign-lambda bool "al_register_bitmap_loader" c-string (function bitmap ((const c-string)))))
(define register-bitmap-saver (foreign-lambda bool "al_register_bitmap_saver" c-string (function bool ((const c-string) bitmap))))
(define register-bitmap-file-loader (foreign-lambda bool "al_register_bitmap_loader_f" c-string (function bitmap (file))))
(define register-bitmap-file-saver (foreign-lambda bool "al_register_bitmap_saver_f" c-string (function bool (file bitmap))))

(define load-bitmap (foreign-lambda bitmap "al_load_bitmap" c-string))
(define load-bitmap-from-file (foreign-lambda bitmap "al_load_bitmap_f" file c-string))

(define (bitmap-save b s) ((foreign-lambda bool "al_save_bitmap" c-string bitmap) s b))
(define (bitmap-save-to-file b f s) ((foreign-lambda bool "al_save_bitmap_f" file c-string bitmap) f s b))
