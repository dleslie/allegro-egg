(define direct3d-device (foreign-lambda integer64 "al_get_d3d_device" display))
(define direct3d-system-texture (foreign-lambda integer64 "al_get_d3d_system_texture" bitmap))
(define direct3d-video-texture (foreign-lambda integer64 "al_get_d3d_video_texture" bitmap))

(define direct3d-non-pow2-texture-support? (foreign-lambda bool "al_have_d3d_non_pow2_texture_support"))
(define direct3d-non-square-texture-support? (foreign-lambda bool "al_have_d3d_non_square_texture_support"))

(define direct3d-texture-position (foreign-lambda* scheme-object ((bitmap bmp)) "
int u, v;
al_get_d3d_texture_position(bmp, &u, &v);
C_return(C_pair(&C_a, C_int_to_num(&C_a, u), C_int_to_num(&C_a, v)));
"))

(define direct3d-device-lost? (foreign-lambda bool "al_is_d3d_device_lost" display))
