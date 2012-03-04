;; ALLEGRO_MEMFILE_FUNC(ALLEGRO_FILE *, al_open_memfile, (void *mem, int64_t size, const char *mode));
;; ALLEGRO_MEMFILE_FUNC(uint32_t, al_get_allegro_memfile_version, (void));

(define open-memfile (foreign-lambda opaque_file "al_open_memfile" c-pointer unsigned-integer64 (const c-string)))
(define memfile-version (foreign-lambda unsigned-integer32 "al_get_allegro_memfile_version"))
