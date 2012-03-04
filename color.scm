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

(define (make-color-yuv y u v) (color-yuv! (make-color) y u v))
(define color-yuv! (foreign-lambda* color ((color clr) (float y) (float u) (float v)) "
int t = al_color_yuv(y, u, v);
memcpy(clr, &t, sizeof(ALLEGRO_COLOR));
C_return(clr);
"))
(define (make-color-cmyk c m y k) (color-cmyk! (make-color) c m y k))
(define color-cmyk! (foreign-lambda* color ((color clr) (float c) (float m) (float y) (float k)) "
int t = al_color_cmyk(c, m, y, k);
memcpy(clr, &t, sizeof(ALLEGRO_COLOR));
C_return(clr);
"))
(define (make-color-hsl h s l) (color-hsl! (make-color) h s l))
(define color-hsl! (foreign-lambda* color ((color clr) (float h) (float s) (float l)) "
int t = al_color_hsl(h, s, l);
memcpy(clr, &t, sizeof(ALLEGRO_COLOR));
C_return(clr);
"))
(define (make-color-hsv h s v) (color-hsv! (make-color) h s v))
(define color-hsv! (foreign-lambda* color ((color clr) (float h) (float s) (float v)) "
int t = al_color_hsv(h, s, v);
memcpy(clr, &t, sizeof(ALLEGRO_COLOR));
C_return(clr);
"))
(define (make-color-name n) (color-name! (make-color) n))
(define color-name! (foreign-lambda* color ((color clr) ((const c-string) n)) "
int t = al_color_name(n);
memcpy(clr, &t, sizeof(ALLEGRO_COLOR));
C_return(clr);
"))
(define (make-color-html html) (color-html! (make-color) html))
(define color-html! (foreign-lambda* color ((color clr) ((const c-string) html)) "
int t = al_color_html(html);
memcpy(clr, &t, sizeof(ALLEGRO_COLOR));
C_return(clr);
"))
