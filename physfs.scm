(cond-expand
 (has-allegro-physfs
  (register-feature! 'allegro-physfs)

  #>
  #include <allegro5/allegro_physfs.h>
  <#

  (define enable-physfs-file-interface (foreign-lambda void "al_set_physfs_file_interface"))
  (define physfs-addon-version (foreign-lambda unsigned-integer32 "al_get_allegro_physfs_version")))
 (else #f))
