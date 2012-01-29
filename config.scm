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

(foreign-declare #<<ENDC
typedef struct ConfigIterContainer
{
  const char *current;
  ALLEGRO_CONFIG_SECTION *next;
} ConfigIterContainer;
ENDC
)

(define (config-sections config)
  (define iter-current (foreign-lambda* c-string (((c-pointer (struct ConfigIterContainer)) container)) "C_return(container->current);"))
  (define iter-next (foreign-lambda* (c-pointer (struct ALLEGRO_CONFIG_SECTION)) (((c-pointer (struct ConfigIterContainer)) container)) "C_return(container->next);"))
  (define get-first (foreign-lambda* (c-pointer (struct ConfigIterContainer)) (((c-pointer (struct ALLEGRO_CONFIG)) allegro_config)) "
struct ConfigIterContainer container;
container.current = al_get_first_config_section(allegro_config, &container.next);
C_return(&container);
"))
  (define get-next (foreign-lambda* (c-pointer (struct ConfigIterContainer)) (((c-pointer (struct ALLEGRO_CONFIG_SECTION)) iter)) "
struct ConfigIterContainer container;
container.current = al_get_next_config_section(&iter);
C_return(&container);
"))
  (define first-iter (get-first config))
  (define (do-next iter)
    (cond 
     ((not iter) #f)
     (else (cons (iter-current iter) (delay (do-next (get-next iter)))))))
  (cons (iter-current first-iter) (delay (do-next first-iter))))

(foreign-declare #<<ENDC
typedef struct EntryIterContainer
{
  const char *current;
  ALLEGRO_CONFIG_ENTRY *next;
} EntryIterContainer;
ENDC
)

(define (config-entries config section)
  (define iter-current (foreign-lambda* c-string (((c-pointer (struct EntryIterContainer)) container)) "C_return(container->current);"))
  (define iter-next (foreign-lambda* (c-pointer (struct ALLEGRO_CONFIG_ENTRY)) (((c-pointer (struct EntryIterContainer)) container)) "C_return(container->next);"))
  (define get-first (foreign-lambda* (c-pointer (struct EntryIterContainer)) (((c-pointer (struct ALLEGRO_CONFIG)) allegro_config) (c-string section)) "
struct EntryIterContainer container;
container.current = al_get_first_config_entry(allegro_config, section, &container.next);
C_return(&container);
"))
  (define get-next (foreign-lambda* (c-pointer (struct EntryIterContainer)) (((c-pointer (struct ALLEGRO_CONFIG_ENTRY)) iter)) "
struct EntryIterContainer container;
container.current = al_get_next_config_entry(&iter);
C_return(&container);
"))
  (define first-iter (get-first config section))
  (define (do-next iter)
    (cond 
     ((not iter) #f)
     (else (cons (iter-current iter) (delay (do-next (get-next iter)))))))
  (cons (iter-current first-iter) (delay (do-next first-iter))))
