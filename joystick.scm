(define joystick-install (foreign-lambda bool "al_install_joystick"))
(define joystick-uninstall (foreign-lambda void "al_uninstall_joystick"))
(define joystick-installed? (foreign-lambda bool "al_is_joystick_installed"))
(define joystick-reconfigure (foreign-lambda bool "al_reconfigure_joysticks"))

(define joystick-count (foreign-lambda int "al_get_num_joysticks"))
(define joystick-joystick (foreign-lambda joystick "al_get_joystick" integer))
(define joystick-release (foreign-lambda void "al_release_joystick" joystick))
(define joystick-active? (foreign-lambda bool "al_get_joystick_active" joystick))
(define joystick-name (foreign-lambda c-string "al_get_joystick_name" joystick))

(define joystick-axes-count (foreign-lambda int "al_get_joystick_num_axes" joystick int))
(define joystick-axis-name (foreign-lambda c-string "al_get_joystick_axis_name" joystick int int))
(define joystick-button-count (foreign-lambda int "al_get_joystick_num_buttons" joystick))
(define joystick-button-name (foreign-lambda int "al_get_joystick_button_name" joystick int))

(define joystick-state! (foreign-lambda* void ((joystick-state state) (joystick j)) "al_get_joystick_state(j, state);"))

(define joystick-event-source (foreign-lambda (c-pointer event-source) "al_get_joystick_event_source"))

(define joystick-state-axis (foreign-lambda* float ((joystick-state jstate) (int which_stick) (int which_axis)) "
if (which_stick < 0 || which_stick >= _AL_MAX_JOYSTICK_STICKS || which_axis < 0 || which_axis >= _AL_MAX_JOYSTICK_AXES)
  C_return(C_SCHEME_FALSE);
else
  C_return(jstate->stick[which_stick].axis[which_axis]);
")) 
