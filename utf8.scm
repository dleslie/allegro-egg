(define make-utf-string* (foreign-lambda utf-string "al_ustr_new" c-string))
(define (make-utf-string-from-buffer* b) ((foreign-lambda utf-string "al_ustr_new_from_buffer" blob integer) b (blob-size b)))

(define (make-utf-string str)
  (let ((s (make-utf-string* str)))
    (set-finalizer! s free-utf-string!)
    s))

(define (make-utf-string-from-buffer b)
  (let ((s (make-utf-string-from-buffer* b)))
    (set-finalizer! b free-utf-string!)
    s))

(define free-utf-string! (foreign-lambda void "al_ustr_free" utf-string))

(define utf->string (foreign-lambda c-string "al_cstr" utf-string))
(define (utf->buffer! s b) ((foreign-lambda void "al_ustr_to_buffer" utf-string blob integer) s b (blob-size b)))
(define utf->string-copy (foreign-lambda c-string "al_cstr_dup" utf-string))

(define utf-copy* (foreign-lambda utf-string "al_ustr_dup" utf-string))
(define (utf-copy str)
  (let ((s (utf-copy* str)))
    (set-finalizer! s free-utf-string!)
    s))

(define utf-substring* (foreign-lambda utf-string "al_ustr_dup_substr" utf-string integer integer))
(define (utf-substring str i1 i2)
  (let ((s (utf-substring str i1 i2)))
    (set-finalizer! s free-utf-string!)
    s))

(define utf-empty-string (foreign-lambda utf-string "al_ustr_empty_string"))

(define make-utf-null-string* (foreign-safe-lambda* utf-string () "
ALLEGRO_USTR *str = (ALLEGRO_USTR *)C_malloc(sizeof(ALLEGRO_USTR));
C_memset(str, 0, sizeof(ALLEGRO_USTR));
C_return(str);"))
(define (make-utf-null-string)
  (let ((str (make-utf-null-string*)))
    (set-finalizer! str free-utf-string!)
    str))

(define (utf-reference-cstr* cstr)
  (let ((str (make-utf-null-string*)))
    ((foreign-lambda utf-string "al_ref_cstr" utf-string (const c-string)) str cstr)
    str))

(define (utf-reference-cstr cstr)
  (let ((str (make-utf-null-string)))
    ((foreign-lambda utf-string "al_ref_cstr" utf-string (const c-string)) str cstr)
    str))

(define (utf-reference-buffer* b)
  (let ((str (make-utf-null-string*)))
    ((foreign-lambda utf-string "al_ref_buffer" utf-string (const c-string) unsigned-integer32) str b (blob-size b))
    str))

(define (utf-reference-buffer b)
  (let ((str (make-utf-null-string)))
    ((foreign-lambda utf-string "al_ref_buffer" utf-string (const c-string) unsigned-integer32) str b (blob-size b))
    str))

(define (utf-reference-utf-string* ustr start end)
  (let ((str (make-utf-null-string*)))
    ((foreign-lambda utf-string "al_ref_ustr" utf-string (const utf-string) integer integer) str ustr start end)
    str))

(define (utf-reference-utf-string ustr start end)
  (let ((str (make-utf-null-string)))
    ((foreign-lambda utf-string "al_ref_ustr" utf-string (const utf-string) integer integer) str ustr start end)
    str))

(define utf-size (foreign-lambda integer "al_ustr_size" utf-string))
(define utf-length (foreign-lambda integer "al_ustr_length" utf-string))

(define utf-offset (foreign-lambda integer "al_ustr_offset" utf-string integer))

(define utf-next (foreign-lambda* integer ((utf-string us) (integer pos)) "
if (al_ustr_next(us, &pos))
  C_return(pos);
else
  C_return(C_SCHEME_FALSE);
"))
(define utf-previous (foreign-lambda* integer ((utf-string us) (integer pos)) "
if (al_ustr_prev(us, &pos))
  C_return(pos);
else
  C_return(C_SCHEME_FALSE);
"))

(define utf-get (foreign-lambda integer32 "al_ustr_get" utf-string integer))

(define utf-get-next (foreign-safe-lambda* integer32 ((utf-string us) (integer pos)) "
int32_t val = al_ustr_get_next(us, &pos);
if (val >= 0)
{
  C_word *ptr = C_alloc(C_SIZEOF_LIST (2));
  C_return(C_list(&ptr, 2,  C_fix(val), C_fix(pos)));
}
else
  C_return(C_SCHEME_FALSE);
"))

(define utf-get-prev (foreign-safe-lambda* integer32 ((utf-string us) (integer pos)) "
int32_t val = al_ustr_prev_get(us, &pos);
if (val >= 0)
{
  C_word *ptr = C_alloc(C_SIZEOF_LIST (2));
  C_return(C_list(&ptr, 2, C_fix(val), C_fix(pos)));
}
else
  C_return(C_SCHEME_FALSE);
"))

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

(define utf8-width (foreign-lambda integer "al_utf8_width" integer32))
(define utf8-encode! (foreign-lambda integer "al_utf8_encode" blob integer32))

(define utf-string-utf16-size (foreign-lambda integer "al_ustr_size_utf16" (const utf-string)))
(define utf-string-utf16-encode (foreign-lambda* integer (((const utf-string) str) (blob data) (integer count)) "C_return(al_ustr_encode_utf16(str, (uint16_t *)data, count));"))
(define utf16-width (foreign-lambda integer "al_utf16_width" integer))
(define utf16-encode (foreign-lambda integer "al_utf16_encode" u16vector integer32))
