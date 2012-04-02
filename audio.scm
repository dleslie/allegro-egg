(define make-sample* (foreign-lambda sample "al_create_sample" blob unsigned-integer unsigned-integer audio-depth channel-configuration bool))
(define (make-sample b ui1 ui2 d cc b)
  (let ((snd (make-sample* b ui1 ui2 d cc b)))
    (set-finalizer! snd free-sample!)
    snd))

(define free-sample! (foreign-lambda void "al_destroy_sample" sample))

(define make-sample-instance* (foreign-lambda sample-instance "al_create_sample_instance" sample))
(define (make-sample-instance s)
  (let ((snd (make-sample-instance s)))
    (set-finalizer! snd free-sample-instance!)
    snd))

(define free-sample-instance! (foreign-lambda void "al_destroy_sample_instance" sample-instance))

(define sample-frequency (foreign-lambda unsigned-integer "al_get_sample_frequency" (const sample)))
(define sample-length (foreign-lambda unsigned-integer "al_get_sample_length" (const sample)))
(define sample-depth (foreign-lambda audio-depth "al_get_sample_depth" (const sample)))
(define sample-channels (foreign-lambda channel-configuration "al_get_sample_channels" (const sample)))

(define sample-instance-frequency (foreign-lambda unsigned-integer "al_get_sample_instance_frequency" (const sample-instance)))
(define sample-instance-length (foreign-lambda unsigned-integer "al_get_sample_instance_length" (const sample-instance)))
(define sample-instance-position (foreign-lambda unsigned-integer "al_get_sample_instance_position" (const sample-instance)))

(define sample-instance-speed (foreign-lambda float "al_get_sample_instance_speed" (const sample-instance)))
(define sample-instance-gain (foreign-lambda float "al_get_sample_instance_gain" (const sample-instance)))
(define sample-instance-pan (foreign-lambda float "al_get_sample_instance_pan" (const sample-instance)))
(define sample-instance-time (foreign-lambda float "al_get_sample_instance_time" (const sample-instance)))

(define sample-instance-depth (foreign-lambda audio-depth "al_get_sample_instance_depth" (const sample-instance)))
(define sample-instance-channels (foreign-lambda channel-configuration "al_get_sample_instance_channels" (const sample-instance)))
(define sample-instance-playmode (foreign-lambda playmode "al_get_sample_instance_playmode" (const sample-instance)))

(define sample-instance-playing? (foreign-lambda bool "al_get_sample_instance_playing" (const sample-instance)))
(define sample-instance-attached? (foreign-lambda bool "al_get_sample_instance_attached" (const sample-instance)))

(define sample-instance-position-set! (foreign-lambda bool "al_set_sample_instance_position" sample-instance unsigned-integer32))
(define sample-instance-length-set! (foreign-lambda bool "al_set_sample_instance_length" sample-instance unsigned-integer32))

(define sample-instance-speed-set! (foreign-lambda bool "al_set_sample_instance_speed" sample-instance float))
(define sample-instance-gain-set! (foreign-lambda bool "al_set_sample_instance_gain" sample-instance float))
(define sample-instance-pan-set! (foreign-lambda bool "al_set_sample_instance_pan" sample-instance float))

(define sample-instance-playmode-set! (foreign-lambda bool "al_set_sample_instance_playmode" sample-instance playmode))
(define sample-instance-playing-set! (foreign-lambda bool "al_set_sample_instance_playing" sample-instance bool))
(define sample-instance-detach! (foreign-lambda bool "al_detach_sample_instance" sample-instance))

(define sample-instance-sample-set! (foreign-lambda bool "al_set_sample" sample-instance sample))
(define sample-instance-sample (foreign-lambda sample "al_get_sample" sample-instance))

(define sample-instance-play (foreign-lambda bool "al_play_sample_instance" sample-instance))
(define sample-instance-stop (foreign-lambda bool "al_stop_sample_instance" sample-instance))

(define make-audio-stream* (foreign-lambda audio-stream "al_create_audio_stream" size_t unsigned-integer32 unsigned-integer32 audio-depth channel-configuration))
(define (make-audio-stream sz ui1 ui2 d cc)
  (let ((strm (make-audio-stream* sz ui1 ui2 d cc)))
    (set-finalizer! strm free-audio-stream!)
    strm))

(define free-audio-stream! (foreign-lambda void "al_destroy_audio_stream" audio-stream))

(define audio-stream-drain (foreign-lambda void "al_drain_audio_stream" audio-stream))

(define audio-stream-frequency (foreign-lambda unsigned-integer32 "al_get_audio_stream_frequency" (const audio-stream)))
(define audio-stream-length (foreign-lambda unsigned-integer32 "al_get_audio_stream_length" (const audio-stream)))
(define audio-stream-fragments (foreign-lambda unsigned-integer32 "al_get_audio_stream_fragments" (const audio-stream)))
(define audio-stream-available-fragments (foreign-lambda unsigned-integer32 "al_get_available_audio_stream_fragments" (const audio-stream)))

(define audio-stream-speed (foreign-lambda float "al_get_audio_stream_speed" (const audio-stream)))
(define audio-stream-gain (foreign-lambda float "al_get_audio_stream_gain" (const audio-stream)))

(define audio-stream-channels (foreign-lambda channel-configuration "al_get_audio_stream_channels" (const audio-stream)))
(define audio-stream-depth (foreign-lambda audio-depth "al_get_audio_stream_depth" (const audio-stream)))
(define audio-stream-playmode (foreign-lambda playmode "al_get_audio_stream_playmode" (const audio-stream)))

(define audio-stream-playing? (foreign-lambda bool "al_get_audio_stream_playing" (const audio-stream)))
(define audio-stream-attached? (foreign-lambda bool "al_get_audio_stream_attached" (const audio-stream)))

(define audio-stream-fragment (foreign-lambda c-pointer "al_get_audio_stream_fragment" (const audio-stream)))

(define audio-stream-speed-set! (foreign-lambda bool "al_set_audio_stream_speed" audio-stream float))
(define audio-stream-gain-set! (foreign-lambda bool "al_set_audio_stream_gain" audio-stream float))
(define audio-stream-pan-set! (foreign-lambda bool "al_set_audio_stream_pan" audio-stream float))

(define audio-stream-playmode-set! (foreign-lambda bool "al_set_audio_stream_playmode" audio-stream playmode))

(define audio-stream-playing-set! (foreign-lambda bool "al_set_audio_stream_playing" audio-stream bool))
(define audio-stream-detach! (foreign-lambda bool "al_detach_audio_stream" audio-stream))
(define audio-stream-fragment-set! (foreign-lambda bool "al_set_audio_stream_fragment" audio-stream c-pointer))

(define audio-stream-rewind! (foreign-lambda bool "al_rewind_audio_stream" audio-stream))
(define audio-stream-seek-seconds! (foreign-lambda bool "al_seek_audio_stream_secs" audio-stream double))
(define audio-stream-position-seconds (foreign-lambda double "al_get_audio_stream_position_secs" audio-stream))
(define audio-stream-length-seconds (foreign-lambda double "al_get_audio_stream_length_secs" audio-stream))
(define audio-stream-loop-set! (foreign-lambda bool "al_set_audio_stream_loop_secs" audio-stream double double))

(define audio-stream-event-source (foreign-lambda event-source "al_get_audio_stream_event_source" audio-stream))

(define make-mixer* (foreign-lambda mixer "al_create_mixer" unsigned-integer32 audio-depth channel-configuration))
(define (make-mixer ui d cc)
  (let ((mx (make-mixer* ui d cc)))
    (set-finalizer! mx free-mixer!)
    mx))

(define free-mixer! (foreign-lambda void "al_destroy_mixer" mixer))

(define sample-instance-attach-to-mixer! (foreign-lambda bool "al_attach_sample_instance_to_mixer" sample-instance mixer))
(define audio-stream-attach-to-mixer! (foreign-lambda bool "al_attach_audio_stream_to_mixer" audio-stream mixer))

(define mixer-attach-to-mixer! (foreign-lambda bool "al_attach_mixer_to_mixer" mixer mixer))
(define mixer-postprocess-callback-set! (foreign-lambda bool "al_set_mixer_postprocess_callback" mixer (function void (c-pointer unsigned-integer32 c-pointer)) c-pointer))

(define mixer-frequency (foreign-lambda unsigned-integer32 "al_get_mixer_frequency" (const mixer)))
(define mixer-channels (foreign-lambda channel-configuration "al_get_mixer_channels" (const mixer)))
(define mixer-depth (foreign-lambda audio-depth "al_get_mixer_depth" (const mixer)))
(define mixer-quality (foreign-lambda mixer-quality "al_get_mixer_quality" (const mixer)))

(define mixer-playing? (foreign-lambda bool "al_get_mixer_playing" (const mixer)))
(define mixer-attached? (foreign-lambda bool "al_get_mixer_attached" (const mixer)))
(define mixer-frequency-set! (foreign-lambda bool "al_set_mixer_frequency" mixer unsigned-integer32))
(define mixer-quality-set! (foreign-lambda bool "al_set_mixer_quality" mixer mixer-quality))
(define mixer-playing-set! (foreign-lambda bool "al_set_mixer_playing" mixer bool))
(define mixer-detach! (foreign-lambda bool "al_detach_mixer" mixer))

(define make-voice* (foreign-lambda voice "al_create_voice" unsigned-integer32 audio-depth channel-configuration))
(define (make-voice ui d cc)
  (let ((v (make-voice* ui d cc)))
    (set-finalizer! v free-voice!)
    v))

(define free-voice! (foreign-lambda void "al_destroy_voice" voice))

(define sample-instance-attach-to-voice! (foreign-lambda bool "al_attach_sample_instance_to_voice" sample-instance voice))

(define audio-stream-attach-to-voice! (foreign-lambda bool "al_attach_audio_stream_to_voice" audio-stream voice))
(define mixer-attach-to-voice! (foreign-lambda bool "al_attach_mixer_to_voice" mixer voice))

(define voice-detach! (foreign-lambda void "al_detach_voice" voice))

(define voice-frequency (foreign-lambda unsigned-integer32 "al_get_voice_frequency" (const voice)))
(define voice-position (foreign-lambda unsigned-integer32 "al_get_voice_position" (const voice)))
(define voice-channels (foreign-lambda channel-configuration "al_get_voice_channels" (const voice)))
(define voice-depth (foreign-lambda audio-depth "al_get_voice_depth" (const voice)))
(define voice-playing? (foreign-lambda bool "al_get_voice_playing" (const voice)))
(define voice-position-set! (foreign-lambda bool "al_set_voice_position" voice unsigned-integer32))
(define voice-playing-set! (foreign-lambda bool "al_set_voice_playing" voice bool))

(define audio-addon-install (foreign-lambda bool "al_install_audio"))
(define audio-addon-uninstall (foreign-lambda void "al_uninstall_audio"))
(define audio-addon-installed? (foreign-lambda bool "al_is_audio_installed"))
(define audio-addon-version (foreign-lambda unsigned-integer32 "al_get_allegro_audio_version"))

(define channel-configuration-count (foreign-lambda size_t "al_get_channel_count" channel-configuration))
(define audio-depth-size (foreign-lambda size_t "al_get_audio_depth_size" audio-depth))

(define default-mixer (foreign-lambda mixer "al_get_default_mixer"))
(define default-mixer-set! (foreign-lambda bool "al_set_default_mixer" mixer))
(define default-mixer-restore! (foreign-lambda bool "al_restore_default_mixer"))

(define sample-play! (foreign-lambda bool "al_play_sample" sample float float float playmode sample-id))
(define sample-stop (foreign-lambda void "al_stop_sample" sample-id))

(define reserve-samples (foreign-lambda bool "al_reserve_samples" integer32))
(define stop-all-samples (foreign-lambda void "al_stop_samples"))

(define register-sample-loader (foreign-lambda bool "al_register_sample_loader" (const c-string) (function sample ((const c-string)))))
(define register-sample-saver (foreign-lambda* bool (((const c-string) ext) ((function bool ((const c-string) sample)) saver)) "
C_return(al_register_sample_saver(ext, (bool (*)(const char *filename, ALLEGRO_SAMPLE *spl))saver));"))

(define register-audio-stream-loader (foreign-lambda bool "al_register_audio_stream_loader" (const c-string) (function audio-stream ((const c-string) size_t unsigned-integer32))))

(define register-sample-file-loader (foreign-lambda bool "al_register_sample_loader_f" (const c-string) (function sample (file))))
(define register-sample-file-saver (foreign-lambda* bool (((const c-string) ext) ((function bool (file sample)) saver)) "
C_return(al_register_sample_saver_f(ext, (bool (*)(ALLEGRO_FILE *fp, ALLEGRO_SAMPLE *spl))saver));"))

(define register-audio-stream-file-loader (foreign-lambda bool "al_register_audio_stream_loader_f" (const c-string) (function audio-stream (file size_t unsigned-integer32))))

(define load-sample* (foreign-lambda sample "al_load_sample" (const c-string)))
(define (load-sample str)
  (let ((s (load-sample* str)))
    (set-finalizer! s free-sample!)
    s))

(define load-audio-stream* (foreign-lambda audio-stream "al_load_audio_stream" (const c-string) size_t unsigned-integer32))
(define (load-audio-stream str s ui)
  (let ((stm (load-audio-stream* str s ui)))
    (set-finalizer! stm free-audio-stream!)
    stm))

(define load-audio-stream-from-file* (foreign-lambda audio-stream "al_load_audio_stream_f" file (const c-string) size_t unsigned-integer32))
(define (load-audio-stream-from-file f str sz ui)
  (let ((stm (load-audio-stream-from-file* f str sz ui)))
    (set-finalizer! stm free-audio-stream!)
    stm))

(define load-sample-from-file* (foreign-lambda sample "al_load_sample_f" file (const c-string)))
(define (load-sample-from-file f str)
  (let ((smpl (load-sample-from-file* f str)))
    (set-finalizer! smpl free-sample!)
    smpl))

(define (sample-save-to-file s f i) ((foreign-lambda bool "al_save_sample_f" file (const c-string) sample) f i s))
(define (sample-save s f) ((foreign-lambda bool "al_save_sample" (const c-string) sample) f s))

