(define bitmap-new-format-set! (foreign-lambda void "al_set_new_bitmap_format" pixel-format))
(define bitmap-new-flags-set! (foreign-lambda void "al_set_new_bitmap_flags" bitmap-flag))
(define bitmap-new-format (foreign-lambda pixel-format "al_get_new_bitmap_format"))
(define bitmap-new-flags (foreign-lambda bitmap-flag "al_get_new_bitmap_flags"))
(define bitmap-add-new-flag (foreign-lambda void "al_add_new_bitmap_flag" bitmap-flag))

(define bitmap-width (foreign-lambda int "al_get_bitmap_width" opaque_bitmap))
(define bitmap-height (foreign-lambda int "al_get_bitmap_height" opaque_bitmap))
(define bitmap-format (foreign-lambda pixel-format "al_get_bitmap_format" opaque_bitmap))
(define bitmap-flags (foreign-lambda bitmap-flag "al_get_bitmap_flags" opaque_bitmap))

(define make-bitmap (foreign-lambda opaque_bitmap "al_create_bitmap" int int))
(define free-bitmap (foreign-lambda void "al_destroy_bitmap" opaque_bitmap))

(define bitmap-draw (foreign-lambda void "al_draw_bitmap" opaque_bitmap float float bitmap-flag))
(define bitmap-draw-region (foreign-lambda void "al_draw_bitmap_region" opaque_bitmap float float float float float float bitmap-flag))
(define bitmap-draw-scaled (foreign-lambda void "al_draw_scaled_bitmap" opaque_bitmap float float float float float float float float bitmap-flag))
(define bitmap-draw-rotated (foreign-lambda void "al_draw_rotated_bitmap" opaque_bitmap float float float float float bitmap-flag))
(define bitmap-draw-scaled-rotated (foreign-lambda void "al_draw_scaled_rotated_bitmap" opaque_bitmap float float float float float float float bitmap-flag))

(define bitmap-draw-tinted (foreign-lambda* void ((opaque_bitmap bmp) (color tint) (float dx) (float dy) (bitmap-flag flags)) "al_draw_tinted_bitmap(bmp, *tint, dx, dy, flags);"))
(define bitmap-draw-tinted-region (foreign-lambda* void ((opaque_bitmap bmp) (color tint) (float sx) (float sy) (float sw) (float sh) (float dx) (float dy) (bitmap-flag flags)) "al_draw_tinted_bitmap_region(bmp, *tint, sx, sy, sw, sh, dx, dy, flags);"))
(define bitmap-draw-tinted-scaled (foreign-lambda* void ((opaque_bitmap bmp) (color tint) (float sx) (float sy) (float sw) (float sh) (float dx) (float dy) (float dw) (float dh) (bitmap-flag flags)) "al_draw_tinted_scaled_bitmap(bmp, *tint, sx, sy, sw, sh, dx, dy, dw, dh, flags);"))
(define bitmap-draw-tinted-rotated (foreign-lambda* void ((opaque_bitmap bmp) (color tint) (float cx) (float cy) (float dx) (float dy) (float angle) (bitmap-flag flags)) "al_draw_tinted_rotated_bitmap(bmp, *tint, cx, cy, dx, dy, angle, flags);"))
(define bitmap-draw-tinted-scaled-rotated (foreign-lambda* void ((opaque_bitmap bmp) (color tint) (float cx) (float cy) (float dx) (float dy) (float xscale) (float yscale) (float angle) (bitmap-flag flags)) "al_draw_tinted_scaled_rotated_bitmap(bmp, *tint, cx, cy, dx, dy, xscale, yscale, angle, flags);"))

(define bitmap-lock! (foreign-lambda locked-region "al_lock_bitmap" opaque_bitmap pixel-format bitmap-flag))
(define bitmap-lock-region! (foreign-lambda locked-region "al_lock_bitmap_region" opaque_bitmap int int int int pixel-format bitmap-flag))

(define bitmap-unlock! (foreign-lambda void "al_unlock_bitmap" opaque_bitmap))

(define bitmap-put-pixel! (foreign-lambda* void ((int x) (int y) (color c)) "al_put_pixel(x, y, *c);"))
(define bitmap-blended-pixel-set! (foreign-lambda* void ((int x) (int y) (color c)) "al_put_blended_pixel(x, y, *c);"))
(define bitmap-pixel! (foreign-lambda* void ((color c) (opaque_bitmap bmp) (int x) (int y)) "*c = al_get_pixel(bmp, x, y);"))
(define bitmap-pixel-size (foreign-lambda int "al_get_pixel_size" pixel-format))

(define bitmap-map-rgb! (foreign-lambda* void ((color c) (unsigned-byte r) (unsigned-byte g) (unsigned-byte b)) "*c = al_map_rgb(r, g, b);"))
(define bitmap-map-rgba! (foreign-lambda* void ((color c) (unsigned-byte r) (unsigned-byte g) (unsigned-byte b) (unsigned-byte a)) "*c = al_map_rgba(r, g, b, a);"))
(define bitmap-map-rgb-f! (foreign-lambda* void ((color c) (unsigned-byte r) (unsigned-byte g) (unsigned-byte b)) "*c = al_map_rgb_f(r, g, b);"))
(define bitmap-map-rgba-f! (foreign-lambda* void ((color c) (unsigned-byte r) (unsigned-byte g) (unsigned-byte b) (unsigned-byte a)) "*c = al_map_rgba_f(r, g, b, a);"))

(define bitmap-unmap-rgb (foreign-lambda* scheme-object ((color c)) "
unsigned char r, g, b;
al_unmap_rgb(*c, &r, &g, &b);
C_return(C_list(&C_a, 3, C_int_to_num(&C_a, (int)r), C_int_to_num(&C_a, (int)g), C_int_to_num(&C_a, (int)b)));
"))
(define bitmap-unmap-rgba (foreign-lambda* scheme-object ((color c)) "
unsigned char r, g, b, a;
al_unmap_rgba(*c, &r, &g, &b, &a);
C_return(C_list(&C_a, 4, C_int_to_num(&C_a, (int)r), C_int_to_num(&C_a, (int)g), C_int_to_num(&C_a, (int)b), C_int_to_num(&C_a, (int)a)));
"))
(define bitmap-unmap-rgb-f (foreign-lambda* scheme-object ((color c)) "
float r, g, b;
al_unmap_rgb_f(*c, &r, &g, &b);
C_return(C_list(&C_a, 3, C_flonum(&C_a, (double)r), C_flonum(&C_a, (double)g), C_flonum(&C_a, (double)b)));
"))
(define bitmap-unmap-rgba-f (foreign-lambda* scheme-object ((color c)) "
float r, g, b, a, f;
al_unmap_rgba_f(*c, &r, &g, &b, &a);
C_return(C_list(&C_a, 4, C_flonum(&C_a, (double)r), C_flonum(&C_a, (double)g), C_flonum(&C_a, (double)b), C_flonum(&C_a, (double)a)));
"))
(define bitmap-pixel-format-bits (foreign-lambda int "al_get_pixel_format_bits" pixel-format))

(define bitmap-mask->alpha (foreign-lambda* void ((opaque_bitmap bmp) (color c)) "al_convert_mask_to_alpha(bmp, *c);"))

(define bitmap-clipping-rectangle-set! (foreign-lambda void "al_set_clipping_rectangle" int int int int))
(define bitmap-clipping-rectange (foreign-lambda* scheme-object () "
int x,y,w,h;
al_get_clipping_rectangle(&x, &y, &w, &h);
C_return(C_list(&C_a, 4, C_int_to_num(&C_a, x), C_int_to_num(&C_a, y), C_int_to_num(&C_a, w), C_int_to_num(&C_a, h)));
"))

(define make-sub-bitmap (foreign-lambda opaque_bitmap "al_create_sub_bitmap" opaque_bitmap int int int int))
(define sub-bitmap? (foreign-lambda bool "al_is_sub_bitmap" opaque_bitmap))

(define bitmap-clone (foreign-lambda opaque_bitmap "al_clone_bitmap" opaque_bitmap))
(define bitmap-locked? (foreign-lambda bool "al_is_bitmap_locked" opaque_bitmap))

(define bitmap-blender-set! (foreign-lambda void "al_set_blender" int int int))
(define bitmap-blender (foreign-lambda* void () "
int op, src, dest;
al_get_blender(&op, &src, &dest);
C_return(C_list(&C_a, 3, C_int_to_num(&C_a, op), C_int_to_num(&C_a, src), C_int_to_num(&C_a, dest)));
"))
(define bitmap-separate-blender-set! (foreign-lambda void "al_set_separate_blender" int int int int int int))
(define bitmap-separate-blender (foreign-lambda* void () "
int op, src, dest, alpha_op, alpha_src, alpha_dest;
al_get_separate_blender(&op, &src, &dest, &alpha_op, &alpha_src, &alpha_dest);
C_return(C_list(&C_a, 3, C_int_to_num(&C_a, op), C_int_to_num(&C_a, src), C_int_to_num(&C_a, dest), 3, C_int_to_num(&C_a, alpha_op), C_int_to_num(&C_a, alpha_src), C_int_to_num(&C_a, alpha_dest)));
"))

(define bitmap-put-pixel-in! (foreign-lambda* void ((opaque_bitmap bmp) (int x) (int y) (color c)) "
_al_put_pixel(bmp, x, y, *c);
"))
