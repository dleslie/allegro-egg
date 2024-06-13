#>
#define ALLEGRO_SRC
#ifdef _WIN32
  #define ALLEGRO_MSVC
  #include <allegro5/allegro.h>
  #include <allegro5/allegro_windows.h>
#endif

#include <allegro5/allegro_opengl.h>
<#

(module allegro-glext *
        (import
         scheme
         (chicken base)
         (chicken foreign)
         allegro)

        (include "glext_defs")
        (include "glext"))
