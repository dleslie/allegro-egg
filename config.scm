(define make-config* (foreign-lambda config "al_create_config"))
(define (make-config)
  (let ((c (make-config*)))
    (set-finalizer! c free-config!)
    c))

(define free-config! (foreign-lambda void "al_destroy_config" config))

(define config-section-add! (foreign-lambda void "al_add_config_section" config c-string))
(define config-value-set! (foreign-lambda void "al_set_config_value" config c-string c-string c-string))
(define config-comment-add! (foreign-lambda void "al_add_config_comment" config c-string c-string))
(define config-value (foreign-lambda c-string "al_get_config_value" config c-string c-string))

(define load-config (foreign-lambda config "al_load_config_file" c-string))
(define load-config-from-file (foreign-lambda config "al_load_config_file_f" file))

(define (config-save c s) ((foreign-lambda bool "al_save_config_file" c-string config) s c))
(define (config-save-to-file c f) ((foreign-lambda bool "al_save_config_file_f" file config) f c))

(define config-merge! (foreign-lambda void "al_merge_config_into" config config))
(define config-merge (foreign-lambda config "al_merge_config" config config))

(define (config-sections config)
  (define config-section-iterator ((foreign-primitive config-section () "C_return(C_malloc(sizeof(void *)));")))
  (define get-first (foreign-lambda* c-string ((config allegro_config) (config-section iterator)) "C_return(al_get_first_config_section(allegro_config, &iterator));"))
  (define get-next (foreign-lambda* c-string ((config-section iterator)) "C_return(al_get_next_config_section(&iterator));"))
  (define (do-next)
    (cond 
     ((not config-section-iterator) #f)
     (else (cons (get-next config-section-iterator) (delay (do-next))))))
  (cons (get-first config config-section-iterator) (delay (do-next))))

(define (config-entries config section)
  (define config-entry-iterator ((foreign-primitive config-entry () "C_return(C_malloc(sizeof(void *)));")))
  (define get-first (foreign-lambda* c-string ((config allegro_config) (c-string section) (config-entry iterator)) "C_return(al_get_first_config_entry(allegro_config, section, &iterator));"))
  (define get-next (foreign-lambda* c-string ((config-entry iterator)) "C_return(al_get_next_config_entry(&iterator));"))
  (define (do-next)
    (cond 
     ((not config-entry-iterator) #f)
     (else (cons (get-next section) (delay (do-next))))))
  (cons (get-first config section config-entry-iterator) (delay (do-next))))
