;; (define native-path-separator (foreign-value "ALLEGRO_NATIVE_PATH_SEP" c-string))
;; (define native-drive-separator (foreign-value "ALLEGRO_NATIVE_DRIVE_SEP" c-string))

(define make-path (foreign-lambda opaque_path "al_create_path" c-string))
(define make-path-for-directory (foreign-lambda opaque_path "al_create_path_for_directory" c-string))
(define free-path (foreign-lambda void "al_destroy_path" opaque_path))

(define path-component-count (foreign-lambda integer "al_get_path_num_components" opaque_path))
(define path-component (foreign-lambda c-string "al_get_path_component" opaque_path integer))
(define path-component-set! (foreign-lambda void "al_replace_path_component" opaque_path integer c-string))
(define path-component-remove! (foreign-lambda void "al_remove_path_component" opaque_path integer))
(define path-component-insert! (foreign-lambda void "al_insert_path_component" opaque_path integer c-string))

(define path-clone (foreign-lambda opaque_path "al_clone_path" opaque_path))
(define path-tail (foreign-lambda c-string "al_get_path_tail" opaque_path))
(define path->string (foreign-lambda c-string "al_path_cstr" opaque_path char))

(define path-drop-tail! (foreign-lambda void "al_drop_path_tail" opaque_path))
(define path-append! (foreign-lambda void "al_append_path_component" opaque_path c-string))
(define path-join! (foreign-lambda bool "al_join_paths" opaque_path opaque_path))
(define path-rebase! (foreign-lambda bool "al_rebase_path" opaque_path opaque_path))

(define path-drive-set! (foreign-lambda void "al_set_path_drive" opaque_path c-string))
(define path-drive (foreign-lambda c-string "al_get_path_drive" opaque_path))

(define path-filename-set! (foreign-lambda void "al_set_path_filename" opaque_path c-string))
(define path-filename (foreign-lambda c-string "al_get_path_filename" opaque_path))

(define path-extension-set! (foreign-lambda bool "al_set_path_extension" opaque_path c-string))
(define path-extension (foreign-lambda c-string "al_get_path_extension" opaque_path))

(define path-basename (foreign-lambda c-string "al_get_path_basename" opaque_path))

(define path-make-canonical! (foreign-lambda bool "al_make_path_canonical" opaque_path))
