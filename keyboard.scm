(define keyboard-addon-installed? (foreign-lambda bool "al_is_keyboard_installed"))
(define keyboard-addon-install (foreign-lambda bool "al_install_keyboard"))
(define keyboard-addon-uninstall (foreign-lambda void "al_uninstall_keyboard"))

(define keycode->string (foreign-lambda c-string "al_keycode_to_name" key))

(define keyboard-event-source (foreign-lambda (c-pointer event-source) "al_get_keyboard_event_source"))
(define keyboard-led-set! (foreign-lambda bool "al_set_keyboard_leds" integer))

(define make-keyboard-state* (foreign-safe-lambda* keyboard-state () "
ALLEGRO_KEYBOARD_STATE *ret_state = (ALLEGRO_KEYBOARD_STATE *)C_malloc(sizeof(ALLEGRO_KEYBOARD_STATE));
al_get_keyboard_state(ret_state);
C_return(ret_state);
"))
(define (make-keyboard-state)
  (let ((state (make-keyboard-state*)))
    (set-finalizer! state free-keyboard-state!)
    state))

(define keyboard-state-key-down? (foreign-lambda bool "al_key_down" keyboard-state key))

(cond-expand
 (windows 
  (define keyboard-three-finger-flag? (foreign-value "_al_three_finger_flag" bool))
  (define keyboard-led-flag? (foreign-value "_al_key_led_flag" bool)))
 (else '()))
