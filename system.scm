(define init (foreign-lambda bool "al_init"))
(define inhibit-screensaver (foreign-lambda bool "al_inhibit_screensaver" bool))

(define org-name (foreign-lambda c-string "al_get_org_name"))
(define org-name-set! (foreign-lambda void "al_set_org_name" c-string))

(define app-name (foreign-lambda c-string "al_get_app_name"))
(define app-name-set! (foreign-lambda void "al_set_app_name" c-string))

(define system-addon-uninstall (foreign-lambda void "al_uninstall_system"))
(define system-addon-installed? (foreign-lambda bool "al_is_system_installed"))

(define system-driver (foreign-lambda system "al_get_system_driver"))
(define system-config (foreign-lambda config "al_get_system_config"))

(define standard-path (foreign-lambda path "al_get_standard_path" system-path))
