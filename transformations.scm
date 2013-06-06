(define transform-use (foreign-lambda void "al_use_transform" transform))

(define transform-copy! (foreign-lambda void "al_copy_transform" transform transform))
(define transform-identity! (foreign-lambda void "al_identity_transform" transform))
(define transform-build! (foreign-lambda void "al_build_transform" transform float float float float float))
(define transform-translate! (foreign-lambda void "al_translate_transform" transform float float))
(define transform-scale! (foreign-lambda void "al_scale_transform" transform float float))

(define transform-coordinates (foreign-primitive scheme-object ((transform t) (float x) (float y)) "
float sx = x;
float sy = y;
al_transform_coordinates(t, &sx, &sy);
C_word *ptr = C_alloc(C_SIZEOF_LIST(2));
C_word *psx = C_alloc(C_SIZEOF_FLONUM);
C_word *psy = C_alloc(C_SIZEOF_FLONUM);
C_return(C_list(&ptr, 2, C_flonum(&psx, sx), C_flonum(&psy, sy)));
"))

(define transform-compose! (foreign-lambda void "al_compose_transform" transform transform))
(define transform-invert! (foreign-lambda void "al_invert_transform" transform))
(define transform-check-inverse (foreign-lambda int "al_check_inverse" transform float))

(define current-transform (foreign-lambda transform "al_get_current_transform"))
