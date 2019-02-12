#>
#include <allegro5/allegro.h>
#include <allegro5/allegro_opengl.h>
#ifdef _WIN32
  #include <allegro5/allegro_windows.h>
#endif
<#

(module allegro-glext *
        (import
         scheme
         (chicken base)
         (chicken foreign)
         allegro)

        (include "gl_ext_defs")
        (include "gl_ext_api"))
