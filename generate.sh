#! /bin/sh

# allegro_opengl
((
    echo "typedef void* ptrdiff_t;";
    echo "#define AL_FUNC(ret, name, params) ret name params";
    echo "#define AL_VAR(type, name) extern type name";
    echo "#define ALLEGRO_UNSTABLE";
    echo "#define APIENTRY";
    echo "#define WINGDIAPI";
    echo "#define AGL_API(ret, name, args) ret _al_gl##name args;";
    cat /c/Users/dan/OneDrive/bin/w64devkit/x86_64-w64-mingw32/include/GL/gl.h;
    cat /c/Users/dan/OneDrive/bin/w64devkit/x86_64-w64-mingw32/include/GL/glu.h;
    cat /c/Users/dan/OneDrive/bin/w64devkit/include/allegro5/opengl/GLext/gl_ext_defs.h;
    cat /c/Users/dan/OneDrive/bin/w64devkit/include/allegro5/opengl/GLext/gl_ext_api.h;
) \
    | sed -e "s#char const *#const char *#g" \
    | gcc -Istub -nostdinc -P -E -;
)\
| sed -e "s#__[^ _]*__##g" \
| sed -e "s#(([^)]*))##g" \
| grep -v "\\[" \
| sed -e "s#long long#int64_t#g" \
| sed -e "s#unsigned int64_t#uint64_t#g" \
| sed -e "s#(CALLBACK#(#g" \
| grep -v PF \
| grep -v "GLDEBUGPROC" \
| grep -v "^typedef size_t rsize_t;" \
| sed -e "s#^typedef enum .* \(.*\);#typedef int \1;#g" \
| sed -e "s#typedef enum ALLEGRO_OPENGL_VARIANT {#enum ALLEGRO_OPENGL_VARIANT {#g" \
| sed -e "s#} ALLEGRO_OPENGL_VARIANT;#};#g" \
| sed -e "s#_al_gl#gl#g" \
| chicken-bind \
    -o gen-opengl.scm \
    -export-constants \
    -rename-regex "^gl(.*)$":"gl:\1" \
    -rename-regex "^GL_?(.*)$":"gl:\1" \
    -rename-regex "^ALLEGRO_(.*)$":"al:\1" \
    -rename-regex "^AL_(.*)$":"al:\1" \
    -rename-regex "^al_(.*)$":"al:\1" \
    -rename-regex "_al_gl":"gl:" \
    -default-renaming "" \
	  -

(cat /c/Users/dan/OneDrive/bin/w64devkit/x86_64-w64-mingw32/include/GL/gl.h;
 cat /c/Users/dan/OneDrive/bin/w64devkit/include/allegro5/opengl/GLext/gl_ext_defs.h) \
    | grep "#define GL_.* 0x.*" \
    | chicken-bind \
          -o gen-opengl-defs.scm \
          -export-constants \
          -rename-regex "^gl(.*)$":"gl:\1" \
          -rename-regex "^GL_?(.*)$":"gl:\1" \
          -rename-regex "^ALLEGRO_(.*)$":"al:\1" \
          -rename-regex "^AL_(.*)$":"al:\1" \
          -rename-regex "^al_(.*)$":"al:\1" \
          -default-renaming "" \
	        -

