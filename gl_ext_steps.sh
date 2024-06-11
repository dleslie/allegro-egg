gcc -fdirectives-only -DALLEGRO_UNSTABLE -E /c/Users/dan/OneDrive/bin/w64devkit/include/allegro5/opengl/gl_ext.h | grep -v '^# ' - | less > gl_ext_expanded.h
cat gl_ext_expanded.h | sed -e "s#__[^ _]*__##g" | sed -e "s#(([^)]*))##g" | sed -e "s#long long#int64_t#g" | sed -e "s#unsigned int64_t#uint64_t#g" | sed -e "s#typedef.*size_t.*##g" > gl_ext.h
