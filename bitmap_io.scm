(define bitmap-io/register-loader (foreign-lambda bool "al_register_bitmap_loader" c-string (function opaque_bitmap ((const c-string)))))
(define bitmap-io/register-saver (foreign-lambda bool "al_register_bitmap_saver" c-string (function bool ((const c-string) opaque_bitmap))))
(define bitmap-io/register-file-loader (foreign-lambda bool "al_register_bitmap_loader_f" c-string (function opaque_bitmap (opaque_file))))
(define bitmap-io/register-file-saver (foreign-lambda bool "al_register_bitmap_saver_f" c-string (function bool (opaque_file opaque_bitmap))))

(define bitmap-io/load (foreign-lambda opaque_bitmap "al_load_bitmap" c-string))
(define bitmap-io/load-from-file (foreign-lambda opaque_bitmap "al_load_bitmap_f" opaque_file c-string))

(define bitmap-io/save (foreign-lambda bool "al_save_bitmap" c-string opaque_bitmap))
(define bitmap-io/save-to-file (foreign-lambda bool "al_save_bitmap_f" opaque_file c-string opaque_bitmap))




