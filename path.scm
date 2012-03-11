(define make-path* (foreign-lambda path "al_create_path" c-string))
(define (make-path s)
  (let ((p (make-path* s)))
    (set-finalizer! p free-path!)
    p))

(define make-path-for-directory* (foreign-lambda path "al_create_path_for_directory" c-string))
(define (make-path-for-directory s)
  (let ((d (make-path-for-directory* s)))
    (set-finalizer! d free-path!)
    d))

(define free-path! (foreign-lambda void "al_destroy_path" path))

(define path->string (foreign-lambda c-string "al_path_cstr" path char))

(define path-component-count (foreign-lambda integer "al_get_path_num_components" path))
(define path-component (foreign-lambda c-string "al_get_path_component" path integer))
(define path-component-set! (foreign-lambda void "al_replace_path_component" path integer c-string))
(define path-component-remove! (foreign-lambda void "al_remove_path_component" path integer))
(define path-component-insert! (foreign-lambda void "al_insert_path_component" path integer c-string))

(define path-clone (foreign-lambda path "al_clone_path" path))
(define path-tail (foreign-lambda c-string "al_get_path_tail" path))

(define path-drop-tail! (foreign-lambda void "al_drop_path_tail" path))
(define path-append! (foreign-lambda void "al_append_path_component" path c-string))
(define path-join! (foreign-lambda bool "al_join_paths" path path))
(define path-rebase! (foreign-lambda bool "al_rebase_path" path path))

(define path-drive-set! (foreign-lambda void "al_set_path_drive" path c-string))
(define path-drive (foreign-lambda c-string "al_get_path_drive" path))

(define path-filename-set! (foreign-lambda void "al_set_path_filename" path c-string))
(define path-filename (foreign-lambda c-string "al_get_path_filename" path))

(define path-extension-set! (foreign-lambda bool "al_set_path_extension" path c-string))
(define path-extension (foreign-lambda c-string "al_get_path_extension" path))

(define path-basename (foreign-lambda c-string "al_get_path_basename" path))

(define path-make-canonical! (foreign-lambda bool "al_make_path_canonical" path))
