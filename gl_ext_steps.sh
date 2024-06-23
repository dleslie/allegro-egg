#! /bin/sh

(echo "typedef void* ptrdiff_t;";
 gcc -DAPIENTRY= -DWINGDIAPI= -Istub -nostdinc -P -E \
     -I/c/Users/dan/OneDrive/bin/w64devkit/x86_64-w64-mingw32/include/ \
     /c/Users/dan/OneDrive/bin/w64devkit/x86_64-w64-mingw32/include/GL/gl.h;
 gcc -DAPIENTRY= -DWINGDIAPI= -Istub -nostdinc -P -E \
     -I/c/Users/dan/OneDrive/bin/w64devkit/x86_64-w64-mingw32/include/ \
     /c/Users/dan/OneDrive/bin/w64devkit/x86_64-w64-mingw32/include/GL/glu.h;) \
| sed -e "s#__[^ _]*__##g" \
| sed -e "s#(([^)]*))##g" \
| grep -v "\\[" \
| sed -e "s#long long#int64_t#g" \
| sed -e "s#unsigned int64_t#uint64_t#g" \
| sed -e "s#(CALLBACK#(#g" \
| grep -v PF \
| grep -v "GLDEBUGPROC" \
| grep -v "^typedef size_t rsize_t;" \
| chicken-bind \
    -o gl.scm \
    -export-constants \
    -rename-regex "^gl(.*)$":"gl:\1" \
    -rename-regex "^GL_?(.*)$":"gl:\1" \
    -default-renaming "" \
	  -
