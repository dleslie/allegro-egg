(define d3d-non-pow2-texture-support? (foreign-lambda bool "al_have_d3d_non_pow2_texture_support"))
(define d3d-non-square-texture-support? (foreign-lambda bool "al_have_d3d_non_square_texture_support"))

(define bitmap-d3d-system-texture (foreign-lambda integer64 "al_get_d3d_system_texture" bitmap))
(define bitmap-d3d-video-texture (foreign-lambda integer64 "al_get_d3d_video_texture" bitmap))
(define bitmap-d3d-texture-position (foreign-safe-lambda* scheme-object ((bitmap bmp)) "
int u, v;
al_get_d3d_texture_position(bmp, &u, &v);
C_word *ptr = C_alloc(C_SIZEOF_LIST(2));
C_return(C_list(&ptr, 2, C_fix(u), C_fix(v)));
"))

(define display-d3d-device-lost? (foreign-lambda bool "al_is_d3d_device_lost" display))
(define display-d3d-device (foreign-lambda integer64 "al_get_d3d_device" display))
