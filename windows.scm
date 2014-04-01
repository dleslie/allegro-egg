(cond-expand
 (windows 
  (define windows-window-handle (foreign-lambda c-pointer "al_get_win_window_handle" display)))
 (else #f))
