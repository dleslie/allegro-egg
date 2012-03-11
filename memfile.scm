(define open-memfile* (foreign-lambda file "al_open_memfile" c-pointer unsigned-integer64 (const c-string)))
(define (open-memfile ptr i str)
  (let ((f (open-memfile* ptr i str)))
    (set-finalizer! f free&close-file!)
    f))

(define memfile-version (foreign-lambda unsigned-integer32 "al_get_allegro_memfile_version"))
