(define joystick/max-axes (foreign-value "_AL_MAX_JOYSTICK_AXES" integer))
(define joystick/max-sticks (foreign-value "_AL_MAX_JOYSTICK_STICKS" integer))
(define joystick/max-buttons (foreign-value "_AL_MAX_JOYSTICK_BUTTONS" integer))

(define display/default-adapter (foreign-value "ALLEGRO_DEFAULT_DISPLAY_ADAPTER" integer))
