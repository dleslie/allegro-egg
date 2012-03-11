(define memory-interface-set! (foreign-lambda void "al_set_memory_interface" memory-interface))

(define malloc* (foreign-lambda c-pointer "al_malloc" integer32))
(define (malloc i)
  (let ((ptr (malloc* i)))
    (set-finalizer! ptr free!)
    ptr))

(define free! (foreign-lambda void "al_free" c-pointer))

(define realloc* (foreign-lambda c-pointer "al_realloc" c-pointer integer32))
(define (realloc p i)
  (let ((ptr (realloc* p i)))
    (set-finalizer! ptr free!)
    ptr))

(define calloc* (foreign-lambda c-pointer "al_calloc" integer32 integer32))
(define (calloc i1 i2)
  (let ((ptr (calloc* i1 i2)))
    (set-finalizer! ptr free!)
    ptr))

(define malloc/context* (foreign-lambda c-pointer "al_malloc_with_context" integer32 integer (const c-string) (const c-string)))
(define (malloc/context i1 i2 str1 str2)
  (let ((ptr (malloc/context* i1 i2 str1 str2)))
    (set-finalizer! ptr (lambda (p) (free/context! p i2 str1 str2)))
    ptr))

(define free/context! (foreign-lambda void "al_free_with_context" c-pointer integer (const c-string) (const c-string)))

(define realloc/context* (foreign-lambda c-pointer "al_realloc_with_context" c-pointer integer32 integer (const c-string) (const c-string)))
(define (realloc/context p i1 i2 str1 str2)
  (let ((ptr (realloc/context* p i1 i2 str1 str2)))
    (set-finalizer! ptr (lambda (p) (free/context! p i2 str1 str2)))
    ptr))

(define calloc/context* (foreign-lambda c-pointer "al_calloc_with_context" integer32 integer32 integer (const c-string) (const c-string)))
(define (calloc/context i1 i2 i3 str1 str2)
  (let ((ptr (calloc/context* i1 i2 i3 str1 str2)))
    (set-finalizer! ptr (lambda (p) (free/context! p i3 str1 str2)))
    ptr))
