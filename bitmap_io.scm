(define bitmap-register-loader (foreign-lambda bool "al_register_bitmap_loader" c-string (function opaque_bitmap ((const c-string)))))
(define bitmap-register-saver (foreign-lambda bool "al_register_bitmap_saver" c-string (function bool ((const c-string) opaque_bitmap))))
(define bitmap-register-file-loader (foreign-lambda bool "al_register_bitmap_loader_f" c-string (function opaque_bitmap (opaque_file))))
(define bitmap-register-file-saver (foreign-lambda bool "al_register_bitmap_saver_f" c-string (function bool (opaque_file opaque_bitmap))))

(define bitmap-load (foreign-lambda opaque_bitmap "al_load_bitmap" c-string))
(define bitmap-load-from-file (foreign-lambda opaque_bitmap "al_load_bitmap_f" opaque_file c-string))
(define bitmap-save (foreign-lambda bool "al_save_bitmap" c-string opaque_bitmap))
(define bitmap-save-to-file (foreign-lambda bool "al_save_bitmap_f" opaque_file c-string opaque_bitmap))




