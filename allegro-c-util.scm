#>
#include <assert.h>
<#

(module allegro-c-util *
		(import scheme chicken foreign lolevel)

		(define (make-c-string-list items)
		  (if (list? items)
			  (let ((ptr ((foreign-lambda* c-pointer ((scheme-object items) (unsigned-integer32 count))
"
	char ** retVal = (char **)C_malloc(sizeof(char *) * (count + 1));
	C_word *obj = C_data_pointer(items);
	char ** pos = retVal;
	while (*obj != C_SCHEME_END_OF_LIST)
	{
		assert(C_truep(C_stringp(*obj)));

		*pos = C_c_string(*obj);

		obj++;
		pos++;
	}
    *pos = NULL;
	C_return ((void *)retVal);
"
) items (length items))))
				(set-finalizer! ptr free)
				  ptr)
			  (make-c-string-list (list items)))))
