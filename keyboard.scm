(define keyboard-addon-installed? (foreign-lambda bool "al_is_keyboard_installed"))
(define keyboard-addon-install (foreign-lambda bool "al_install_keyboard"))
(define keyboard-addon-uninstall (foreign-lambda void "al_uninstall_keyboard"))

(define keycode->string (foreign-lambda c-string "al_keycode_to_name" key))

(define keyboard-event-source (foreign-lambda event-source "al_get_keyboard_event_source"))
(define keyboard-led-set! (foreign-lambda bool "al_set_keyboard_leds" integer))

(define keyboard-state-init! (foreign-lambda void "al_get_keyboard_state" keyboard-state))

(define keyboard-state-key-down? (foreign-lambda bool "al_key_down" keyboard-state key))
