(define-constant vertex-shader 1)
(define vertex-shader vertex-shader)
(define-constant pixel-shader 2)
(define pixel-shader pixel-shader)
(define-constant shader-auto 0)
(define shader-auto shader-auto)
(define-constant shader-glsl 1)
(define shader-glsl shader-glsl)
(define-constant shader-hlsl 2)
(define shader-hlsl shader-hlsl)
(define-constant shader-auto-minimal 3)
(define shader-auto-minimal shader-auto-minimal)
(define-constant shader-glsl-minimal 4)
(define shader-glsl-minimal shader-glsl-minimal)
(define-constant shader-hlsl-minimal 5)
(define shader-hlsl-minimal shader-hlsl-minimal)
(define-constant shader-hlsl-sm-3-0 6)
(define shader-hlsl-sm-3-0 shader-hlsl-sm-3-0)

(define create-shader
  (foreign-lambda*
      shader
      ((integer a0))
    "return(al_create_shader(a0));"))

(define attach-shader-source
  (foreign-lambda*
      bool
      ((shader a0) (integer a1) (c-string a2))
    "return(al_attach_shader_source(a0 , a1 , a2));"))

(define attach-shader-source-file
  (foreign-lambda*
      bool
      ((shader a0) (integer a1) (c-string a2))
    "return(al_attach_shader_source_file(a0 , a1 , a2));"))

(define build-shader
  (foreign-lambda*
      bool
      ((shader a0))
    "return(al_build_shader(a0));"))

(define get-shader-log
  (foreign-lambda*
      c-string
      ((shader a0))
    "return(al_get_shader_log(a0));"))

(define get-shader-platform
  (foreign-lambda*
      integer
      ((shader a0))
    "return(al_get_shader_platform(a0));"))

(define use-shader
  (foreign-lambda*
      bool
      ((shader a0))
    "return(al_use_shader(a0));"))

(define get-current-shader
  (foreign-lambda*
      shader
      ()
    "return(al_get_current_shader());"))

(define destroy-shader
  (foreign-lambda*
      void
      ((shader a0))
    "al_destroy_shader(a0);"))

(define set-shader-sampler
  (foreign-lambda*
      bool
      ((c-string a0) (bitmap a1) (integer a2))
    "return(al_set_shader_sampler(a0 , a1 , a2));"))

(define set-shader-matrix
  (foreign-lambda*
      bool
      ((c-string a0) (transform a1))
    "return(al_set_shader_matrix(a0 , a1));"))

(define set-shader-int
  (foreign-lambda*
      bool
      ((c-string a0) (integer a1))
    "return(al_set_shader_int(a0 , a1));"))

(define set-shader-float
  (foreign-lambda*
      bool
      ((c-string a0) (float a1))
    "return(al_set_shader_float(a0 , a1));"))

(define set-shader-int-vector
  (foreign-lambda*
      bool
      ((c-string a0) (integer a1) (s32vector a2) (integer a3))
    "return(al_set_shader_int_vector(a0 , a1 , a2 , a3));"))

(define set-shader-float-vector
  (foreign-lambda*
      bool
      ((c-string a0) (integer a1) (f32vector a2) (integer a3))
    "return(al_set_shader_float_vector(a0 , a1 , a2 , a3));"))

(define set-shader-bool
  (foreign-lambda*
      bool
      ((c-string a0) (bool a1))
    "return(al_set_shader_bool(a0 , a1));"))

(define get-default-shader-source
  (foreign-lambda*
      (c-pointer (c-pointer (const char)))
      ((integer a0) (integer a1))
    "return(al_get_default_shader_source(a0 , a1));"))
