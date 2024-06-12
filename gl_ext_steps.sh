gcc -DALLEGRO_SRC -D"AL_VAR(type, name) extern type name" -nostdinc -P -E -Istub /c/Users/dan/OneDrive/bin/w64devkit/include/allegro5/opengl/gl_ext.h | grep -v '^# ' - | less > gl_ext_expanded.h
cat gl_ext_expanded.h | sed -e "s#__[^ _]*__##g" | sed -e "s#(([^)]*))##g" | sed -e "s#long long#int64_t#g" | sed -e "s#unsigned int64_t#uint64_t#g" | sed -e "s#typedef.*size_t.*##g" | grep -v PF | grep -v "\\[" | grep -v "extern _ALLEGRO_" > gl_ext.h
chicken-bind -rename-regex "(ALLEGRO_OGL_EXT_API-)":"gl:" gl_ext.h
