(define transform-use (foreign-lambda void "al_use_transform" transform))

(define transform-copy! (foreign-lambda void "al_copy_transform" transform transform))
(define transform-identity! (foreign-lambda void "al_identity_transform" transform))
(define transform-build! (foreign-lambda void "al_build_transform" transform float float float float float))
(define transform-translate! (foreign-lambda void "al_translate_transform" transform float float))
(define transform-scale! (foreign-lambda void "al_scale_transform" transform float float))

(define transform-coordinates (foreign-lambda* scheme-object ((transform t) (float x) (float y)) "
float sx = x;
float sy = y;
al_transform_coordinates(t, &sx, &sy);
C_return(C_pair(&C_a, C_flonum(&C_a, sx), C_flonum(&C_a, sy)));
"))

(define transform-compose! (foreign-lambda void "al_compose_transform" transform transform))

(define transform-current (foreign-lambda transform "al_get_current_transform"))

(define transform-invert! (foreign-lambda void "al_invert_transform" transform))

(define transform-check-inverse (foreign-lambda int "al_check_inverse" transform float))
