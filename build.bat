FOR /F %%i IN ('pkg-config --cflags allegro-5 allegro_image-5 allegro_primitives-5 allegro_color-5 allegro_dialog-5 allegro_main-5 allegro_physfs-5 allegro_font-5 allegro_ttf-5 allegro_audio-5 allegro_memfile-5 allegro_acodec-5 allegro_image-5') DO set CFLAGS=%%i

FOR /F %%i IN ('pkg-config --libs allegro-5 allegro_image-5 allegro_primitives-5 allegro_color-5 allegro_dialog-5 allegro_main-5 allegro_physfs-5 allegro_font-5 allegro_ttf-5 allegro_audio-5 allegro_memfile-5 allegro_acodec-5 allegro_image-5') DO set LDFLAGS=%%i

IF "%LDFLAGS%"=="" SET LDFLAGS="-L -lallegro_primitives -L -lallegro_color -L -lallegro_dialog -L -lallegro_main -L -lallegro_physfs -L -lallegro_ttf -L -lallegro_font -L -lallegro_memfile -L -lallegro_acodec -L -lallegro_audio -L -lallegro_image -L -lallegro"

csc -s -d1 -O3 -J -C "-O3 %CFLAGS%" "%LDFLAGS%" -Dhas-allegro-primitives -Dhas-allegro-color -Dhas-allegro-dialog    -Dhas-allegro-main -Dhas-allegro-physfs -Dhas-allegro-font -Dhas-allegro-ttf -Dhas-allegro-audio -Dhas-allegro-memfile  -Dhas-allegro-acodec -Dhas-allegro-image %*
