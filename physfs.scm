(define physfs-file-interface-set! (foreign-lambda void "al_set_physfs_file_interface"))
(define physfs-addon-version (foreign-lambda unsigned-integer32 "al_get_allegro_physfs_version"))
