(define make-config (foreign-lambda (c-pointer (struct ALLEGRO_CONFIG)) "al_create_config"))

(define config-section-add (foreign-lambda void "al_add_config_section" (c-pointer (struct ALLEGRO_CONFIG)) c-string))
(define config-value-set! (foreign-lambda void "al_set_config_value" (c-pointer (struct ALLEGRO_CONFIG)) c-string c-string c-string))
(define config-comment-add (foreign-lambda void "al_add_config_comment" (c-pointer (struct ALLEGRO_CONFIG)) c-string c-string))
(define config-value (foreign-lambda c-string "al_get_config_value" (c-pointer (struct ALLEGRO_CONFIG)) c-string c-string))

(define config-load (foreign-lambda (c-pointer (struct ALLEGRO_CONFIG)) "al_load_config_file" c-string))
(define config-load-file (foreign-lambda (c-pointer (struct ALLEGRO_CONFIG)) "al_load_config_file_f" (c-pointer (struct ALLEGRO_FILE))))
(define config-save (foreign-lambda bool "al_save_config_file" c-string (c-pointer (struct ALLEGRO_CONFIG))))
(define config-save-file (foreign-lambda bool "al_save_config_file_f" (c-pointer (struct ALLEGRO_FILE)) (c-pointer (struct ALLEGRO_CONFIG))))
(define config-merge! (foreign-lambda void "al_merge_config_into" (c-pointer (struct ALLEGRO_CONFIG)) (c-pointer (struct ALLEGRO_CONFIG))))
(define config-merge (foreign-lambda (c-pointer (struct ALLEGRO_CONFIG)) "al_merge_config" (c-pointer (struct ALLEGRO_CONFIG)) (c-pointer (struct ALLEGRO_CONFIG))))
(define config-destroy! (foreign-lambda void "al_destroy_config" (c-pointer (struct ALLEGRO_CONFIG))))

(define-external config_section_iterator (c-pointer (struct ALLEGRO_CONFIG_SECTION)))
(define (config-sections config)
  (define get-first (foreign-lambda* c-string (((c-pointer (struct ALLEGRO_CONFIG)) allegro_config)) "C_return(al_get_first_config_section(allegro_config, &config_section_iterator));"))
  (define get-next (foreign-lambda* (c-pointer (struct ConfigIterContainer)) () "C_return(al_get_next_config_section(&config_section_iterator));"))
  (define (do-next)
    (cond 
     ((not config_section_iterator) #f)
     (else (cons (get-next) (delay (do-next))))))
  (cons (get-first config) (delay (do-next))))

(define-external config_entry_iterator (c-pointer (struct ALLEGRO_CONFIG_ENTRY)))
(define (config-entries config section)
  (define get-first (foreign-lambda* c-string (((c-pointer (struct ALLEGRO_CONFIG)) allegro_config) (c-string section)) "C_return(al_get_first_config_entry(allegro_config, section, &config_entry_iterator));"))
  (define get-next (foreign-lambda* (c-pointer (struct ConfigIterContainer)) ((c-string section)) "C_return(al_get_next_config_entry(&config_entry_iterator));"))
  (define (do-next)
    (cond 
     ((not config_entry_iterator) #f)
     (else (cons (get-next section) (delay (do-next))))))
  (cons (get-first config section) (delay (do-next))))



