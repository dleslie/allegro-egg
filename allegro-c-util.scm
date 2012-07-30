#>
#include <assert.h>
<#

(module allegro-c-util *
		(import scheme chicken lolevel foreign)

		(define (make-c-string-list* items)
		  (if (list? items)
			  (letrec ((malloc-list (foreign-lambda* (c-pointer (c-pointer char)) ((int count)) "C_return((char **)C_malloc(sizeof(char *) * (count + 1)));"))
					   (string-data-pointer (foreign-lambda* c-pointer ((scheme-object str)) "C_return((char *)C_data_pointer(str));"))
					   (pointer-list-set! (foreign-lambda* void (((c-pointer (c-pointer char)) pv) (int idx) ((c-pointer char) ptr)) "pv[idx] = ptr;"))
					   (add-rest 
						(lambda (l idx pv)
						  (if (not (null? l))
							  (begin
								(assert (string? (car l)) "All items must be strings!")
								(pointer-list-set! pv idx (string-data-pointer (car l)))
								(add-rest (cdr l) (+ idx 1) pv))
							  (begin
								(pointer-list-set! pv idx #f)
								pv)))))
				(add-rest items 0 (malloc-list (length items))))
			  (make-c-string-list* (list items))))

		(define (make-c-string-list items)
		  (let ((c-list (make-c-string-list* items)))
			(set-finalizer! c-list (foreign-lambda* void (((c-pointer (c-pointer char)) l)) "C_free(l);")))))
