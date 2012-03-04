(define memory-interface-set! (foreign-lambda void "al_set_memory_interface" memory-interface))

(define malloc (foreign-lambda c-pointer "al_malloc" integer32))
(define free (foreign-lambda void "al_free" c-pointer))
(define realloc (foreign-lambda c-pointer "al_realloc" c-pointer integer32))
(define calloc (foreign-lambda c-pointer "al_calloc" integer32 integer32))

(define malloc/context (foreign-lambda c-pointer "al_malloc_with_context" integer32 integer (const c-string) (const c-string)))
(define free/context (foreign-lambda void "al_free_with_context" c-pointer integer (const c-string) (const c-string)))
(define realloc/context (foreign-lambda c-pointer "al_realloc_with_context" c-pointer integer32 integer (const c-string) (const c-string)))
(define calloc/context (foreign-lambda c-pointer "al_calloc_with_context" integer32 integer32 integer (const c-string) (const c-string)))
