(define init (foreign-lambda bool "al_init"))
(define inhibit-screensaver (foreign-lambda bool "al_inhibit_screensaver" bool))

(define org-name (foreign-lambda c-string "al_get_org_name"))
(define org-name-set! (foreign-lambda void "al_set_org_name" c-string))

(define app-name (foreign-lambda c-string "al_get_app_name"))
(define app-name-set! (foreign-lambda void "al_set_app_name" c-string))

(define system-install (foreign-lambda bool "al_install_system" integer (function integer ((function void (void))))))
(define system-installed? (foreign-lambda bool "al_is_system_installed"))
(define system-driver (foreign-lambda opaque_system "al_get_system_driver"))
(define system-config (foreign-lambda opaque_config "al_get_system_config"))

(define standard-path (foreign-lambda opaque_path "al_get_standard_path" integer))
