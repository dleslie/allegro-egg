#>
#include <allegro5/allegro.h>
#include <allegro5/allegro_acodec.h>
#include <allegro5/allegro_audio.h>
#include <allegro5/allegro_color.h>
#include <allegro5/allegro_color.h>
#include <allegro5/allegro_font.h>
#include <allegro5/allegro_opengl.h>
#include <allegro5/allegro_primitives.h>
#include <allegro5/allegro_ttf.h>
#ifdef _WIN32
#include <allegro5/allegro_windows.h>
#endif
<#

(module allegro *
        (import scheme chicken foreign foreigners)

        (include "types")
        (include "enums")
        (include "constants")

        (include "base")
        (include "windows")
        (include "acodec")
        (include "fixed")
        (include "tls")
        (include "altime")
        (include "direct3d")
        (include "fmaths")
        (include "memory")
        (include "error")
        (include "bitmap_io")
        (include "system")
        (include "timer")
        (include "joystick")
        (include "transformations")
        (include "keyboard")
        (include "threads")
        (include "memfile")
        (include "physfs")
        (include "fshook")
        (include "image")
        (include "ttf")
        (include "path")
        (include "config")
        (include "mouse")
        (include "file")
        (include "color")
        (include "display")
        (include "events")
        (include "bitmap")
        (include "font")
        (include "utf8")
        (include "opengl")
        (include "primitives")
        (include "audio")
	)
