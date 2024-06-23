#! /bin/sh

(echo "typedef intptr_t ptrdiff_t;";
 cat /c/Users/dan/OneDrive/bin/w64devkit/x86_64-w64-mingw32/include/GL/gl.h \
     | grep typedef \
     | grep -v "typedef void (";
 cat /c/Users/dan/OneDrive/bin/w64devkit/x86_64-w64-mingw32/include/GL/gl.h \
     | grep \#define\ GL;
 cat /c/Users/dan/OneDrive/bin/w64devkit/include/allegro5/opengl/GLext/gl_ext_defs.h \
     | grep -v typedef;
 gcc -DAPIENTRY= -DWINGDIAPI= -Istub -nostdinc -P -E \
     /c/Users/dan/OneDrive/bin/w64devkit/x86_64-w64-mingw32/include/GL/gl.h;
 gcc -DALLEGRO_UNSTABLE -D"AL_VAR(type, name) extern type name" \
     -nostdinc -P -E -Istub \
     /c/Users/dan/OneDrive/bin/w64devkit/include/allegro5/opengl/gl_ext.h) \
| grep -v '^# ' - \
| sed -e "s#__[^ _]*__##g" \
| sed -e "s#(([^)]*))##g" \
| sed -e "s#long long#int64_t#g" \
| sed -e "s#unsigned int64_t#uint64_t#g" \
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
    -o gl.scm \
    -export-constants \
    -rename-regex "_ALLEGRO_gl(.*)_t":"\1" \
    -rename-regex "(ALLEGRO_OGL_EXT_API-)":"ext-api:" \
    -rename-regex "(ALLEGRO_OGL_EXT_LIST-)":"ext-list:" \
    -rename-regex "ALLEGRO_GL_(.*)":"\1" \
    -rename-regex "^GL_?(.*)$":"\1" \
    -rename-regex "^gl(.*)$":"\1" \
    -default-renaming "" \
	  -
