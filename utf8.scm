(bind-opaque-type utf_string (c-pointer (struct _al_tagbstring)))
(bind-opaque-type utf_string_info (c-pointer (struct _al_tagbstring)))

(define make-utf-string (foreign-lambda utf_string "al_ustr_new" c-string))
(define make-utf-string-from-buffer (foreign-lambda utf_string "al_ustr_new_from_buffer" blob integer))

(define free-utf-string (foreign-lambda void "al_ustr_free" utf_string))

(define utf-to-string (foreign-lambda c-string "al_cstr" utf_string))
(define utf-to-buffer (foreign-lambda void "al_ustr_to_buffer" utf_string blob integer))
(define utf-to-string-copy (foreign-lambda c-string "al_cstr_dup" utf_string))
(define utf-copy (foreign-lambda utf_string "al_ustr_dup" utf_string))
(define utf-substring (foreign-lambda utf_string "al_ustr_dup_substr" utf_string integer integer))

(define utf-empty-string (foreign-lambda utf_string "al_ustr_empty_string"))

;; /* Reference strings */
;; AL_FUNC(ALLEGRO_USTR *, al_ref_cstr, (ALLEGRO_USTR_INFO *info, const char *s));
;; AL_FUNC(ALLEGRO_USTR *, al_ref_buffer, (ALLEGRO_USTR_INFO *info, const char *s,
;;       size_t size));
;; AL_FUNC(ALLEGRO_USTR *, al_ref_ustr, (ALLEGRO_USTR_INFO *info,
;;       const ALLEGRO_USTR *us, int start_pos, int end_pos));

(define utf-size? (foreign-lambda integer "al_ustr_size" utf_string))
(define utf-length? (foreign-lambda integer "al_ustr_length" utf_string))

(define utf-offset (foreign-lambda integer "al_ustr_offset" utf_string integer))

;; AL_FUNC(bool, al_ustr_next, (const ALLEGRO_USTR *us, int *pos));
;; AL_FUNC(bool, al_ustr_prev, (const ALLEGRO_USTR *us, int *pos));

(define utf-get (foreign-lambda integer32 "al_ustr_get" utf_string integer))

;; AL_FUNC(int32_t, al_ustr_get_next, (const ALLEGRO_USTR *us, int *pos));
;; AL_FUNC(int32_t, al_ustr_prev_get, (const ALLEGRO_USTR *us, int *pos));

(define utf-insert! (foreign-lambda bool "al_ustr_insert" utf_string integer utf_string))
(define utf-insert-string! (foreign-lambda bool "al_ustr_insert_cstr" utf_string integer c-string))
(define utf-insert-char! (foreign-lambda integer "al_ustr_insert_chr" utf_string integer integer32))

(define utf-append! (foreign-lambda bool "al_ustr_append" utf_string utf_string))
(define utf-append-string! (foreign-lambda bool "al_ustr_append_cstr" utf_string c-string))
(define utf-append-char! (foreign-lambda integer "al_ustr_append_chr" utf_string integer))

;; AL_PRINTFUNC(bool, al_ustr_appendf, (ALLEGRO_USTR *us, const char *fmt, ...),
;;       2, 3);
;; AL_FUNC(bool, al_ustr_vappendf, (ALLEGRO_USTR *us, const char *fmt,
;;       va_list ap));

(define utf-remove-char! (foreign-lambda bool "al_ustr_remove_chr" utf_string integer))
(define utf-remove-range! (foreign-lambda bool "al_ustr_remove_range" utf_string integer integer))
(define utf-truncate! (foreign-lambda bool "al_ustr_truncate" utf_string integer))
(define utf-ltrim! (foreign-lambda bool "al_ltrim_ws" utf_string))
(define utf-rtrim! (foreign-lambda bool "al_rtrim_ws" utf_string))
(define utf-trim! (foreign-lambda bool "al_ustr_trim_ws" utf_string))

(define utf-assign! (foreign-lambda bool "al_ustr_assign" utf_string utf_string))
(define utf-assign_substring! (foreign-lambda bool "al_ustr_assign_substr" utf_string utf_string integer integer))
(define utf-assign-string! (foreign-lambda bool "al_ustr_assign_cstr" utf_string c-string))

(define utf-set-char! (foreign-lambda integer "al_ustr_set_chr" utf_string integer integer32))
(define utf-replace-range! (foreign-lambda bool "al_ustr_replace_range" utf_string integer integer utf_string))

;; /* Searching */
;; AL_FUNC(int, al_ustr_find_chr, (const ALLEGRO_USTR *us, int start_pos,
;;       int32_t c));
;; AL_FUNC(int, al_ustr_rfind_chr, (const ALLEGRO_USTR *us, int start_pos,
;;       int32_t c));
;; AL_FUNC(int, al_ustr_find_set, (const ALLEGRO_USTR *us, int start_pos,
;;       const ALLEGRO_USTR *accept));
;; AL_FUNC(int, al_ustr_find_set_cstr, (const ALLEGRO_USTR *us, int start_pos,
;;       const char *accept));
;; AL_FUNC(int, al_ustr_find_cset, (const ALLEGRO_USTR *us, int start_pos,
;;       const ALLEGRO_USTR *reject));
;; AL_FUNC(int, al_ustr_find_cset_cstr, (const ALLEGRO_USTR *us, int start_pos,
;;       const char *reject));
;; AL_FUNC(int, al_ustr_find_str, (const ALLEGRO_USTR *haystack, int start_pos,
;;       const ALLEGRO_USTR *needle));
;; AL_FUNC(int, al_ustr_find_cstr, (const ALLEGRO_USTR *haystack, int start_pos,
;;       const char *needle));
;; AL_FUNC(int, al_ustr_rfind_str, (const ALLEGRO_USTR *haystack, int start_pos,
;;       const ALLEGRO_USTR *needle));
;; AL_FUNC(int, al_ustr_rfind_cstr, (const ALLEGRO_USTR *haystack, int start_pos,
;;       const char *needle));
;; AL_FUNC(bool, al_ustr_find_replace, (ALLEGRO_USTR *us, int start_pos,
;;       const ALLEGRO_USTR *find, const ALLEGRO_USTR *replace));
;; AL_FUNC(bool, al_ustr_find_replace_cstr, (ALLEGRO_USTR *us, int start_pos,
;;       const char *find, const char *replace));

;; /* Compare */
;; AL_FUNC(bool, al_ustr_equal, (const ALLEGRO_USTR *us1, const ALLEGRO_USTR *us2));
;; AL_FUNC(int, al_ustr_compare, (const ALLEGRO_USTR *u, const ALLEGRO_USTR *v));
;; AL_FUNC(int, al_ustr_ncompare, (const ALLEGRO_USTR *us1, const ALLEGRO_USTR *us2,
;;       int n));
;; AL_FUNC(bool, al_ustr_has_prefix,(const ALLEGRO_USTR *u, const ALLEGRO_USTR *v));
;; AL_FUNC(bool, al_ustr_has_prefix_cstr, (const ALLEGRO_USTR *u, const char *s));
;; AL_FUNC(bool, al_ustr_has_suffix,(const ALLEGRO_USTR *u, const ALLEGRO_USTR *v));
;; AL_FUNC(bool, al_ustr_has_suffix_cstr,(const ALLEGRO_USTR *us1, const char *s));

;; /* Low level UTF-8 functions */
;; AL_FUNC(size_t, al_utf8_width, (int32_t c));
;; AL_FUNC(size_t, al_utf8_encode, (char s[], int32_t c));

;; /* UTF-16 */
;; AL_FUNC(ALLEGRO_USTR *, al_ustr_new_from_utf16, (uint16_t const *s));
;; AL_FUNC(size_t, al_ustr_size_utf16, (const ALLEGRO_USTR *us));
;; AL_FUNC(size_t, al_ustr_encode_utf16, (const ALLEGRO_USTR *us, uint16_t *s, size_t n));
;; AL_FUNC(size_t, al_utf16_width, (int c));
;; AL_FUNC(size_t, al_utf16_encode, (uint16_t s[], int32_t c));
