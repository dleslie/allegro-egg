(define opengl-version (foreign-lambda unsigned-integer32 "al_get_opengl_version"))
(define opengl-extension-exists? (foreign-lambda bool "al_have_opengl_extension" (const c-string)))
(define opengl-proc-address (foreign-lambda c-pointer "al_get_opengl_proc_address" (const c-string)))
(define opengl-texture (foreign-lambda unsigned-integer32 "al_get_opengl_texture" opaque_bitmap))
(define opengl-remove-fbo! (foreign-lambda void "al_remove_opengl_fbo" opaque_bitmap))
(define opengl-fbo (foreign-lambda unsigned-integer32 "al_get_opengl_fbo" opaque_bitmap))
(define opengl-texture-size (foreign-lambda* scheme-object ((opaque_bitmap bmp)) "
int w, h;
al_get_opengl_texture_size(bmp, &w, &h);
C_return(C_pair(&C_a, C_int_to_num(&C_a, w), C_int_to_num(&C_a, h)));
"))
(define opengl-texture-position (foreign-lambda* scheme-object ((opaque_bitmap bmp)) "
int u, v;
al_get_opengl_texture_size(bmp, &u, &v);
C_return(C_pair(&C_a, C_int_to_num(&C_a, u), C_int_to_num(&C_a, v)));
"))
(define opengl-context-set! (foreign-lambda void "al_set_current_opengl_context" display))
(define opengl-variant (foreign-lambda gl-variant "al_get_opengl_variant"))
