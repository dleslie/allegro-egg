#>
#include <allegro5/allegro.h>
#include <allegro5/allegro_opengl.h>
#ifdef _WIN32
  #include <allegro5/allegro_windows.h>
#endif
<#

(module allegro-glext *
        (import scheme chicken foreign foreigners allegro)
        
        (include "gl_ext_defs")
        (include "gl_ext_api"))
