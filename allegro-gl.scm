#>
#define ALLEGRO_SRC
#ifdef _WIN32
  #define ALLEGRO_MSVC
  #define ALLEGRO_WINDOWS
  #include <allegro5/allegro.h>
  #include <allegro5/allegro_windows.h>
#endif

#include <GL/glu.h>
#include <GL/gl.h>

#include <allegro5/allegro_opengl.h>
<#

(module allegro-glext *
        (import
         scheme
         (chicken base)
         (chicken foreign)
         allegro)

        (include "gl"))
