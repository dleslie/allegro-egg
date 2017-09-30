(cond-expand
 (has-allegro-image
  (register-feature! 'allegro-image)

  #>
  #include <allegro5/allegro_image.h>
  <#
  
  (define image-addon-install (foreign-lambda bool "al_init_image_addon"))
  (define image-addon-uninstall (foreign-lambda void "al_shutdown_image_addon"))
  (define image-addon-version (foreign-lambda unsigned-integer32 "al_get_allegro_image_version")))
 (else #f))
