#>
#define ALLEGRO_SRC
#ifdef _WIN32
  #define ALLEGRO_MSVC
  #define ALLEGRO_WINDOWS
  #include <allegro5/allegro.h>
  #include <allegro5/allegro_windows.h>
#endif

#include <allegro5/allegro_opengl.h>
<#

(module allegro-opengl *
        (import
         scheme
         (chicken base)
         (chicken foreign)
         allegro)

        (include "opengl")
        (include "transformations")
        (include "gen-opengl"))
