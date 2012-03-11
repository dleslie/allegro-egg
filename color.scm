(define color-addon-version (foreign-lambda unsigned-integer32 "al_get_allegro_color_version"))

(define hsv->rgb (foreign-lambda* scheme-object ((float hue) (float saturation) (float value)) "
float r, g, b;
al_color_hsv_to_rgb(hue, saturation, value, &r, &g, &b);
C_return(C_list(&C_a, 3, C_flonum(&C_a, r), C_flonum(&C_a, g), C_flonum(&C_a, b)));
"))
(define rgb->hsl (foreign-lambda* scheme-object ((float red) (float green) (float blue)) "
float h,s,l;
al_color_rgb_to_hsl(red, green, blue, &h, &s, &l);
C_return(C_list(&C_a, 3, C_flonum(&C_a, h), C_flonum(&C_a, s), C_flonum(&C_a, l)));
"))
(define hsl->rgb (foreign-lambda* scheme-object ((float hue) (float saturation) (float lightness)) "
float r,g,b;
al_color_hsl_to_rgb(hue, saturation, lightness, &r, &g, &b);
C_return(C_list(&C_a, 3, C_flonum(&C_a, r), C_flonum(&C_a, g), C_flonum(&C_a, b)));
"))
(define name->rgb (foreign-lambda* scheme-object (((const c-string) name)) "
float r, g, b;
if (al_color_name_to_rgb(name, &r, &g, &b))
  C_return(C_list(&C_a, 3, C_flonum(&C_a, r), C_flonum(&C_a, g), C_flonum(&C_a, b)));
else
  C_return(C_SCHEME_FALSE);
"))
(define rgb->name (foreign-lambda c-string "al_color_rgb_to_name" float float float))
(define cmyk->rgb (foreign-lambda* scheme-object ((float cyan) (float magenta) (float yellow) (float key)) "
float r, g, b;
al_color_cmyk_to_rgb(cyan, magenta, yellow, key, &r, &g, &b);
C_return(C_list(&C_a, 3, C_flonum(&C_a, r), C_flonum(&C_a, g), C_flonum(&C_a, b)));
"))
(define rgb->cmyk (foreign-lambda* scheme-object ((float red) (float green) (float blue)) "
float c,m,y,k;
al_color_rgb_to_cmyk(red, green, blue, &c, &m, &y, &k);
C_return(C_list(&C_a, 4, C_flonum(&C_a, c), C_flonum(&C_a, m), C_flonum(&C_a, y), C_flonum(&C_a, k)));
"))
(define yuv->rgb (foreign-lambda* scheme-object ((float y) (float u) (float v)) "
float r, g, b;
al_color_yuv_to_rgb(y, u, v, &r, &g, &b);
C_return(C_list(&C_a, 3, C_flonum(&C_a, r), C_flonum(&C_a, g), C_flonum(&C_a, b)));
"))
(define rgb->yuv (foreign-lambda* scheme-object ((float red) (float green) (float blue)) "
float y,u,v;
al_color_rgb_to_yuv(red, green, blue, &y, &u, &v);
C_return(C_list(&C_a, 3, C_flonum(&C_a, y), C_flonum(&C_a, u), C_flonum(&C_a, v)));
"))
(define rgb->html (foreign-lambda* c-string* ((float red) (float green) (float blue)) "
char *html = (char *)C_alloc(sizeof(char) * 8);
al_color_rgb_to_html(red, green, blue, html);
C_return(html);
"))
(define html->rgb (foreign-lambda* scheme-object (((const c-string) string)) "
float r,g,b;
al_color_html_to_rgb(string, &r, &g, &b);
C_return(C_list(&C_a, 3, C_flonum(&C_a, r), C_flonum(&C_a, g), C_flonum(&C_a, b)));
"))

(define make-color-rgb* (foreign-lambda* color ((int r) (int g) (int b)) "
ALLEGRO_COLOR *c = (ALLEGRO_COLOR *)C_alloc(sizeof(ALLEGRO_COLOR));
*c = al_map_rgb(r, g, b);
C_return(c);
"))
(define (make-color-rgb r g b)
  (let ((clr (make-color-rgb* r g b)))
    (set-finalizer! clr free-color!)
    clr))

(define make-color-rgba* (foreign-lambda* color ((int r) (int g) (int b) (int a)) "
ALLEGRO_COLOR *c = (ALLEGRO_COLOR *)C_alloc(sizeof(ALLEGRO_COLOR));
*c = al_map_rgba(r, g, b, a);
C_return(c);
"))
(define (make-color-rgba r g b a)
  (let ((clr (make-color-rgba* r g b a)))
    (set-finalizer! clr free-color!)
    clr))

(define (make-color-yuv* y u v) 
  (let ((clr (make-color*))) 
    (color-yuv! clr y u v)
    clr))
(define (make-color-yuv y u v)
  (let ((clr (make-color-yuv* y u v)))
    (set-finalizer! clr free-color!)
    clr))

(define (make-color-cmyk* c m y k) 
  (let ((clr (make-color*))) 
    (color-cmyk! clr c m y k)
    clr))
(define (make-color-cmyk c m y k)
  (let ((clr (make-color-cmyk* c m y k)))
    (set-finalizer! clr free-color!)
    clr))

(define (make-color-hsl* h s l) 
  (let ((clr (make-color*))) 
    (color-hsl! clr h s l)
    clr))
(define (make-color-hsl h s l)
  (let ((clr (make-color-hsl* h s l)))
    (set-finalizer! clr free-color!)
    clr))

(define (make-color-hsv* h s v) 
  (let ((clr (make-color*))) 
    (color-hsl! clr h s v)
    clr))
(define (make-color-hsv h s v)
  (let ((clr (make-color-hsv* h s v)))
    (set-finalizer! clr free-color!)
    clr))

(define (make-color-name* n) 
  (let ((clr (make-color*))) 
    (color-name! clr n)
    clr))
(define (make-color-name n)
  (let ((clr (make-color-name* n)))
    (set-finalizer! clr free-color!)
    clr))

(define (make-color-html* n) 
  (let ((clr (make-color*))) 
    (color-html! clr n)
    clr))
(define (make-color-html n)
  (let ((clr (make-color-html* n)))
    (set-finalizer! clr free-color!)
    clr))

(define color-yuv! (foreign-lambda* void ((color clr) (float y) (float u) (float v)) "
float r, g, b;
al_color_yuv_to_rgb(y, u, v, &r, &g, &b);
*clr = al_map_rgb_f(r, g, b);"))
(define color-cmyk! (foreign-lambda* void ((color clr) (float c) (float m) (float y) (float k)) "
float r, g, b;
al_color_cmyk_to_rgb(c, m, y, k, &r, &g, &b);
*clr = al_map_rgb_f(r, g, b);"))
(define color-hsl! (foreign-lambda* void ((color clr) (float h) (float s) (float l)) "
float r, g, b;
al_color_hsl_to_rgb(h, s, l, &r, &g, &b);
*clr = al_map_rgb_f(r, g, b);"))
(define color-hsv! (foreign-lambda* color ((color clr) (float h) (float s) (float v)) "
float r, g, b;
al_color_hsv_to_rgb(h, s, v, &r, &g, &b);
*clr = al_map_rgb_f(r, g, b);"))
(define color-name! (foreign-lambda* color ((color clr) ((const c-string) n)) "
float r, g, b;
al_color_name_to_rgb(n, &r, &g, &b);
*clr = al_map_rgb_f(r, g, b);"))
(define color-html! (foreign-lambda* color ((color clr) ((const c-string) html)) "
float r, g, b;
al_color_html_to_rgb(html, &r, &g, &b);
*clr = al_map_rgb_f(r, g, b);"))
