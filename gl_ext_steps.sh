gcc -DALLEGRO_SRC -D"AL_VAR(type, name) extern type name" -nostdinc -P -E -Istub /c/Users/dan/OneDrive/bin/w64devkit/include/allegro5/opengl/gl_ext.h | grep -v '^# ' - | less > gl_ext_expanded.h
cat gl_ext_expanded.h | sed -e "s#__[^ _]*__##g" | sed -e "s#(([^)]*))##g" | sed -e "s#long long#int64_t#g" | sed -e "s#unsigned int64_t#uint64_t#g" | sed -e "s#typedef.*size_t.*##g" | grep -v PF | grep -v "\\[" | grep -v "extern _ALLEGRO_" > gl_ext.h
chicken-bind \
	-rename-regex "(ALLEGRO_OGL_EXT_API-)":"ogl:" \
	-rename-regex "(ALLEGRO_OGL_EXT_LIST-)":"ogl-ext-list:" \
	-rename-regex "(ALLEGRO_GL_ARB_)":"arb:" \
	-rename-regex "(ALLEGRO_GL_NV_)":"gl-nv:" \
	-rename-regex "(ALLEGRO_GL_SGIX_)":"gl-sgix:" \
	-rename-regex "(ALLEGRO_GL_SUN_)":"gl-sun:" \
	-rename-regex "(ALLEGRO_GL_SGIS_)":"gl-sgis:" \
	-rename-regex "(ALLEGRO_GL_EXT_)":"gl-ext:" \
	-rename-regex "(ALLEGRO_GL_HP_)":"gl-hp:" \
	-rename-regex "(ALLEGRO_GL_WIN_)":"gl-win:" \
	-rename-regex "(ALLEGRO_GL_IBM_)":"gl-ibm:" \
	-rename-regex "(ALLEGRO_GL_SGI_)":"gl-sgi:" \
	-rename-regex "(ALLEGRO_GL_PGI_)":"gl-pgi:" \
	-rename-regex "(ALLEGRO_GL_INTEL_)":"gl-intel:" \
	-rename-regex "(ALLEGRO_GL_APPLE_)":"gl-apple:" \
	gl_ext.h
