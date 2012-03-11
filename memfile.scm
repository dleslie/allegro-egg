(define open-memfile* (foreign-safe-lambda* file ((c-pointer mem) (unsigned-integer64 size) ((const c-string) mode)) "
ALLEGRO_FILE *file = (ALLEGRO_FILE *)al_open_memfile(mem, size, mode);
C_return(file);
"))
(define (open-memfile ptr i str)
  (let ((f (open-memfile* ptr i str)))
    (set-finalizer! f free&close-file!)
    f))

(define memfile-version (foreign-lambda unsigned-integer32 "al_get_allegro_memfile_version"))
