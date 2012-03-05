(define bitmap-register-loader (foreign-lambda bool "al_register_bitmap_loader" c-string (function bitmap ((const c-string)))))
(define bitmap-register-saver (foreign-lambda bool "al_register_bitmap_saver" c-string (function bool ((const c-string) bitmap))))
(define bitmap-register-file-loader (foreign-lambda bool "al_register_bitmap_loader_f" c-string (function bitmap (file))))
(define bitmap-register-file-saver (foreign-lambda bool "al_register_bitmap_saver_f" c-string (function bool (file bitmap))))

(define bitmap-load (foreign-lambda bitmap "al_load_bitmap" c-string))
(define bitmap-load-from-file (foreign-lambda bitmap "al_load_bitmap_f" file c-string))
(define bitmap-save (foreign-lambda bool "al_save_bitmap" c-string bitmap))
(define bitmap-save-to-file (foreign-lambda bool "al_save_bitmap_f" file c-string bitmap))




