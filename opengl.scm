(define opengl-addon-version (foreign-lambda unsigned-integer32 "al_get_opengl_version"))

(define opengl-extension-exists? (foreign-lambda bool "al_have_opengl_extension" (const c-string)))
(define opengl-proc-address (foreign-lambda c-pointer "al_get_opengl_proc_address" (const c-string)))
(define opengl-texture (foreign-lambda unsigned-integer32 "al_get_opengl_texture" bitmap))
(define opengl-remove-fbo! (foreign-lambda void "al_remove_opengl_fbo" bitmap))
(define opengl-fbo (foreign-lambda unsigned-integer32 "al_get_opengl_fbo" bitmap))

(define opengl-texture-size (foreign-safe-lambda* scheme-object ((bitmap bmp)) "
int w, h;
al_get_opengl_texture_size(bmp, &w, &h);
C_word *ptr = C_malloc(C_SIZEOF_LIST(2));
C_return(C_list(&ptr, 2, C_fix(w), C_fix(h)));
"))
(define opengl-texture-position (foreign-safe-lambda* scheme-object ((bitmap bmp)) "
int u, v;
al_get_opengl_texture_size(bmp, &u, &v);
C_word *ptr = C_malloc(C_SIZEOF_LIST(2));
C_return(C_list(&ptr, 2, C_fix(u), C_fix(v)));
"))

(define opengl-context-set! (foreign-lambda void "al_set_current_opengl_context" display))

(define opengl-variant (foreign-lambda gl-variant "al_get_opengl_variant"))
