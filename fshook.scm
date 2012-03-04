(define make-fs-entry (foreign-lambda fs-entry "al_create_fs_entry" (const c-string)))
(define free-fs-entry (foreign-lambda void "al_destroy_fs_entry" fs-entry))

(define fs-entry-name (foreign-lambda (const c-string) "al_get_fs_entry_name" fs-entry))
(define fs-entry-update (foreign-lambda bool "al_update_fs_entry" fs-entry))
(define fs-entry-mode (foreign-lambda unsigned-integer32 "al_get_fs_entry_mode" fs-entry))
(define fs-entry-atime (foreign-lambda unsigned-integer32 "al_get_fs_entry_atime" fs-entry))
(define fs-entry-mtime (foreign-lambda unsigned-integer32 "al_get_fs_entry_mtime" fs-entry))
(define fs-entry-ctime (foreign-lambda unsigned-integer32 "al_get_fs_entry_ctime" fs-entry))
(define fs-entry-size (foreign-lambda unsigned-integer32 "al_get_fs_entry_size" fs-entry))
(define fs-entry-exist? (foreign-lambda bool "al_fs_entry_exists" fs-entry))
(define fs-entry-remove! (foreign-lambda bool "al_remove_fs_entry" fs-entry))
(define fs-entry-open (foreign-lambda opaque_file "al_open_fs_entry" fs-entry (const c-string)))

(define directory-open (foreign-lambda bool "al_open_directory" fs-entry))
(define directory-read (foreign-lambda fs-entry "al_read_directory" fs-entry))
(define directory-close (foreign-lambda bool "al_close_directory" fs-entry))

(define current-directory (foreign-lambda c-string "al_get_current_directory"))
(define change-directory (foreign-lambda bool "al_change_directory" (const c-string)))
(define make-directory (foreign-lambda bool "al_make_directory" (const c-string)))

(define filename-exists? (foreign-lambda bool "al_filename_exists" (const c-string)))
(define filename-remove! (foreign-lambda bool "al_remove_filename" (const c-string)))

(define new-file-interface (foreign-lambda (const opaque_file_interface) "al_get_new_file_interface"))

(define fs-interface-current (foreign-lambda (const fs-interface) "al_get_fs_interface"))
(define fs-interface-current-set! (foreign-lambda void "al_set_fs_interface" (const fs-interface)))

(define fs-interface-standard-set! (foreign-lambda void "al_set_standard_fs_interface"))
