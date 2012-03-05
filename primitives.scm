(define primitives-addon-version (foreign-lambda unsigned-integer32 "al_get_allegro_primitives_version"))
(define primitives-addon-init (foreign-lambda bool "al_init_primitives_addon"))
(define primitives-addon-shutdown (foreign-lambda void "al_shutdown_primitives_addon"))

(define make-vertex-declaration (foreign-lambda vertex-declaration "al_create_vertex_decl" (const vertex-element) integer))
(define free-vertex-declaration (foreign-lambda void "al_destroy_vertex_decl" vertex-declaration))

(define draw-primitive (foreign-lambda integer "al_draw_prim" (const c-pointer) (const vertex-declaration) bitmap integer integer primitive-type))
(define draw-indexed-primitive (foreign-lambda integer "al_draw_indexed_prim" (const c-pointer) (const vertex-declaration) bitmap (const s32vector) integer32 primitive-type))

(define draw-soft-triangle (foreign-lambda void "al_draw_soft_triangle" vertex vertex vertex unsigned-integer32 
                                           (function void (unsigned-integer32 vertex vertex vertex))
                                           (function void (unsigned-integer32 int int int int))
                                           (function void (unsigned-integer32 int))
                                           (function void (unsigned-integer32 int int int))))

(define draw-soft-line (foreign-lambda void "al_draw_soft_line" vertex vertex unsigned-integer32
                                       (function void (unsigned-integer32 int int vertex vertex))
                                       (function void (unsigned-integer32 int))
                                       (function void (unsigned-integer32 int int))))

(define draw-line (foreign-lambda* void ((float x1) (float y1) (float x2) (float y2) (color c) (float thickness)) "al_draw_line(x1, y1, x2, y2, *c, thickness);"))
(define draw-triangle (foreign-lambda* void ((float x1) (float y1) (float x2) (float y2) (float x3) (float y3) (color c) (float thickness)) "al_draw_triangle(x1, y1, x2, y2, x3, y3, *c, thickness);"))
(define draw-rectangle (foreign-lambda* void ((float x1) (float y1) (float x2) (float y2) (color c) (float thickness)) "al_draw_rectangle(x1, y1, x2, y2, *c, thickness);"))
(define draw-rounded-rectangle (foreign-lambda* void ((float x1) (float y1) (float x2) (float y2) (float rx) (float ry) (color c) (float thickness)) "al_draw_rounded_rectangle(x1, y1, x2, y2, rx, ry, *c, thickness);"))

(define draw-circle (foreign-lambda* void ((float cx) (float cy) (float r) (color c) (float thickness)) "al_draw_circle(cx, cy, r, *c, thickness);"))
(define draw-ellipse (foreign-lambda* void ((float cx) (float cy) (float rx) (float ry) (color c) (float thickness)) "al_draw_ellipse(cx, cy, rx, ry, *c, thickness);"))
(define draw-arc (foreign-lambda* void ((float cx) (float cy) (float r) (float start_theta) (float delta_theta) (color c) (float thickness)) "al_draw_arc(cx, cy, r, start_theta, delta_theta, *c, thickness);"))

(define draw-spline (foreign-lambda* void ((f32vector points) (color c) (float thickness)) "al_draw_spline(points, *c, thickness);"))

(define draw-ribbon (foreign-lambda* void ((f32vector points) (integer32 stride) (color c) (float thickness) (integer32 num_segments)) "al_draw_ribbon(points, stride, *c, thickness, num_segments);"))

(define draw-triangle/fill (foreign-lambda* void ((float x1) (float y1) (float x2) (float y2) (float x3) (float y3) (color c) ) "al_draw_filled_triangle(x1, y1, x2, y2, x3, y3, *c);"))
(define draw-rectangle/fill (foreign-lambda* void ((float x1) (float y1) (float x2) (float y2) (color c) ) "al_draw_filled_rectangle(x1, y1, x2, y2, *c);"))
(define draw-rounded-rectangle/fill (foreign-lambda* void ((float x1) (float y1) (float x2) (float y2) (float rx) (float ry) (color c) ) "al_draw_filled_rounded_rectangle(x1, y1, x2, y2, rx, ry, *c);"))
(define draw-circle/fill (foreign-lambda* void ((float cx) (float cy) (float r) (color c) ) "al_draw_filled_circle(cx, cy, r, *c);"))
(define draw-ellipse/fill (foreign-lambda* void ((float cx) (float cy) (float rx) (float ry) (color c)) "al_draw_filled_ellipse(cx, cy, rx, ry, *c);"))

(define calculate-arc (foreign-lambda* float ((integer32 stride) (float cx) (float cy) (float rx) (float ry) (float start_theta) (float delta_theta) (float thickness) (integer32 num_segments)) "
float dest;
al_calculate_arc(&dest, stride, cx, cy, rx, ry, start_theta, delta_theta, thickness, num_segments);
C_return(dest);
"))
(define calculate-spline (foreign-lambda* float ((integer32 stride) (f32vector points) (float thickness) (int num_segments)) "
float dest;
al_calculate_spline(&dest, stride, points, thickness, num_segments);
C_return(dest);
"))
(define calculate-ribbon (foreign-lambda* float ((integer32 dest_stride) ((const f32vector) points) (integer32 points_stride) (float thickness) (integer32 num_segments)) "
float dest;
al_calculate_ribbon(&dest, dest_stride, points, points_stride, thickness, num_segments);
C_return(dest);
"))
