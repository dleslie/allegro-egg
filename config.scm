(define make-config (foreign-lambda opaque_config "al_create_config"))
(define free-config (foreign-lambda void "al_destroy_config" opaque_config))

(define config-section-add! (foreign-lambda void "al_add_config_section" opaque_config c-string))
(define config-value-set! (foreign-lambda void "al_set_config_value" opaque_config c-string c-string c-string))
(define config-comment-add! (foreign-lambda void "al_add_config_comment" opaque_config c-string c-string))
(define config-value (foreign-lambda c-string "al_get_config_value" opaque_config c-string c-string))

(define config-load (foreign-lambda opaque_config "al_load_config_file" c-string))
(define config-load-file (foreign-lambda opaque_config "al_load_config_file_f" opaque_file))
(define config-save (foreign-lambda bool "al_save_config_file" c-string opaque_config))
(define config-save-file (foreign-lambda bool "al_save_config_file_f" opaque_file opaque_config))
(define config-merge! (foreign-lambda void "al_merge_config_into" opaque_config opaque_config))
(define config-merge (foreign-lambda opaque_config "al_merge_config" opaque_config opaque_config))

;; TODO: internalize the iterator
(define-external config_section_iterator opaque_config_section)
(define (config-sections config)
  (define get-first (foreign-lambda* c-string ((opaque_config allegro_config) (opaque_config_section iterator)) "C_return(al_get_first_config_section(allegro_config, &iterator));"))
  (define get-next (foreign-lambda* c-string ((opaque_config_section iterator)) "C_return(al_get_next_config_section(&iterator));"))
  (define (do-next)
    (cond 
     ((not config_section_iterator) #f)
     (else (cons (get-next config_section_iterator) (delay (do-next))))))
  (cons (get-first config config_section_iterator) (delay (do-next))))

;; TODO: internalize the iterator
(define-external config_entry_iterator opaque_config_entry)
(define (config-entries config section)
  (define get-first (foreign-lambda* c-string ((opaque_config allegro_config) (c-string section) (opaque_config_entry iterator)) "C_return(al_get_first_config_entry(allegro_config, section, &iterator));"))
  (define get-next (foreign-lambda* c-string ((opaque_config_entry iterator)) "C_return(al_get_next_config_entry(&iterator));"))
  (define (do-next)
    (cond 
     ((not config_entry_iterator) #f)
     (else (cons (get-next section) (delay (do-next))))))
  (cons (get-first config section config_entry_iterator) (delay (do-next))))
