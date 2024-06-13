#! /bin/sh

gcc -DALLEGRO_UNSTABLE -D"AL_VAR(type, name) extern type name" \
    -nostdinc -P -E -Istub /c/Users/dan/OneDrive/bin/w64devkit/include/allegro5/opengl/gl_ext.h \
| grep -v '^# ' - \
| sed -e "s#__[^ _]*__##g" \
| sed -e "s#(([^)]*))##g" \
| sed -e "s#long long#int64_t#g" \
| sed -e "s#unsigned int64_t#uint64_t#g" \
| sed -e "s#typedef.*size_t.*##g" \
| sed -e "s#\(^typedef *\([^(]*\)( *\\* *\([^)]*\))\(.*\);\)#\2\3\4;#g" \
| grep -v PF \
| grep -v "\\[" \
| grep -v "extern _ALLEGRO_" \
| grep -v "glRectxvOES" \
| grep -v "glLoadMatrixxOES" \
| grep -v "glMultMatrixxOES" \
| grep -v "glLoadTransposeMatrixxOES" \
| grep -v "glMultTransposeMatrixxOES" \
| grep -v "glQueryMatrixxOES" \
| chicken-bind \
    -o glext.scm \
    -export-constants \
    -rename-regex "_ALLEGRO_gl(.*)_t":"gl:\1" \
    -rename-regex "(ALLEGRO_OGL_EXT_API-)":"gl-ext-api:" \
    -rename-regex "(ALLEGRO_OGL_EXT_LIST-)":"gl-ext-list:" \
    -rename-regex "(ALLEGRO_GL_ARB_)":"arb:" \
    -rename-regex "(ALLEGRO_GL_NV_)":"nv:" \
    -rename-regex "(ALLEGRO_GL_SGIX_)":"sgix:" \
    -rename-regex "(ALLEGRO_GL_SUN_)":"sun:" \
    -rename-regex "(ALLEGRO_GL_SGIS_)":"sgis:" \
    -rename-regex "(ALLEGRO_GL_EXT_)":"ext:" \
    -rename-regex "(ALLEGRO_GL_HP_)":"hp:" \
    -rename-regex "(ALLEGRO_GL_WIN_)":"win:" \
    -rename-regex "(ALLEGRO_GL_IBM_)":"ibm:" \
    -rename-regex "(ALLEGRO_GL_SGI_)":"sgi:" \
    -rename-regex "(ALLEGRO_GL_PGI_)":"pgi:" \
    -rename-regex "(ALLEGRO_GL_INTEL_)":"intel:" \
    -rename-regex "(ALLEGRO_GL_APPLE_)":"apple:" \
    -default-renaming "" \
	  -

cat /c/Users/dan/OneDrive/bin/w64devkit/include/allegro5/opengl/GLext/gl_ext_defs.h \
| grep -v typedef \
| chicken-bind \
   -rename-regex "(GL_)":"gl:" \
   -default-renaming "" \
   -export-constants \
   -o glext_defs.scm -

