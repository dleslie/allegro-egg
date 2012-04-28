(define new-bitmap-format-set! (foreign-lambda void "al_set_new_bitmap_format" pixel-format))
(define new-bitmap-flags-set! (foreign-lambda void "al_set_new_bitmap_flags" bitmap-flag))
(define new-bitmap-format (foreign-lambda pixel-format "al_get_new_bitmap_format"))
(define new-bitmap-flags (foreign-lambda bitmap-flag "al_get_new_bitmap_flags"))
(define new-bitmap-add-flag (foreign-lambda void "al_add_new_bitmap_flag" bitmap-flag))

(define make-bitmap* (foreign-lambda bitmap "al_create_bitmap" int int))
(define (make-bitmap i1 i2)
  (let ((bmp (make-bitmap* i1 i2)))
    (set-finalizer! bmp free-bitmap!)
    bmp))

(define free-bitmap! (foreign-lambda void "al_destroy_bitmap" bitmap))

(define bitmap-draw (foreign-lambda void "al_draw_bitmap" bitmap float float bitmap-flag))
(define bitmap-draw-region (foreign-lambda void "al_draw_bitmap_region" bitmap float float float float float float integer))
(define bitmap-draw-scaled (foreign-lambda void "al_draw_scaled_bitmap" bitmap float float float float float float float float integer))
(define bitmap-draw-rotated (foreign-lambda void "al_draw_rotated_bitmap" bitmap float float float float float integer))
(define bitmap-draw-scaled-rotated (foreign-lambda void "al_draw_scaled_rotated_bitmap" bitmap float float float float float float float integer))

(define bitmap-draw-tinted (foreign-lambda* void ((bitmap bmp) (color tint) (float dx) (float dy) (integer flags)) "al_draw_tinted_bitmap(bmp, *tint, dx, dy, flags);"))
(define bitmap-draw-tinted-region (foreign-lambda* void ((bitmap bmp) (color tint) (float sx) (float sy) (float sw) (float sh) (float dx) (float dy) (integer flags)) "al_draw_tinted_bitmap_region(bmp, *tint, sx, sy, sw, sh, dx, dy, flags);"))
(define bitmap-draw-tinted-scaled (foreign-lambda* void ((bitmap bmp) (color tint) (float sx) (float sy) (float sw) (float sh) (float dx) (float dy) (float dw) (float dh) (integer flags)) "al_draw_tinted_scaled_bitmap(bmp, *tint, sx, sy, sw, sh, dx, dy, dw, dh, flags);"))
(define bitmap-draw-tinted-rotated (foreign-lambda* void ((bitmap bmp) (color tint) (float cx) (float cy) (float dx) (float dy) (float angle) (integer flags)) "al_draw_tinted_rotated_bitmap(bmp, *tint, cx, cy, dx, dy, angle, flags);"))
(define bitmap-draw-tinted-scaled-rotated (foreign-lambda* void ((bitmap bmp) (color tint) (float cx) (float cy) (float dx) (float dy) (float xscale) (float yscale) (float angle) (integer flags)) "al_draw_tinted_scaled_rotated_bitmap(bmp, *tint, cx, cy, dx, dy, xscale, yscale, angle, flags);"))

(define bitmap-lock*! (foreign-lambda locked-region "al_lock_bitmap" bitmap pixel-format integer))
(define bitmap-lock-region*! (foreign-lambda locked-region "al_lock_bitmap_region" bitmap int int int int pixel-format integer))
(define bitmap-unlock! (foreign-lambda void "al_unlock_bitmap" bitmap))

(define (bitmap-lock! bmp frmt flg)
  (let ((region (bitmap-lock*! bmp frmt flg)))
    (set-finalizer! region (lambda (r) (bitmap-unlock! bmp) (free-locked-region! region)))
    region))

(define (bitmap-lock-region! bmp i1 i2 i3 i4 frmt flg)
  (let ((region (bitmap-lock-region*! bmp i1 i2 i3 i4 frmt flg)))
    (set-finalizer! region (lambda (r) (bitmap-unlock! bmp) (free-locked-region! region)))
    region))

(define bitmap-pixel! (foreign-lambda* void ((bitmap bmp) (int x) (int y) (color c)) "*c = al_get_pixel(bmp, x, y);"))
(define (bitmap-pixel* bmp x y)
  (let ((clr (make-color*)))
    (bitmap-pixel! bmp x y clr)
    clr))
(define (bitmap-pixel bmp x y)
  (let ((clr (make-color)))
    (bitmap-pixel! bmp x y clr)
    clr))

(define bitmap-width (foreign-lambda int "al_get_bitmap_width" bitmap))
(define bitmap-height (foreign-lambda int "al_get_bitmap_height" bitmap))
(define bitmap-format (foreign-lambda pixel-format "al_get_bitmap_format" bitmap))
(define bitmap-flags (foreign-lambda bitmap-flag "al_get_bitmap_flags" bitmap))

(define bitmap-mask->alpha! (foreign-lambda* void ((bitmap bmp) (color c)) "al_convert_mask_to_alpha(bmp, *c);"))

(define bitmap-clone* (foreign-lambda bitmap "al_clone_bitmap" bitmap))
(define (bitmap-clone bmp)
  (let ((bmp2 (bitmap-clone* bmp)))
    (set-finalizer! bmp2 free-bitmap!)
    bmp2))

(define bitmap-locked? (foreign-lambda bool "al_is_bitmap_locked" bitmap))

(define bitmap-put-pixel! (foreign-lambda* void ((bitmap bmp) (int x) (int y) (color c)) "
_al_put_pixel(bmp, x, y, *c);
"))

(define make-sub-bitmap* (foreign-lambda bitmap "al_create_sub_bitmap" bitmap int int int int))
(define (make-sub-bitmap bmp i1 i2 i3 i4)
  (let ((bmp2 (make-sub-bitmap* bmp i1 i2 i3 i4)))
    (set-finalizer! bmp2 free-bitmap!)
    bmp2))

(define sub-bitmap? (foreign-lambda bool "al_is_sub_bitmap" bitmap))

(define put-pixel (foreign-lambda* void ((int x) (int y) (color c)) "al_put_pixel(x, y, *c);"))
(define put-blended-pixel (foreign-lambda* void ((int x) (int y) (color c)) "al_put_blended_pixel(x, y, *c);"))

(define pixel-size (foreign-lambda int "al_get_pixel_size" pixel-format))

(define color-map-rgb! (foreign-lambda* void ((color c) (unsigned-byte r) (unsigned-byte g) (unsigned-byte b)) "*c = al_map_rgb(r, g, b);"))
(define color-map-rgba! (foreign-lambda* void ((color c) (unsigned-byte r) (unsigned-byte g) (unsigned-byte b) (unsigned-byte a)) "*c = al_map_rgba(r, g, b, a);"))
(define color-map-rgb-float! (foreign-lambda* void ((color c) (unsigned-byte r) (unsigned-byte g) (unsigned-byte b)) "*c = al_map_rgb_f(r, g, b);"))
(define color-map-rgba-float! (foreign-lambda* void ((color c) (unsigned-byte r) (unsigned-byte g) (unsigned-byte b) (unsigned-byte a)) "*c = al_map_rgba_f(r, g, b, a);"))

(define (map-rgb* r g b)
  (let ((clr (make-color*)))
    (color-map-rgb! clr r g b)
    clr))
(define (map-rgb r g b)
  (let ((clr (make-color)))
    (color-map-rgb! clr r g b)
    clr))
(define (map-rgba* r g b a)
  (let ((clr (make-color*)))
    (color-map-rgba! clr r g b a)
    clr))
(define (map-rgba r g b a)
  (let ((clr (make-color)))
    (color-map-rgba! clr r g b a)
    clr))

(define (map-rgb-float* r g b)
  (let ((clr (make-color*)))
    (color-map-rgb-float! clr r g b)
    clr))
(define (map-rgb-float r g b)
  (let ((clr (make-color)))
    (color-map-rgb-float! clr r g b)
    clr))
(define (map-rgba-float* r g b a)
  (let ((clr (make-color*)))
    (color-map-rgba-float! clr r g b a)
    clr))
(define (map-rgba-float r g b a)
  (let ((clr (make-color)))
    (color-map-rgba-float! clr r g b a)
    clr))

(define color-unmap-rgb (foreign-safe-lambda* scheme-object ((color c)) "
unsigned char r, g, b;
al_unmap_rgb(*c, &r, &g, &b);
C_word *ptr = C_alloc(C_SIZEOF_LIST(3));
C_return(C_list(&ptr, 3, C_fix((int)r), C_fix((int)g), C_fix((int)b)));
"))
(define color-unmap-rgba (foreign-safe-lambda* scheme-object ((color c)) "
unsigned char r, g, b, a;
al_unmap_rgba(*c, &r, &g, &b, &a);
C_word *ptr = C_alloc(C_SIZEOF_LIST(4));
C_return(C_list(&ptr, 4, C_fix((int)r), C_fix((int)g), C_fix((int)b), C_fix((int)a)));
"))
(define color-unmap-rgb-float (foreign-safe-lambda* scheme-object ((color c)) "
float r, g, b;
al_unmap_rgb_f(*c, &r, &g, &b);
C_word *ptr = C_alloc(C_SIZEOF_FLONUM * 3 + C_SIZEOF_LIST(3));
C_return(C_list(&ptr, 3, C_flonum(&ptr, (double)r), C_flonum(&ptr, (double)g), C_flonum(&ptr, (double)b)));
"))
(define color-unmap-rgba-float (foreign-safe-lambda* scheme-object ((color c)) "
float r, g, b, a;
al_unmap_rgba_f(*c, &r, &g, &b, &a);
C_word *ptr = C_alloc(C_SIZEOF_FLONUM * 4 + C_SIZEOF_LIST(4));
C_return(C_list(&ptr, 4, C_flonum(&ptr, (double)r), C_flonum(&ptr, (double)g), C_flonum(&ptr, (double)b), C_flonum(&ptr, (double)a)));
"))

(define pixel-format-bits (foreign-lambda int "al_get_pixel_format_bits" pixel-format))

(define clipping-rectangle-set! (foreign-lambda void "al_set_clipping_rectangle" int int int int))
(define clipping-rectangle (foreign-safe-lambda* scheme-object () "
int x,y,w,h;
al_get_clipping_rectangle(&x, &y, &w, &h);
C_word *ptr = C_alloc(C_SIZEOF_LIST(4));
C_return(C_list(&ptr, 4, C_fix(x), C_fix(y), C_fix(w), C_fix(h)));
"))

(define blender-set! (foreign-lambda void "al_set_blender" blend-operation blending-mode blending-mode))
(define blender (foreign-safe-lambda* scheme-object () "
int op, src, dest;
al_get_blender(&op, &src, &dest);
C_word *ptr = C_alloc(C_SIZEOF_LIST(3));
C_return(C_list(&ptr, 3, C_fix(op), C_fix(src), C_fix(dest)));
"))

(define separate-blender-set! (foreign-lambda void "al_set_separate_blender" blend-operation blending-mode blending-mode blend-operation blending-mode blending-mode))
(define separate-blender (foreign-safe-lambda* scheme-object () "
int op, src, dest, alpha_op, alpha_src, alpha_dest;
al_get_separate_blender(&op, &src, &dest, &alpha_op, &alpha_src, &alpha_dest);
C_word *ptr = C_alloc(C_SIZEOF_LIST(6));
C_return(C_list(&ptr, 6, C_fix(op), C_fix(src), C_fix(dest), 3, C_fix(alpha_op), C_fix(alpha_src), C_fix(alpha_dest)));
"))

