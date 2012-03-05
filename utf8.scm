(define make-utf-string (foreign-lambda utf-string "al_ustr_new" c-string))
(define make-utf-string-from-buffer (foreign-lambda utf-string "al_ustr_new_from_buffer" blob integer))

(define free-utf-string (foreign-lambda void "al_ustr_free" utf-string))

(define utf->string (foreign-lambda c-string "al_cstr" utf-string))
(define utf->buffer (foreign-lambda void "al_ustr_to_buffer" utf-string blob integer))
(define utf->string-copy (foreign-lambda c-string "al_cstr_dup" utf-string))

(define utf-copy (foreign-lambda utf-string "al_ustr_dup" utf-string))
(define utf-substring (foreign-lambda utf-string "al_ustr_dup_substr" utf-string integer integer))

(define utf-empty-string (foreign-lambda utf-string "al_ustr_empty_string"))

(define utf-reference-cstr (foreign-lambda utf-string "al_ref_cstr" utf-string (const c-string)))
(define utf-reference-buffer (foreign-lambda utf-string "al_ref_buffer" utf-string (const c-string) unsigned-integer32))
(define utf-reference-utf-string (foreign-lambda utf-string "al_ref_ustr" utf-string (const utf-string) integer integer))

(define utf-size? (foreign-lambda integer "al_ustr_size" utf-string))
(define utf-length? (foreign-lambda integer "al_ustr_length" utf-string))

(define utf-offset (foreign-lambda integer "al_ustr_offset" utf-string integer))

(define utf-next (foreign-lambda* integer (((const utf-string) us)) "
int pos = 0;
if (al_ustr_next(us, &pos))
  C_return(pos);
else
  C_return(C_SCHEME_FALSE);
"))
(define utf-previous (foreign-lambda* integer (((const utf-string) us)) "
int pos = 0;
if (al_ustr_prev(us, &pos))
  C_return(pos);
else
  C_return(C_SCHEME_FALSE);
"))

(define utf-get (foreign-lambda integer32 "al_ustr_get" utf-string integer))

;; AL_FUNC(int32_t, al_ustr_get_next, (const ALLEGRO_USTR *us, int *pos));
;; AL_FUNC(int32_t, al_ustr_prev_get, (const ALLEGRO_USTR *us, int *pos));

(define utf-insert! (foreign-lambda bool "al_ustr_insert" utf-string integer utf-string))
(define utf-insert-string! (foreign-lambda bool "al_ustr_insert_cstr" utf-string integer c-string))
(define utf-insert-char! (foreign-lambda integer "al_ustr_insert_chr" utf-string integer integer32))

(define utf-append! (foreign-lambda bool "al_ustr_append" utf-string utf-string))
(define utf-append-string! (foreign-lambda bool "al_ustr_append_cstr" utf-string c-string))
(define utf-append-char! (foreign-lambda integer "al_ustr_append_chr" utf-string integer))

;; AL_PRINTFUNC(bool, al_ustr_appendf, (ALLEGRO_USTR *us, const char *fmt, ...),
;;       2, 3);
;; AL_FUNC(bool, al_ustr_vappendf, (ALLEGRO_USTR *us, const char *fmt,
;;       va_list ap));

(define utf-remove-char! (foreign-lambda bool "al_ustr_remove_chr" utf-string integer))
(define utf-remove-range! (foreign-lambda bool "al_ustr_remove_range" utf-string integer integer))
(define utf-truncate! (foreign-lambda bool "al_ustr_truncate" utf-string integer))
(define utf-ltrim! (foreign-lambda bool "al_ustr_ltrim_ws" utf-string))
(define utf-rtrim! (foreign-lambda bool "al_ustr_rtrim_ws" utf-string))
(define utf-trim! (foreign-lambda bool "al_ustr_trim_ws" utf-string))

(define utf-assign! (foreign-lambda bool "al_ustr_assign" utf-string utf-string))
(define utf-assign-substring! (foreign-lambda bool "al_ustr_assign_substr" utf-string utf-string integer integer))
(define utf-assign-string! (foreign-lambda bool "al_ustr_assign_cstr" utf-string c-string))

(define utf-set-char! (foreign-lambda integer "al_ustr_set_chr" utf-string integer integer32))
(define utf-replace-range! (foreign-lambda bool "al_ustr_replace_range" utf-string integer integer utf-string))

(define utf-find (foreign-lambda integer "al_ustr_find_str" utf-string integer utf-string))
(define utf-find-string (foreign-lambda integer "al_ustr_find_cstr" utf-string integer c-string))
(define utf-find-char (foreign-lambda integer "al_ustr_find_chr" utf-string integer integer32))
(define utf-find-set (foreign-lambda integer "al_ustr_find_set" utf-string integer utf-string))
(define utf-find-set-string (foreign-lambda integer "al_ustr_find_set_cstr" utf-string integer c-string))
(define utf-find-cset (foreign-lambda integer "al_ustr_find_cset" utf-string integer utf-string))
(define utf-find-cset-string (foreign-lambda integer "al_ustr_find_cset_cstr" utf-string integer c-string))

(define utf-rfind (foreign-lambda integer "al_ustr_rfind_str" utf-string integer utf-string))
(define utf-rfind-char (foreign-lambda integer "al_ustr_rfind_chr" utf-string integer integer32))
(define utf-rfind-string (foreign-lambda integer "al_ustr_rfind_cstr" utf-string integer c-string))

(define utf-find&replace! (foreign-lambda bool "al_ustr_find_replace" utf-string integer utf-string utf-string))
(define utf-find&replace-string! (foreign-lambda bool "al_ustr_find_replace_cstr" utf-string integer c-string c-string))

(define utf-equal? (foreign-lambda bool "al_ustr_equal" utf-string utf-string))
(define utf-compare (foreign-lambda integer "al_ustr_compare" utf-string utf-string))
(define utf-ncompare (foreign-lambda integer "al_ustr_ncompare" utf-string utf-string integer))

(define utf-prefix? (foreign-lambda bool "al_ustr_has_prefix" utf-string utf-string))
(define utf-prefix-string? (foreign-lambda bool "al_ustr_has_prefix_cstr" utf-string c-string))

(define utf-suffix? (foreign-lambda bool "al_ustr_has_suffix" utf-string utf-string))
(define utf-suffix-string? (foreign-lambda bool "al_ustr_has_suffix_cstr" utf-string c-string))

(define utf8-width? (foreign-lambda integer "al_utf8_width" integer32))
(define utf8-encode! (foreign-lambda integer "al_utf8_encode" blob integer32))

;; AL_FUNC(size_t, al_ustr_size_utf16, (const ALLEGRO_USTR *us));
;; AL_FUNC(size_t, al_ustr_encode_utf16, (const ALLEGRO_USTR *us, uint16_t *s, size_t n));
;; AL_FUNC(size_t, al_utf16_width, (int c));
;; AL_FUNC(size_t, al_utf16_encode, (uint16_t s[], int32_t c));




