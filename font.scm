(define register-font-loader (foreign-lambda bool "al_register_font_loader" (const c-string) (function font ((const c-string) integer integer))))

(define load-bitmap-font* (foreign-lambda font "al_load_bitmap_font" (const c-string)))
(define load-font* (foreign-lambda font "al_load_font" (const c-string) integer font-align))
(define make-font-from-bitmap* (foreign-lambda font "al_grab_font_from_bitmap" bitmap integer s32vector))

(define (load-bitmap-font str)
  (let ((f (load-bitmap-font* str)))
    (set-finalizer! f free-font!)
    f))
(define (load-font str i a)
  (let ((f (load-font* str i a)))
    (set-finalizer! f free-font!)
    f))
(define (make-font-from-bitmap bmp i v)
  (let ((f (make-font-from-bitmap* bmp i v)))
    (set-finalizer! f free-font!)
    f))

(define free-font! (foreign-lambda void "al_destroy_font" font))

(define font-draw-string (foreign-lambda* void (((const font) f) (color c) (float x) (float y) (font-align flags) (c-string text)) "al_draw_text(f, *c, x, y, flags, text);"))
(define font-draw-justified-string (foreign-lambda* void (((const font) f) (color c) (float x1) (float x2) (float y) (float diff)  (font-align flags) (c-string text)) "al_draw_justified_text(f, *c, x1, x2, y, diff, flags, text);"))

(define font-draw-string/shared
  (foreign-lambda* void (((const font) f) (color c) (float x) (float y) (font-align flags) (scheme-pointer text) (integer length)) "
ALLEGRO_USTR_INFO info;
ALLEGRO_USTR *ustr = al_ref_buffer(&info, text, length);
al_draw_ustr(f, *c, x, y, flags, ustr);
"))
(define font-draw-justified-string/shared (foreign-lambda* void (((const font) f) (color c) (float x1) (float x2) (float y) (float diff)  (font-align flags) (scheme-pointer text) (integer length)) "
ALLEGRO_USTR_INFO info;
ALLEGRO_USTR *ustr = al_ref_buffer(&info, text, length);
al_draw_justified_ustr(f, *c, x1, x2, y, diff, flags, ustr);
"))
(define font-draw-substring/shared (foreign-lambda* void (((const font) f) (color c) (float x) (float y) (font-align flags) (int start) (int end) (scheme-pointer text)) "
ALLEGRO_USTR_INFO info;
char * txtp = (char *)text;
ALLEGRO_USTR *ustr = al_ref_buffer(&info, &txtp[start], end - start);
al_draw_ustr(f, *c, x, y, flags, ustr);
"))

(define font-draw-utf (foreign-lambda* void (((const font) f) (color c) (float x) (float y) (font-align flags) ((const utf-string) ustr)) "al_draw_ustr(f, *c, x, y, flags, ustr);"))
(define font-draw-justified-utf-string (foreign-lambda* void (((const font) f) (color c) (float x1) (float x2) (float y) (float diff)  (font-align flags) ((const utf-string) text)) "al_draw_justified_ustr(f, *c, x1, x2, y, diff, flags, text);"))

(define font-width (foreign-lambda integer "al_get_text_width" (const font) (const c-string)))
(define font-utf-width (foreign-lambda integer "al_get_ustr_width" (const font) (const utf-string)))
(define font-line-height (foreign-lambda integer "al_get_font_line_height" (const font)))
(define font-ascent (foreign-lambda integer "al_get_font_ascent" (const font)))
(define font-descent (foreign-lambda integer "al_get_font_descent" (const font)))
(define font-utf-dimensions (foreign-safe-lambda* scheme-object (((const font) f) ((const utf-string) text)) "
int bbx, bby, bbw, bbh;
al_get_ustr_dimensions(f, text, &bbx, &bby, &bbw, &bbh);
C_word *ptr = C_alloc(C_SIZEOF_LIST(4));
C_return(C_list(&ptr, 4, C_fix(bbx), C_fix(bby), C_fix(bbw), C_fix(bbh)));
"))
(define font-dimensions (foreign-safe-lambda* scheme-object (((const font) f) ((const c-string) text)) "
int bbx, bby, bbw, bbh;
al_get_text_dimensions(f, text, &bbx, &bby, &bbw, &bbh);
C_word *ptr = C_alloc(C_SIZEOF_LIST(4));
C_return(C_list(&ptr, 4, C_fix(bbx), C_fix(bby), C_fix(bbw), C_fix(bbh)));
"))

(define (font-addon-install)
  ((foreign-lambda void "al_init_font_addon"))
  #t)
(define font-addon-uninstall (foreign-lambda void "al_shutdown_font_addon"))
(define font-addon-version (foreign-lambda unsigned-integer32 "al_get_allegro_font_version"))
